//
//  UIViewController+Extension.swift
//  Swift-TodoNotes
//
//  Created by Saumil Shah on 25/08/23.
//

import UIKit

typealias AlertOkCompletion = (_ okPressed: Bool) -> Void
extension UIViewController {
    ///
    /// The func is `showAlert` is used to show alert
    ///  A UIViewController extension's `showAlert` method
    ///
    func showAlert(title: String = StringConstants.myNotes, message: String, okButtonText: String, alertCompletion: @escaping AlertOkCompletion) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: StringConstants.cancel, style: UIAlertAction.Style.destructive, handler: nil))
        alert.addAction(UIAlertAction(title: okButtonText, style: UIAlertAction.Style.default, handler: {_ in
            alertCompletion(true)
        }))
        // show the alert
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)

    }
}
