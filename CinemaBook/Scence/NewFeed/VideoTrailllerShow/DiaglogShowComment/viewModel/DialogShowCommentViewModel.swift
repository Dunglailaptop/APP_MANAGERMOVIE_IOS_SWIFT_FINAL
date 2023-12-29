//
//  DialogShowCommentViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 28/12/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class DialogShowCommentViewModel: BaseViewModel
{
    private(set) weak var view: DialogShowCommentViewController?
    private var router: DialogShowCommentRouter?
    
    var datacomment:BehaviorRelay<[Comments]> = BehaviorRelay(value: [])
    var datacreatemessage:BehaviorRelay<MessageComments> = BehaviorRelay(value: MessageComments())
  
    func bind(view: DialogShowCommentViewController, router: DialogShowCommentRouter)
    {
        self.view = view
        self.router =  router
        self.router?.setSourceView(self.view!)
    }
    
  
   
}
extension DialogShowCommentViewModel {
  
    func postmessage() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.postmessage(comment: datacreatemessage.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
 
}
