import UIKit

extension UITextView {
    func setPaddingPoints(_ amount: CGFloat = 12) {
        self.textContainerInset = UIEdgeInsets(top: amount, left: amount, bottom: amount, right: amount)
    }
}
