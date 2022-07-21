import UIKit

extension UIColor {

    class var appPrimary: UIColor {
        let color = 0x000000
        return UIColor.rgb(fromHex: color)
    }

    class var appSecondary: UIColor {
        let color = 0x1C1C1E
        return UIColor.rgb(fromHex: color)
    }

    class var appWhite: UIColor {
        let color = 0xFFFFFF
        return UIColor.rgb(fromHex: color)
    }

    class var appGray: UIColor {
        let color = 0xD1D1D6
        return UIColor.rgb(fromHex: color)
    }

    class var appBlue: UIColor {
        let color = 0x0983FD
        return UIColor.rgb(fromHex: color)
    }

    class func rgb(fromHex: Int) -> UIColor {

        let red =   CGFloat((fromHex & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((fromHex & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(fromHex & 0x0000FF) / 0xFF
        let alpha = CGFloat(1.0)

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
