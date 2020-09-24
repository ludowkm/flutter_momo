package vn.wakumo.flutter_momo

import android.app.Activity
import android.content.Intent
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import vn.momo.momo_partner.AppMoMoLib


class MomoHandler : PluginRegistry.ActivityResultListener {

    private lateinit var result: MethodChannel.Result

    @Suppress("UNCHECKED_CAST")
    fun handlePayment(activity: Activity?, arguments: Any, result: MethodChannel.Result) {
        this.result = result

        AppMoMoLib.getInstance().setAction(AppMoMoLib.ACTION.PAYMENT)
        AppMoMoLib.getInstance().setActionType(AppMoMoLib.ACTION_TYPE.GET_TOKEN)

        val paymentInfo = arguments as HashMap<String, Any>
        val isTestMode: Boolean = paymentInfo["isTestMode"] as Boolean

        if (isTestMode) {
            AppMoMoLib.getInstance().setEnvironment(AppMoMoLib.ENVIRONMENT.DEVELOPMENT)
        } else {
            AppMoMoLib.getInstance().setEnvironment(AppMoMoLib.ENVIRONMENT.PRODUCTION)
        }

        AppMoMoLib.getInstance().requestMoMoCallBack(activity, paymentInfo)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode == AppMoMoLib.getInstance().REQUEST_CODE_MOMO && resultCode == Activity.RESULT_OK) {
            result.success(parseResultData(data))
        }
        return true
    }

    private fun parseResultData(data: Intent?): Map<String, Any> {
        val result = HashMap<String, Any>()
        result["isSuccess"] = false
        if (data == null) {
            return result
        }
        when (data.getIntExtra("status", -1)) {
            0 -> {
                result["isSuccess"] = true
                result["token"] = data.getStringExtra("data")
                result["phoneNumber"] = data.getStringExtra("phonenumber")
            }
            1 -> {
                result["message"] = data.getStringExtra("message")
            }
            else -> {
            }
        }
        return result
    }
}