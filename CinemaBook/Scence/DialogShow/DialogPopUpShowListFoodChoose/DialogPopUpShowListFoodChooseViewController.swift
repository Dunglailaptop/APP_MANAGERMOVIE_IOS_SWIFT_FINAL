//
//  DialogPopUpShowListFoodChooseViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 12/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxRelay
import JonAlert

class DialogPopUpShowListFoodChooseViewController: BaseViewController {

   
    @IBOutlet weak var btn_plus: UIButton!
    @IBOutlet weak var btn_minius: UIButton!
    
    @IBOutlet weak var view_choose_food: UIView!
    @IBOutlet weak var TableView: UITableView!
   
    @IBOutlet weak var lbl_number: UILabel!
    @IBOutlet weak var lbl_price: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
    @IBOutlet weak var lbl_name_food: UILabel!
    @IBOutlet weak var image_food: UIImageView!
    var dataFoodDetail = FoodCombo()
    override func viewDidLoad() {
        super.viewDidLoad()
       register1()
        bindingtable1()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutSide(_:)))
        tapGesture.cancelsTouchesInView = false
        UIApplication.shared.windows.first?.addGestureRecognizer(tapGesture)
        setup()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    func setup(){
        lbl_name_food.text = dataFoodDetail.nametittle
        lbl_price.text = Utils.stringVietnameseFormatWithNumber(amount: dataFoodDetail.priceCombo)
        lbl_description.text = dataFoodDetail.descriptions
        image_food.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: dataFoodDetail.picture)), placeholder: UIImage(named: "image_defauft_medium"))
        
        var dataDetailFoodCombo = viewModel?.dataDetailFoodCombo.value
        dataDetailFoodCombo?.nametittle = dataFoodDetail.nametittle
        dataDetailFoodCombo?.descriptions = dataFoodDetail.descriptions
        dataDetailFoodCombo?.priceCombo = dataFoodDetail.priceCombo
        dataDetailFoodCombo?.picture = dataFoodDetail.picture
        dataDetailFoodCombo?.quantityRealtime = 1
        viewModel?.dataDetailFoodCombo.accept(dataDetailFoodCombo!)
        btn_minius.rx.tap.asDriver().drive(onNext: {
            if dataDetailFoodCombo!.quantityRealtime > 1 {
                dataDetailFoodCombo?.quantityRealtime -= 1
                self.lbl_number.text = String(dataDetailFoodCombo!.quantityRealtime)
                self.lbl_price.text = Utils.stringVietnameseFormatWithNumber(amount: dataDetailFoodCombo!.quantityRealtime * dataDetailFoodCombo!.priceCombo)
                self.viewModel?.dataDetailFoodCombo.accept(dataDetailFoodCombo!)
            }
            
           
        })
        
      
        btn_plus.rx.tap.asDriver().drive(onNext:  {
            dataDetailFoodCombo?.quantityRealtime += 1
            self.lbl_number.text = String(dataDetailFoodCombo!.quantityRealtime)
            self.lbl_price.text = Utils.stringVietnameseFormatWithNumber(amount: dataDetailFoodCombo!.quantityRealtime * dataDetailFoodCombo!.priceCombo)
            self.viewModel?.dataDetailFoodCombo.accept(dataDetailFoodCombo!)
        })
      
//        viewModel?.dataAllFood.subscribe(onNext: {
//         [weak self] elment in
//            var dataAll = self!.viewModel?.dataAllFood.value
//            var datafood = self!.viewModel?.dataArrayfood.value
//            var dataFoodWater = self!.viewModel?.dataArrayFoodWater.value
//            dataAll?.append(contentsOf: datafood!)
//            dataAll?.append(contentsOf: dataFoodWater!)
//            self!.viewModel?.dataAllFood.accept(dataAll!)
//        }).disposed(by: rxbag)
    }
    
    @objc func handleTapOutSide(_ gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: self.view_choose_food)
        if !view_choose_food.bounds.contains(tapLocation) {
          dismiss(animated: true)
        }
    }

    var viewModel: DetailProductViewModel? = nil {
        didSet {
        
        }
    }
    
    func nootifacationCart(foodcombo:FoodCombo,food: [Food],foodwater: [Food]) {
        let notificationName = Notification.Name("GETDATESATRING")
        let loginResponse = ["listcart": ["foodcombo": foodcombo, "food": food,"foodwater": foodwater]]
      
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: loginResponse)
    }
  
    @IBAction func btn_addCart(_ sender: Any) {
        guard var dataDetailFoodCombo = viewModel?.dataDetailFoodCombo.value  else { return  }
        var dataFood = viewModel?.dataArrayfood.value.filter{ $0.isSelected == ACTIVE}
        var dataFoodWater = viewModel?.dataArrayFoodWater.value.filter{ $0.isSelected == ACTIVE }
        dLog(dataFoodWater)
        viewModel?.dataAllFood.accept([])
        var dataAll = self.viewModel?.dataAllFood.value
     
        dataAll?.append(contentsOf: dataFood!)
        dataAll?.append(contentsOf: dataFoodWater!)
        self.viewModel?.dataAllFood.accept(dataAll!)
        var datafilterfoodcombo = viewModel?.dataAllFood.value
        dataDetailFoodCombo.foods = datafilterfoodcombo!
        dLog(viewModel?.dataAllFood.value)
        ManageCacheObject.saveCartInfo(dataDetailFoodCombo)
        nootifacationCart(foodcombo: dataDetailFoodCombo,food: dataFood!, foodwater: dataFoodWater!)
         dLog(dataDetailFoodCombo)
        JonAlert.showSuccess(message: "Đã thêm sản phẩm vào giỏ hàng thành công")
        dismiss(animated: true)
        dLog(ManageCacheObject.getCartInfo())
//        ManageCacheObject.saveCartInfo(dataDetailFoodCombo)
    }
    
    @IBAction func btn_cancel_food(_ sender: Any) {
        dismiss(animated: true)
    }
}
extension DialogPopUpShowListFoodChooseViewController: UITableViewDelegate {
    
    
    
    func register1() {
        let listFoodCombo = UINib(nibName: "ItemFoodWaterSectionTableViewCell", bundle: .main)
        TableView.register(listFoodCombo, forCellReuseIdentifier: "ItemFoodWaterSectionTableViewCell")
        let listFoodComboWater = UINib(nibName: "ItemFoodUnWaterSectionTableViewCell", bundle: .main)
        TableView.register(listFoodComboWater, forCellReuseIdentifier: "ItemFoodUnWaterSectionTableViewCell")
        let itemFoodincombo = UINib(nibName: "ItemFoodWithInComboTableViewCell", bundle: .main)
        TableView.register(itemFoodincombo, forCellReuseIdentifier: "ItemFoodWithInComboTableViewCell")
        TableView.rx.setDelegate(self)
        TableView.separatorStyle = .none

    }
    func bindingtable1() {
        viewModel?.DetaillistFoodCombo.bind(to: TableView.rx.items) {
            (table,index,element) -> UITableViewCell in
            let indexPath = IndexPath(row: index, section: 0)
            switch index {
            case 0:
                let cell = self.TableView.dequeueReusableCell(withIdentifier: "ItemFoodWithInComboTableViewCell", for: indexPath) as! ItemFoodWithInComboTableViewCell
                cell.viewModel = self.viewModel
                cell.selectionStyle = .none
                 
                 return cell
            case 1:
                let cell = self.TableView.dequeueReusableCell(withIdentifier: "ItemFoodWaterSectionTableViewCell", for: indexPath) as! ItemFoodWaterSectionTableViewCell
                cell.viewModel = self.viewModel
                           cell.selectionStyle = .none
                 
                 return cell
            default:
                let cell = self.TableView.dequeueReusableCell(withIdentifier: "ItemFoodUnWaterSectionTableViewCell", for: indexPath) as! ItemFoodUnWaterSectionTableViewCell
                cell.viewModel = self.viewModel
                           cell.selectionStyle = .none
                 
                 return cell
              
            }
            
            
           
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 80
        case 1:
            return 300
        default:
            return 300
        }
    }
}
