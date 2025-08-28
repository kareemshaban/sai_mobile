import Flutter
import UIKit
import WebKit

public class WebViewTouchControlPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "webview_touch_control", binaryMessenger: registrar.messenger())
    let instance = WebViewTouchControlPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let window = UIApplication.shared.windows.first,
          let rootView = window.rootViewController?.view else {
      result(FlutterError(code: "NO_VIEW", message: "Could not get root view", details: nil))
      return
    }

    if call.method == "disableWebViewTouch" {
      self.setWebViewTouch(in: rootView, enabled: false)
      result(nil)
    } else if call.method == "ableWebViewTouch" {
      self.setWebViewTouch(in: rootView, enabled: true)
      result(nil)
    } else {
      result(FlutterMethodNotImplemented)
    }
  }

  private func setWebViewTouch(in view: UIView, enabled: Bool) {
    for subview in view.subviews {
      if let webView = subview as? WKWebView {
        webView.isUserInteractionEnabled = enabled
      } else {
        setWebViewTouch(in: subview, enabled: enabled)
      }
    }
  }
}
