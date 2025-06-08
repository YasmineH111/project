import UIKit
import Flutter
import GoogleMaps // Add this import

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Provide the Google Maps API key
    GMSServices.provideAPIKey("AIzaSyAufna1nNQ1ZAE5XB0QmS-xWbucRQWckTM")

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
