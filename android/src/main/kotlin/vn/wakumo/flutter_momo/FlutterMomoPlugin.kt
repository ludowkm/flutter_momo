package vn.wakumo.flutter_momo

import android.app.Activity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar


/** FlutterMomoPlugin */
public class FlutterMomoPlugin(registrar: Registrar? = null) : FlutterPlugin, MethodCallHandler, ActivityAware {

    private val handler = MomoHandler()
    private lateinit var channel: MethodChannel

    private var activity: Activity? = null

    init {
        onRegisterActivityResultListener(registrar)
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        onAttachedToEngine(flutterPluginBinding.binaryMessenger)
    }

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val instance = FlutterMomoPlugin(registrar)
            instance.onAttachedToEngine(registrar.messenger())
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "requestPayment") {
            handler.handlePayment(activity, call.arguments, result)
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        activity = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        onRegisterActivityResultListener(binding)
    }

    override fun onDetachedFromActivity() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onRegisterActivityResultListener(binding)
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

    private fun onAttachedToEngine(messenger: BinaryMessenger) {
        channel = MethodChannel(messenger, "flutter_momo")
        channel.setMethodCallHandler(this)
    }

    private fun onRegisterActivityResultListener(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(handler)
    }

    private fun onRegisterActivityResultListener(registrar: Registrar?) {
        activity = registrar?.activity()
        registrar?.addActivityResultListener(handler)
    }
}
