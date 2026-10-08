import background_locator_2
import Flutter
import path_provider_ios
import UIKit

func registerPlugins(registry: FlutterPluginRegistry) {
    GeneratedPluginRegistrant.register(with: registry)
}

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate  {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication
            .LaunchOptionsKey: Any]?
    ) -> Bool {
        BackgroundLocatorPlugin.setPluginRegistrantCallback(registerPlugins)

        registerOtherPlugins()

        return super
            .application(application,
                         didFinishLaunchingWithOptions: launchOptions)
    }

    func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    }

    func registerOtherPlugins() {
        if !hasPlugin("io.flutter.plugins.pathprovider") {
            FLTPathProviderPlugin
                .register(with: registrar(forPlugin: "io.flutter.plugins.pathprovider")!)
        }
    }
}
