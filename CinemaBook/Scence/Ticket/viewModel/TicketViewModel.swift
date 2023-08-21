


import  UIKit
import RxSwift
import RxCocoa


class TicketViewModel: BaseViewModel {
    private(set) weak var view: TicketViewController?
    private var router: TicketRouter?
    
    var dataArray: BehaviorRelay<[Movie]> = BehaviorRelay(value: [])
    
    func bind(view: TicketViewController, router: TicketRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
}

extension TicketViewModel {
//    func getMovie() -> Observable<APIResponse> {
//        return appServiceProvider.rx.request(.Moive)
//            .filterSuccessfulStatusCodes()
//            .mapJSON().asObservable()
//            .showAPIErrorToast()
//            .mapObject(type: APIResponse.self)
//    }
}
