//
//  CustomItemView.swift
//  CustomTabBarExample
//
//  Created by Jędrzej Chołuj on 18/12/2021.
//

import UIKit
import SnapKit

final class CustomItemView: UIView {
    private let badgeLabel = UILabel()
    private let nameLabel = UILabel()
    private let iconImageView = UIImageView()
    private let underlineView = UIView()
    private let containerView = UIView()
    let index: Int
    
    var isSelected = false {
        didSet {
            animateItems()
        }
    }
    // Cập nhật giá trị của badge
        var badgeValue: String = "" {
            didSet {
                badgeLabel.text = badgeValue
                badgeLabel.isHidden = badgeValue.isEmpty // Ẩn badge nếu badgeValue rỗng
            }
        }
    
    private let item: CustomTabItem
    
    init(with item: CustomTabItem, index: Int) {
        self.item = item
        self.index = index
        
        super.init(frame: .zero)
        
        setupHierarchy()
        setupLayout()
        setupProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubview(containerView)
//        containerView.addSubview(nameLabel, iconImageView, underlineView)
        let subviews = [nameLabel, iconImageView, underlineView]
        subviews.forEach { subview in
            containerView.addSubview(subview)
            containerView.addSubview(badgeLabel)
            
        }

    }
    
    private func setupLayout() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.center.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints {
            $0.height.width.equalTo(40)
            $0.top.equalToSuperview()
            $0.bottom.equalTo(nameLabel.snp.top)
            $0.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(16)
        }
        
        underlineView.snp.makeConstraints {
            $0.width.equalTo(40)
            $0.height.equalTo(4)
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(nameLabel.snp.centerY)
        }
        // Cấu hình vị trí và kích thước của badgeLabel
               badgeLabel.snp.makeConstraints {
                   $0.top.equalToSuperview().offset(0) // Dịch chuyển badgeLabel từ top
                              $0.trailing.equalToSuperview().offset(-20) // Dịch chuyển badgeLabel từ right
                              $0.width.height.equalTo(20) // Kích thước của badge
               }

    }
    
    private func setupProperties() {
        nameLabel.configureWith(text: item.name,
                                color: ColorUtils.gray_400(),
                                alignment: .center,
                                size: 11,
                                weight: .semibold)
        underlineView.backgroundColor = .white

        iconImageView.image = isSelected ? item.selectedIcon : item.icon
        
        // Thiết lập các thuộc tính cho badgeLabel
                badgeLabel.backgroundColor = UIColor.red // Màu nền của badge
                badgeLabel.textColor = UIColor.white // Màu chữ của badge
                badgeLabel.textAlignment = .center
                badgeLabel.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
                badgeLabel.layer.cornerRadius = 10 // Bo tròn viền của badge (nếu cần)
                badgeLabel.layer.masksToBounds = true // Để bo tròn viền của badge
                badgeLabel.text = "10" // Đặt giá trị mặc định cho badge
                badgeLabel.isHidden = true // Ẩn badge khi không cần thiết
    }
    
    private func animateItems() {
        UIView.animate(withDuration: 0.4) { [unowned self] in
            self.nameLabel.alpha = self.isSelected ? 0.0 : 1.0
            self.underlineView.alpha = self.isSelected ? 1.0 : 0.0
            self.underlineView.backgroundColor = self.isSelected ? ColorUtils.buttonGreen() : .clear
            self.iconImageView.image = self.isSelected ? self.item.selectedIcon : self.item.icon
        }
     
//        }
    }
    // Your custom view implementation
    
    // Add the animateClick method to handle click animation
  public func animateClick() {
        UIView.animate(withDuration: 0.2, animations: {
            // Perform any animation you want when the view is clicked
            // For example, you can change the background color, scale the view, etc.
            self.backgroundColor = UIColor.gray
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { _ in
            // Reset the view to its original state after the animation
            UIView.animate(withDuration: 0.2) {
                self.backgroundColor = UIColor.white
                self.transform = .identity
            }
        }
    }
}
