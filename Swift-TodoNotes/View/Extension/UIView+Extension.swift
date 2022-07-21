
import UIKit

extension UIView {
    static var staticIdentifier: String {
        return String(describing: self)
    }

    static func instanceFromNib() -> UIView? {
        return UINib(nibName: staticIdentifier, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }

    func cornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    ///
    /// The extension is `borderColor` which is used to add borderColor to View
    /// A View extension's `borderColor` method
    func borderColor(width: CGFloat, color: UIColor, clipToBounds: Bool = true) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.clipsToBounds = clipToBounds
    }
    ///
    /// The extension is `roundedView` which is used to round View
    /// A View extension's `roundedView` method
    func roundedView(clipsToBounds: Bool = true) {
        self.clipsToBounds = clipsToBounds
        self.layer.cornerRadius = self.bounds.size.height / 2
    }
    ///
    /// The extension is `roundCorners` which is used to round corner
    /// A View extension's `roundCorners` method
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    ///
    /// The extension is `addShadow` which is used to add Shadow to View
    /// A View extension's `addShadow` method
    func addShadow(shadowColor: CGColor = UIColor.black.cgColor, shadowOffset: CGSize = CGSize(width: 0, height: 1), shadowOpacity: Float = 1, shadowRadius: CGFloat = 5, cornerRadius: CGFloat = 2) {
        self.layer.shadowColor = shadowColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.cornerRadius = cornerRadius
    }

    ///
    /// The extension is `addCornerRadiusWithShadow` which is used to corner with shadow
    /// A View extension's `addCornerRadiusWithShadow` method
    func addCornerRadiusWithShadow(color: UIColor, borderColor: UIColor, cornerRadius: CGFloat) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 6.0
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = false
    }

    func setCornerRadiusWith(radius: Float, borderWidth: Float, borderColor: UIColor) {
        self.layer.cornerRadius = CGFloat(radius)
        self.layer.borderWidth = CGFloat(borderWidth)
        self.layer.borderColor = borderColor.cgColor
        self.layer.masksToBounds = true
    }
    class func fromNib(named: String? = nil) -> Self {
        let name = named ?? "\(Self.self)"
        guard
            let nib = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        else { fatalError("missing expected nib named: \(name)") }
        guard
            let view = nib.first as? Self
        else { fatalError("view of type \(Self.self) not found in \(nib)") }
        return view
    }
}
