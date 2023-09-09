//
//  BannerProductTableViewCell.swift
//  CinemaBook
//
//  Created by dungtien on 9/8/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import FSPagerView
import Kingfisher

class BannerProductTableViewCell: UITableViewCell {

  
    @IBOutlet weak var BANNER: FSPagerView!
   
    
    private(set) var disposeBag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
          BANNER.cornerRadius = 20
               BANNER.transformer = FSPagerViewTransformer(type: .cubic)
               BANNER.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "FSPagerViewCell")
               BANNER.automaticSlidingInterval = 5
               BANNER.interitemSpacing = 100
               BANNER.alwaysBounceHorizontal = true
               BANNER.dataSource = self
               BANNER.delegate = self
               BANNER.isInfinite = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var viewModel: HomeViewModel?{
        didSet {
          viewModel?.dataArrayProduct.subscribe(onNext: {[self] (data) in
            self.BANNER.reloadData()
                         })
          
        }
    }
    
}
extension BannerProductTableViewCell: FSPagerViewDataSource, FSPagerViewDelegate {
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
           if let viewModel = viewModel{
               return viewModel.dataArrayProduct.value.count
           }
           return 0
       }
           
       public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
           
           if let viewModel = viewModel{
               let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "FSPagerViewCell", at: index)
            cell.imageView?.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: viewModel.dataArrayProduct.value[index].picture) ), placeholder: UIImage(named: "image_defauft_medium"))
               return cell
           }
           return pagerView.dequeueReusableCell(withReuseIdentifier: "FSPagerViewCell", at: index)
       }
      
}

