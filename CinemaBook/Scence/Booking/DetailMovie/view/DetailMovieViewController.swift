//
//  DetailMovieViewController.swift
//  CinemaBook
//
//  Created by dungtien on 8/14/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import AVFoundation
import youtube_ios_player_helper
import FSPagerView

class DetailMovieViewController: BaseViewController, FSPagerViewDataSource, FSPagerViewDelegate {

    var viewModel = DetailMovieviewModel()
    var router = DetailMovieRouter()
    
    @IBOutlet weak var view_video: UIView!
    
    @IBOutlet weak var poster: UIImageView!
    
    @IBOutlet weak var lbl_namemovie: UILabel!
    
    @IBOutlet weak var lbl_yeahshow: UILabel!
    
    @IBOutlet weak var lbl_timeall: UILabel!
    
    @IBOutlet weak var lbl_category: UILabel!
    
    @IBOutlet weak var lbl_author: UILabel!
    
    @IBOutlet weak var viewheight: NSLayoutConstraint!
    
    @IBOutlet weak var lblheight: NSLayoutConstraint!
    
    @IBOutlet weak var image_poster: UIImageView!
    
    @IBOutlet weak var lbl_text: UILabel!
    @IBOutlet weak var btn_readmore: UIButton!
    
    @IBOutlet weak var bannerVoucher: FSPagerView!
    
    
    var islabelatMaxHeight = true
    
    var idmovie = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        viewModel.bind(view: self, router: router)
//        readMore()
////        reaload()
//        bannerVoucher.cornerRadius = 20
//        bannerVoucher.transformer = FSPagerViewTransformer(type: .cubic)
//        bannerVoucher.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "FSPagerViewCell")
//        bannerVoucher.automaticSlidingInterval = 5
//        bannerVoucher.interitemSpacing = 100
//        bannerVoucher.alwaysBounceHorizontal = true
//        bannerVoucher.dataSource = self
//        bannerVoucher.delegate = self
//        bannerVoucher.isInfinite = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//         getListVoucher()
//        viewModel.idmovie.accept(idmovie)
//        getDetailMovie()
    
    }

    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
    
    
    @IBAction func btn_read_more(_ sender: Any) {
      readMore()
    }
    
    func getlabelheight(text: String, width: CGFloat)-> Float{
        let lbl = UILabel(frame: .zero)
        lbl.frame.size.width = width
       
        lbl.numberOfLines = 0
        lbl.text = text
        lbl.sizeToFit()
        
        return Float(lbl.frame.size.height)
    }
    
    func readMore(){
       if islabelatMaxHeight {
       btn_readmore.setTitle("đọc thêm", for: .normal)
       islabelatMaxHeight = false
       lblheight.constant = 70
     
        }else{
         btn_readmore.setTitle("đọc thêm", for: .normal)
         islabelatMaxHeight = true
        lblheight.constant = CGFloat(getlabelheight(text: lbl_text.text!, width: view.bounds.width))
       
         }
          viewheight.constant = lblheight.constant + 50
    }
    
    
    @IBAction func btn_maketoBookingChairViewController(_ sender: Any) {
        dLog(viewModel.dataArray.value.movieID)
        viewModel.makeToBookingChairViewController(idmovie: viewModel.dataArray.value.movieID, namemovie: "")
    }
    
    @IBAction func btn_makevideo(_ sender: Any) {
        viewModel.makeToVideoYoutuebViewController(videoId: viewModel.dataArray.value.videofile)
    }
    
    
     
    //     public func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int){
    //           if let viewModel = viewModel{
    //               switch viewModel.dataArrayProduct.value[index].type_url{
    //                   case 0:
    //                       /*
    //                               Banner được chọn là kho bia
    //                               => chuyển tới trang chi tiết kho bia
    //                           */
    //                       viewModel.makeBeerStoreDetailViewController(beerId: viewModel.bannerArray.value[index].restaurant_brand_id)
    //                       break
    //                   case 1:
    //                       /*
    //                            Banner được chọn là loại quà tặng => thì check membershipCard nếu đã là thành viên thì chuyển tới trang chi tiết quà tặng,
    //                            ngược lại thì chuyển tới trang chi tiết nhà hàng
    //                           */
    //                       viewModel.brandId.accept(viewModel.bannerArray.value[index].restaurant_brand_id)
    //                       checkReadyMemberShipCard(giftId: viewModel.bannerArray.value[index].restaurant_gift_id)
    //                       break
    //                   case 2: // => chuyển tới landing_page
    //                       guard let url = URL(string: viewModel.bannerArray.value[index].landing_page_url) else { return }
    //                       UIApplication.shared.open(url)
    //                       break
    //
    //                   default:
    //                       return
    //               }
    //
    //           }
    //       }
           
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

extension DetailMovieViewController {
    func setupvideo(url:String) {
           let videoUrl = URL(string:url)
           let player = AVPlayer(url: videoUrl!)
           let playerplay = AVPlayerLayer(player: player)
        playerplay.frame = self.view_video.bounds
        playerplay.videoGravity = .resizeAspectFill
        self.view_video.layer.addSublayer(playerplay)
        player.play()
         }
    
}
