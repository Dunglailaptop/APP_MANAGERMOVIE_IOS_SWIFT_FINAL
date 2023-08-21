import UIKit

extension UILabel {
    func configureWith(text: String, color: UIColor, alignment: NSTextAlignment, size: CGFloat, weight: UIFont.Weight) {
        self.text = text
        self.textColor = color
        self.textAlignment = alignment
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
    }
}
