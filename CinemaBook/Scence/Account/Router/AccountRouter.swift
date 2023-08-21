


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
    
    
}

