//
//  UIApplication+Extension.swift
//  Swift-TodoNotes
//
//

import UIKit

extension UIApplication {
    ///
    /// The func is `topViewController` which is used to get topViewController
    ///  A UIApplication extension's `topViewController` method
    ///
    class func topViewController(base: UIViewController? = UIApplication.shared.windows[0].rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        } else if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
