//
//  VideoTraillerShowViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 06/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class VideoTraillerShowViewModel: BaseViewModel
{
    private(set) weak var view: VieoTraillerShowViewController?
    private var router: VideoTraillerShowRouter?
    
    var dataArray: BehaviorRelay<[Trailler]> = BehaviorRelay(value: [])
    var datacommentgetArray: BehaviorRelay<Comments> = BehaviorRelay(value: Comments())
    var datacomment: BehaviorRelay<[Comments]> = BehaviorRelay(value: [])
    var datacreatemessage:BehaviorRelay<MessageComments> = BehaviorRelay(value: MessageComments())
    var datalikeandcomments: BehaviorRelay<likeandheart> = BehaviorRelay(value: likeandheart())
    func bind(view: VieoTraillerShowViewController, router: VideoTraillerShowRouter)
    {
        self.view = view
        self.router =  router
        self.router?.setSourceView(self.view!)
    }
    
  
   
}
extension VideoTraillerShowViewModel {
    func getListTraillerShowBanner() -> Observable<APIResponse> {
    return appServiceProvider.rx.request(.getListTrailler)
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
    func postlikeandcomments() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.likeandcomment(likeandhearts: datalikeandcomments.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
}
