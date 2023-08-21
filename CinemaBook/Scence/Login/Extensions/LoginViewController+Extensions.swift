import UIKit
import JonAlert
import  RxCocoa
import RxSwift
import ObjectMapper


extension LoginViewController {
    
    static let rxbag = DisposeBag()
    
    
    func getConfig() {
        viewModel.getConfig().subscribe(onNext: { (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let config = Mapper<Config>().map(JSONObject: response.data)
                {
                    var obj_config = config
                    ManageCacheObject.saveCache(obj_config)
                 
                    self.login()
                }
             
            }else {
                JonAlert.show(message: "Co loi trong qua trinh ket noi")
            }
            
        }).disposed(by: LoginViewController.rxbag)
    }
    
    
    
    func login(){
        viewModel.getLogin().subscribe(onNext: {
         (response) in
        
            if let account = Mapper<Users>().map(JSONObject: response.data) {
                self.viewModel.makeToMenuViewController()
                ManageCacheObject.saveCurrentUserInfo(account)
                dLog(account)
            }
        }).disposed(by: LoginViewController.rxbag)
    }
    
    
    
   
}
