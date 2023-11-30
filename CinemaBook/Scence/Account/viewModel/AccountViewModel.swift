
import  UIKit
import RxSwift
import RxCocoa


class AccountViewModel{
    private(set) weak var view: AccountViewController?
    private var router: AccountRouter?
    
    public var dataArray: BehaviorRelay<[Int]> = BehaviorRelay(value: [])
    
    func bind(view: AccountViewController, router: AccountRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    
    func maketoLoginViewController() {
        router?.navigationToLoginViewController()
    }
    func makeToAccountInfoViewController() {
        router?.navigationToAccountInfoViewController()
    }
    
    func makeToManageBillAccountViewController() {
        router?.navigationToManageBillAccountViewController()
    }
    
    func makeToManageBillFoodListViewController() {
        router?.navigationToManageBillFoodAccountViewController()
    }
    
    func makeToForgotViewController() {
        router?.navigaitionToForgotViewController()
    }
    func makeToSettingBusiness() {
        router?.navigationToSettingBusiness()
    }
    
    func makeToForgotPassword() {
        router?.navigationToForgotPassword()
    }
    
}

