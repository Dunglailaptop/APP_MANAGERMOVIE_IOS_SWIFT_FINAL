
import UIKit
import RxSwift
import RxCocoa
import JonAlert


class BookingViewModel: BaseViewModel
{
    private(set) weak var view: BookingTicketViewController?
    private var router: BookingRouter?
    
    public var dataArray: BehaviorRelay<[Movie]> = BehaviorRelay(value: [])
    
    func bind(view: BookingTicketViewController, router: BookingRouter)
    {
        self.view = view
        self.router =  router
        self.router?.setSourceView(self.view!)
    }
    
    func makeToDetailMovieViewController(id:Int){
        router?.navigationMakeToDetailMovieViewController(id:id)
    }
    
   
}

extension BookingViewModel {
    func getListMovieShow() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.Moive(page: 0, limit: 20, status: 1,Idcategory: 0,dateFrom: "",dateTo: ""))
             .filterSuccessfulStatusCodes()
             .mapJSON().asObservable()
             .showAPIErrorToast()
             .mapObject(type: APIResponse.self)
     }
}
