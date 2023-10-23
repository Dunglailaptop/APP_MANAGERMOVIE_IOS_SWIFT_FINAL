//
//  DialogChooseCategoryMovieViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 22/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift
import ObjectMapper

class DialogChooseCategoryMovieViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var root_view_choose_filter: UIView!
    var delegate: DialogChooseCategoryMovie?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpForTapOutSide()
        resgister()
        bindingtable()
        // Do any additional setup after loading the view.
    }


    private func setUpForTapOutSide() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutSide(_:)))
        tapGesture.cancelsTouchesInView = false
        UIApplication.shared.windows.first?.addGestureRecognizer(tapGesture) // Attach to the window
    }
    
    
    @objc func handleTapOutSide(_ gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: self.root_view_choose_filter)
        if !root_view_choose_filter.bounds.contains(tapLocation) {
            dismiss(animated: true, completion: nil)
        }
    }
    
    var viewModel: ListMovieShowNowViewModel? = nil {
        didSet {
            getListCategoryMovie()
         
        }
    }

}
extension DialogChooseCategoryMovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func resgister() {
        let viewCell = UINib(nibName: "ItemCategoryMovieTableViewCell", bundle: .main)
        tableView.register(viewCell, forCellReuseIdentifier: "ItemCategoryMovieTableViewCell")
        tableView.rx.setDelegate(self)
        tableView.separatorStyle = .none
        tableView.rx.modelSelected(CategoryMovie.self).subscribe(onNext: {
            (element) in
            self.delegate?.callbackChooseCategoryMovie(Idcategory: element.idcategorymovie)
        })
    }
    func bindingtable() {
        viewModel?.dataCategoryMovie.bind(to: tableView.rx.items(cellIdentifier: "ItemCategoryMovieTableViewCell", cellType: ItemCategoryMovieTableViewCell.self)){
            (row,data,cell) in
            cell.data = data
           
        }
    }
    
    func getListCategoryMovie() {
        viewModel?.getListCategortMovie().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<CategoryMovie>().mapArray(JSONObject: response.data) {
                    self.viewModel?.dataCategoryMovie.accept(data)
                }
            }
        })
    }
}
