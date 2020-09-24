import Flutter
import UIKit

public class MomoHandler: NSObject {
    
    private var result: FlutterResult?
    
    public func handlePayment(arguments: Any?, result: @escaping FlutterResult) {
        self.result = result
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "NoficationCenterTokenReceived"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.NoficationCenterTokenReceived), name: NSNotification.Name(rawValue: "NoficationCenterTokenReceived"), object: nil)
        
        let paymentinfo = arguments as! NSMutableDictionary
        MoMoPayment.createPaymentInformation(info: paymentinfo)
        MoMoPayment.requestToken()
    }
    
    @objc func NoficationCenterTokenReceived(notif: NSNotification) {
        let response: NSMutableDictionary = notif.object! as! NSMutableDictionary
        let result: NSMutableDictionary = parseResultData(data: response)
        self.result?(result)
    }
    
    private func parseResultData(data: NSMutableDictionary) -> NSMutableDictionary {
        let result = NSMutableDictionary()
        result["isSuccess"] = false
        let _statusStr = "\(data["status"] as! String)"
        if (_statusStr == "0") {
            result["isSuccess"] = true
            result["token"] = data["data"]
            result["phoneNumber"] = data["phonenumber"]
        }
        return result
    }
}
