
import UIKit

extension UIImage {
    func withTintColor(_ color: UIColor, alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIRectFill(rect)
        self.draw(in: rect, blendMode: .destinationIn, alpha: alpha)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage
    }
}
