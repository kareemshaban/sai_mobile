import UIKit
import Flutter
import FirebaseCore
import FBSDKCoreKit
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate {
    private var methodChannel: FlutterMethodChannel?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        FirebaseApp.configure()
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        }

        GeneratedPluginRegistrant.register(with: self)

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    }
/// ✅ Define this class in the same file (below AppDelegate)
//class MyStreamHandler: NSObject, FlutterStreamHandler {
//
//  var eventSink: FlutterEventSink?
//
//  func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
//    print("iOS onListen triggered")
//    self.eventSink = events
//
//    // Example: send a test event
//
//
//    return nil
//  }
//
//  func onCancel(withArguments arguments: Any?) -> FlutterError? {
//    print("iOS onCancel triggered")
//    self.eventSink = nil
//    return nil
//  }
//}