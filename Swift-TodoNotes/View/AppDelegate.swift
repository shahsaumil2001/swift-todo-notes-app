//
//  AppDelegate.swift
//
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appCoordinator = MainAppCoordinator.shared
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // IQKeyboard Configuration
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        // Configuration for window setup
        self.setupWindow()
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        CoreDataManager.shared.saveContext()
    }
}
extension AppDelegate {
    ///
    /// The func is `setupWindow` will setup initial window
    ///  A AppDelegate's `setupWindow` method
    ///
    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appCoordinator.rootNavigationController
        window?.makeKeyAndVisible()
        // Apply Dark theme
        window?.overrideUserInterfaceStyle = .dark
        // Start main coordinator for navigation
        appCoordinator.start()
    }

}
