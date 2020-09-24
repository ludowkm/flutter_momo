import Flutter
import UIKit

public class SwiftFlutterMomoPlugin: NSObject, FlutterPlugin {
    
    private var handler = MomoHandler()
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_momo", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterMomoPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if (call.method == "requestPayment") {
            self.handler.handlePayment(arguments: call.arguments, result: result)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
}
