import UIKit

extension UITextView {
    ///
    /// The extension is `setPaddingPoints` set padding of TextView
    /// A UITextView extension's `setPaddingPoints` method
    func setPaddingPoints(_ amount: CGFloat = 12) {
        self.textContainerInset = UIEdgeInsets(top: amount, left: amount, bottom: amount, right: amount)
    }
}
