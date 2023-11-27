//
//  VieoTraillerShowViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 06/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import LNICoverFlowLayout
import VerticalCardSwiper
import ObjectMapper
import RxCocoa
import RxRelay
import RxSwift

class VieoTraillerShowViewController: UIViewController {

    @IBOutlet weak var card_Swiper: VerticalCardSwiper!
    
  var viewModel = VideoTraillerShowViewModel()
    var router = VideoTraillerShowRouter()
    var traillers = Trailler()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        register()
        card_Swiper.datasource = self
        // Để vuốt từ dưới lên
   

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getListVideoTrailler()
    }

    @IBAction func btn_makePopToViewController(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
extension VieoTraillerShowViewController: VerticalCardSwiperDatasource {
        func register() {
            let cellNib = UINib(nibName: "itemCardCell", bundle: nil)

            card_Swiper.register(nib: cellNib, forCellWithReuseIdentifier: "itemCardCell")
            card_Swiper.topInset = 0
            card_Swiper.sideInset = 0
            card_Swiper.cardSpacing = 5
//            card_Swiper.visibleNextCardHeight = card_Swiper.layer.frame.size.height
             card_Swiper.isSideSwipingEnabled = false
        }
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        if let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "itemCardCell", for: index) as? itemCardCell {
            if viewModel.dataArray.value[index].types == 0 {
                cardCell.video_player.load(withVideoId: viewModel.dataArray.value[index].videofile)
            }else {
                cardCell.view_load_videourl.isHidden = true
                Utils().setupvideo(url: Utils.getFullMediaLink(string: viewModel.dataArray.value[index].videofile), type: 1, view: cardCell.video_player)
            }
         
         
            return cardCell
        }
        return CardCell()
    }

     
     func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
         return viewModel.dataArray.value.count
     }
    
  
}
extension VieoTraillerShowViewController {
    func getListVideoTrailler() {
        viewModel.getListTraillerShowBanner().subscribe(onNext:  { [self]
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Trailler>().mapArray(JSONObject: response.data){
                   

                    self.viewModel.dataArray.accept(data)
                    self.card_Swiper.reloadData()
                    getvideotrailler()
                }
            }
        })
    }
    func getvideotrailler() {
        if traillers != nil {
            var datatraillerDetail = viewModel.dataArray.value

            if let index = datatraillerDetail.firstIndex(where: { $0.idvideo == traillers.idvideo }) {
                let traillerToMove = datatraillerDetail.remove(at: index)
                datatraillerDetail.insert(traillerToMove, at: 0)
                
                viewModel.dataArray.accept(datatraillerDetail)
                self.card_Swiper.reloadData()
            }
        }
    }
}
