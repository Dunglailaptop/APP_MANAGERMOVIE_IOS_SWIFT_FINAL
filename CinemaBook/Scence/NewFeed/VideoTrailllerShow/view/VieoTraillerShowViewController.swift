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
            card_Swiper.cardSpacing = 0
            
             card_Swiper.isSideSwipingEnabled = false
         
        }
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        if let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "itemCardCell", for: index) as? itemCardCell {
            cardCell.lbl_namevideo.text = viewModel.dataArray.value[index].titlevideo
            cardCell.lbl_like.text = String(viewModel.dataArray.value[index].like)
            cardCell.lbl_heart.text = String(viewModel.dataArray.value[index].heart)
            cardCell.lbl_message.text = String(viewModel.dataArray.value[index].commentscount)
            viewModel.datacomment.accept(viewModel.dataArray.value[index].messagevideos)
            if viewModel.dataArray.value[index].types == 0 {
               
                cardCell.lbl_namevideo.isHidden = true
                cardCell.lbl_pause.isHidden = true
                cardCell.video_player.load(withVideoId: viewModel.dataArray.value[index].videofile)
            }else {
//                cardCell.view_load_videourl.isHidden = true
              
                Utils().setupvideo(url: Utils.getFullMediaLink(string: viewModel.dataArray.value[index].videofile), type: 1, view: cardCell.video_player,heights: 100)
            }
            dLog(viewModel.datacomment.value)
            cardCell.data = viewModel.dataArray.value[index].messagevideos
            cardCell.viewModel = viewModel
            cardCell.btn_showcomment.rx.tap.asDriver().drive(onNext: { [self] in
                self.presentModalDialogConfirmViewController(viewMdeols: self.viewModel, dataComments: self.viewModel.dataArray.value[index].messagevideos, idvideo: self.viewModel.dataArray.value[index].idvideo)
            })
            var datalikeandcomment = viewModel.datalikeandcomments.value
            cardCell.btn_like.rx.tap.asDriver().drive(onNext: {
                [self] in
                cardCell.icon_like.tintColor = cardCell.icon_like.tintColor == .systemPink ? .white:.systemPink
                datalikeandcomment.Idusers = ManageCacheObject.getCurrentUserInfo().idusers
                datalikeandcomment.idvideo = viewModel.dataArray.value[index].idvideo
                datalikeandcomment.likes = viewModel.dataArray.value[index].statuslike == 1 ? 0:1
                datalikeandcomment.comments = 0
                viewModel.datalikeandcomments.accept(datalikeandcomment)
                postlikeandcomment()
            })
            cardCell.btn_heart.rx.tap.asDriver().drive(onNext: {
                [self] in
                cardCell.icon_heart.tintColor = cardCell.icon_heart.tintColor == .systemPink ? .white:.systemPink
                datalikeandcomment.Idusers = ManageCacheObject.getCurrentUserInfo().idusers
                datalikeandcomment.idvideo = viewModel.dataArray.value[index].idvideo
                datalikeandcomment.likes = 0
                datalikeandcomment.comments = viewModel.dataArray.value[index].statusheart == 1 ? 0:1
                viewModel.datalikeandcomments.accept(datalikeandcomment)
                postlikeandcomment()
            })
         
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
            dLog(response.data)
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
    func postlikeandcomment() {
        viewModel.postlikeandcomments().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                
            }
        })
    }
}
extension VieoTraillerShowViewController {
    func presentModalDialogConfirmViewController(viewMdeols:VideoTraillerShowViewModel,dataComments: [Comments],idvideo:Int) {
        let dialogConfirmViewController = DialogShowCommentViewController()
        dLog(dataComments)
        var dataget = viewModel.datacreatemessage.value
        dataget.idvideo = idvideo
        viewModel.datacomment.accept(dataComments)
        viewModel.datacreatemessage.accept(dataget)
        dialogConfirmViewController.view.backgroundColor = ColorUtils.blackTransparent()
        dialogConfirmViewController.Idvideo = idvideo
        dialogConfirmViewController.datacomments = dataComments
            let nav = UINavigationController(rootViewController: dialogConfirmViewController)
            // 1
            nav.modalPresentationStyle = .overCurrentContext

            
            // 2
            if #available(iOS 15.0, *) {
                if let sheet = nav.sheetPresentationController {
                    
                    // 3
                    sheet.detents = [.large()]
                    
                }
            } else {
                // Fallback on earlier versions
            }
            // 4
           
            present(nav, animated: true, completion: nil)

        }
}
