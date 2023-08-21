
import  UIKit
import RxSwift
import RxCocoa


class AccountViewModel{
    private(set) weak var view: AccountViewController?
    private var router: AccountRouter?
    
    public var dataArray: BehaviorRelay<[Movie]> = BehaviorRelay(value: [])
    
    func bind(view: AccountViewController, router: AccountRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    
    func maketoLoginViewController() {
        router?.navigationToLoginViewController()
    }
}

