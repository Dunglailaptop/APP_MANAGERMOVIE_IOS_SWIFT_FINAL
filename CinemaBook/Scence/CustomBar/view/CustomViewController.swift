//
//  CustomViewController.swift
//  CinemaBook
//
//  Created by dungtien on 7/30/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {

    var router = CustomBarRouter()
    private let titleLabel = UILabel()
    private let item: CustomTabItem
    var viewModel = CustomBarViewModel()
    
    init(item: CustomTabItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        setupProperties()
        viewModel.bind(view: self, router: router)
        
        if(!ManageCacheObject.isLogin()){
            viewModel.makeLoginViewController()
        }
        
        titleLabel.textColor = .red
    }
    
    private func setupHierarchy() {
        view.addSubview(titleLabel)
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func setupProperties() {
        titleLabel.configureWith(text: item.name, color: .black, alignment: .center, size: 28, weight: .bold)
        view.backgroundColor = .white
    }
}
