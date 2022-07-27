import UIKit

enum Font: String {
    
    // MARK: Properties
    case regular = "Montserrat-Regular"
    case medium = "Montserrat-Medium"
    case semiBold = "Montserrat-SemiBold"
    case bold = "Montserrat-Bold"
    case black = "Montserrat-Black"
    
    // MARK: Additional Helpers
    func size(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
}

enum FontSize: CGFloat {
    case large1 = 30.0
    case large2 = 28.0
    case header1 = 22.0
    case header2 = 20.0
    case header3 = 18.0
    case body = 16.0
    case small = 14.0
    case tiny = 12.0
    case mini = 10.0
    case nano = 8.0
}
