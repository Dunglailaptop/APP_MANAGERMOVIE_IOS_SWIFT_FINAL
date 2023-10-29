//
//  CustomTabBar.swift
//  CustomTabBarExample
//
//  Created by Jędrzej Chołuj on 18/12/2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

final class CustomTabBar: UIStackView {
    
//    var itemTapped: Observable<Int> { itemTappedSubject.asObservable() }
    private let itemTappedSubject = PublishSubject<Int>()
    
    // ... Your other code ...
    
    var itemTapped: Observable<Int> {
        return itemTappedSubject.asObservable()
    }
    
    //      private lazy var customItemViews: [CustomItemView] = [generalItem, orderItem, areaItem, feeItem, reportItem, utilitiesItem]
    private lazy var customItemViews: [CustomItemView] = [Home, Ticket, newFeed, NotificationApp, SettingAccount]
    
    
    
    private let Home = CustomItemView(with: .Home, index: 0)
    private let Ticket = CustomItemView(with: .Ticket, index: 1)
    private let newFeed = CustomItemView(with: .newFeed, index: 2)
    private let NotificationApp = CustomItemView(with: .NotificationApp, index: 3)
    private let SettingAccount = CustomItemView(with: .SettingAccount, index: 4)
    
    
//    private let itemTappedSubject = PublishSubject<Int>()
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(frame: .zero)
        
        setupHierarchy()
        setupProperties()
        bind()
        
        setNeedsLayout()
        layoutIfNeeded()
        //        selectItem(index: 0)
        setCurrentTab()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupHierarchy() {
      
        [Home, Ticket, newFeed, NotificationApp, SettingAccount].forEach { itemView in
            addArrangedSubview(itemView)
        }
    }
    
    private func setCurrentTab(){
            self.selectItem(index: self.Home.index)
       
        
    }
    
    

    private func setupProperties() {
        distribution = .fillEqually
        alignment = .center
        
        if #available(iOS 13.0, *) {
            backgroundColor = .systemIndigo
        } else {
            // Fallback on earlier versions
        }
        setupCornerRadius(20)
        
        customItemViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.clipsToBounds = true
        }
    }
    
    private func selectItem(index: Int) {
        customItemViews.forEach { $0.isSelected = $0.index == index }
        itemTappedSubject.onNext(index)
    }
    
    //MARK: - Bindings
    
    private func bind() {
        Home.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
             
                    self.selectItem(index: self.Home.index)
            
            }
            .disposed(by: disposeBag)

        Ticket.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
             
                    self.selectItem(index: self.Ticket.index)
           
            }
            .disposed(by: disposeBag)

        newFeed.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
         
                    self.selectItem(index: self.newFeed.index)
       
            }
            .disposed(by: disposeBag)

        //            feeItem.rx.tapGesture()
        //                .when(.recognized)
        //                .bind { [weak self] _ in
        //                    guard let self = self else { return }
        //                    self.feeItem.animateClick {
        //                        self.selectItem(index: self.feeItem.index)
        //                    }
        //                }
        //                .disposed(by: disposeBag)

        NotificationApp.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
             
                    self.selectItem(index: self.NotificationApp.index)
               
            }
            .disposed(by: disposeBag)

        SettingAccount.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
              
                    self.selectItem(index:self.SettingAccount.index)
               
            }
            .disposed(by: disposeBag)
        
        
    }
}

