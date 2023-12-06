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
                Toast.show(message: response.message ?? "Co loi trong qua trinh ket noi", controller: self)
            }
            
        }).disposed(by: LoginViewController.rxbag)
    }
    
    
    
    func login(){
        viewModel.getLogin().subscribe(onNext: {
         (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue{
                    if let account = Mapper<Users>().map(JSONObject: response.data) {
                        if account.statuss != 1 {
                            ManageCacheObject.saveCurrentUserInfo(account)
                             self.viewModel.makeToMenuViewController()
                            self.viewModel.iduser.accept(account.idusers)
                            self.getCinema()
                    
                            dLog(account)
                        } else {
                            JonAlert.showError(message: "Tài khoản đang bị khoá xin vui lòng liên hệ quản lý để được tư vấn mở khoá")
                        }
                               
                            }
            }else {
                Toast.show(message: response.message ?? "Có lỗi xảy ra trong quá trình kết nối", controller: self)
            }
        
        }).disposed(by: LoginViewController.rxbag)
    }
    
    func getCinema(){
           viewModel.getInfoCinema().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue{
                
               if let cinema = Mapper<Cinema>().map(JSONObject: response.data) {
                  
                   ManageCacheObject.saveCurrentCinema(cinema)
                
//                     self.viewModel.makeToMenuViewController()
              
               
               
                  
               }else if ManageCacheObject.getCurrentUserInfo().idrole != 1 {
                 JonAlert.showError(message: "Nhân viên không tồn tại trong danh sách nhà hàng xin vui lòng đăng ký tài khoản cho nhân viên")
                }
            }else {
                JonAlert.showError(message: "Có lỗi trong quá trình kết nối")
            }
           }).disposed(by: LoginViewController.rxbag)
       }
    
   
}
