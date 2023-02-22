import UIKit
import Flutter
import GoogleMaps
import zpdk

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyAx4ShtCwVk8_WDBBt_wzGcDJar-lFynJQ")
    GeneratedPluginRegistrant.register(with: self)
    ZaloPaySDK.sharedInstance()?.initWithAppId(2553, uriScheme: "demozpdk://app", environment: .sandbox) ///NOTE: If you want to use production, replace .sandbox with .production
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
          return ZaloPaySDK.sharedInstance().application(app, open:url, sourceApplication: "vn.com.vng.zalopay", annotation:nil)
      }
}