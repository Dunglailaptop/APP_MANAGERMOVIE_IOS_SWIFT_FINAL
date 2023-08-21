

import UIKit
import RxCocoa
import RxSwift
import ObjectMapper

extension TicketViewController {
//    func getMovie() {
//        viewModel.getMovie().subscribe(onNext: { (response) in
//            if response.code == RRHTTPStatusCode.ok.rawValue {
//                if let data = Mapper<Movie>().mapArray(JSONObject: response.data)
//                {
//                    dLog(data)
//                    self.viewModel.dataArray.accept(data)
//                }
//            }
//            
//        }).disposed(by: rxbag)
//    }
}

extension TicketViewController {
    
    
        func registerCell() {

            let MovieItemTableViewCell = UINib(nibName: "MovieItemTableViewCell", bundle: .main)
            tableView.register(MovieItemTableViewCell, forCellReuseIdentifier: "MovieItemTableViewCell")
          
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            tableView
                .rx.setDelegate(self)
                .disposed(by: rxbag)
        }
    
    func bindingTableView() {
        viewModel.dataArray.asObservable().bind(to: tableView.rx.items(cellIdentifier: "MovieItemTableViewCell", cellType: MovieItemTableViewCell.self))
        {  (row, revenue, cell) in
    
            
            }.disposed(by: rxbag)
    }
  
 
}
extension TicketViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 136
    }
    
        
}
