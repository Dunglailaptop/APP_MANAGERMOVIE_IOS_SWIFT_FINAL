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
}
