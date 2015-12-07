import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)

        if NSProcessInfo.processInfo().environment["XCInjectBundle"] != nil { return true }

        window!.rootViewController = ViewController()
        window!.makeKeyAndVisible()

        return true
    }
}