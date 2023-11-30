


import UIKit

class AccountRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = AccountViewController(nibName: "AccountViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    
    func navigationToLoginViewController() {
        let LoginViewController = LoginRouter().viewController as! LoginViewController
        sourceView?.navigationController?.pushViewController(LoginViewController, animated: true)
    }
    
    func navigationToAccountInfoViewController() {
        let accountinfoview = AccountInfoRouter().viewController as! AccountInfoViewController
        accountinfoview.type_dy = "ACCOUNT"
        sourceView?.navigationController?.pushViewController(accountinfoview, animated: true)
    }
    
    func navigationToManageBillAccountViewController() {
        let billaccount = ManageBillAccountRouter().viewController as! ManageBillAccountViewController
        sourceView?.navigationController?.pushViewController(billaccount, animated: true)
    }
    func navigationToManageBillFoodAccountViewController() {
        let view2 = ManageBillFoodAccountViewController()
        sourceView?.navigationController?.pushViewController(view2, animated: true)
    }
    
    func navigaitionToForgotViewController() {
        let viewForgotPassword = ForgotPasswordViewController()
        sourceView?.navigationController?.pushViewController(viewForgotPassword, animated: true)
    }
    func navigationToSettingBusiness() {
        let viewSettingbusiness = SettingBusinessViewController()
        sourceView?.navigationController?.pushViewController(viewSettingbusiness, animated: true)
    }
    func navigationToForgotPassword() {
        let viewForgot = ForgotRouter().viewController
        sourceView?.navigationController?.pushViewController(viewForgot, animated: true)
    }
}

