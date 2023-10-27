//
//  DetailMovieInfoViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 25/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import FSPagerView

class DetailMovieInfoViewController: BaseViewController {

    @IBOutlet weak var lbl_author: UILabel!
    
    @IBOutlet weak var lbl_categorymovie: UILabel!
    @IBOutlet weak var lbl_nation: UILabel!
    @IBOutlet weak var txt_description: UITextView!
    @IBOutlet weak var lbl_timeall: UILabel!
    @IBOutlet weak var lbl_date_show: UILabel!
    @IBOutlet weak var lbl_name_movie: UILabel!
    @IBOutlet weak var image_poster: UIImageView!
    @IBOutlet weak var bannerVoucher: FSPagerView!
    @IBOutlet weak var view_image: UIView!
    var viewModel = DetailMovieviewModel()
    var router = DetailMovieRouter()
    
    var idmovie = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
       setupfscalender()
        reaload()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListVoucher()
        viewModel.idmovie.accept(idmovie)
        getDetailMovie()
    }

    
    func setupfscalender() {
        bannerVoucher.cornerRadius = 20
        bannerVoucher.transformer = FSPagerViewTransformer(type: .cubic)
        bannerVoucher.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "FSPagerViewCell")
        bannerVoucher.automaticSlidingInterval = 5
        bannerVoucher.interitemSpacing = 100
        bannerVoucher.alwaysBounceHorizontal = true
        bannerVoucher.dataSource = self
        bannerVoucher.delegate = self
        bannerVoucher.isInfinite = true
    }


    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
    
    @IBAction func btn_maketoBookingChairViewController(_ sender: Any) {
        dLog(viewModel.dataArray.value.movieID)
        viewModel.makeToBookingChairViewController(idmovie: viewModel.dataArray.value.movieID,namemovie: viewModel.dataArray.value.namemovie)
    }
    
    @IBAction func btn_makevideo(_ sender: Any) {
        viewModel.makeToVideoYoutuebViewController(videoId: viewModel.dataArray.value.videofile)
    }
    
}
extension DetailMovieInfoViewController: FSPagerViewDataSource, FSPagerViewDelegate {
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        
         return viewModel.dataArrayVoucher.value.count
      
       
    }
        
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
      let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "FSPagerViewCell", at: index)
         cell.imageView?.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: viewModel.dataArrayVoucher.value[index].poster) ), placeholder: UIImage(named: "image_defauft_medium"))
            return cell
       
        return pagerView.dequeueReusableCell(withReuseIdentifier: "FSPagerViewCell", at: index)
    }
   
}
