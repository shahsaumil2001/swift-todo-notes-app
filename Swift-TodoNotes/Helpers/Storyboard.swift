import UIKit

enum Storyboard: String {
    case main = "Main"

    /// A convenient, type-safe way to instantiate a view controller from a storyboard.
    ///
    /// Requires that the view controllers storyboard identifier be identical to its class name.
    func instantiate<T: UIViewController>(viewController type: T.Type) -> T? {
        let identifier = String(describing: type)
        let storyboard = UIStoryboard(name: rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as? T
    }
    func initial<T: UIViewController>() -> T? {
        let storyboard = UIStoryboard(name: rawValue, bundle: nil)
        return storyboard.instantiateInitialViewController() as? T
    }
}
