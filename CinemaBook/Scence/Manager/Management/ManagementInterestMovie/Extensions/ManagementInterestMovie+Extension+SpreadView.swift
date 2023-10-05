//
//  ManagementInterestMovie+Extension+SpreadView.swift
//  CinemaBook
//
//  Created by dungtien on 9/21/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import  UIKit
import SpreadsheetView


extension ManagementInterestMovieViewController{
    func setup(){
                lbl_dateTo.text = Utils.getCurrentDateString()
                lbl_datefrom.text = Utils.getCurrentDateString()
                getListDay(startday: viewModel.dataDay.value.DateForm, endDay: viewModel.dataDay.value.DateTo)
                spreadsheetview.register(myLabel.self, forCellWithReuseIdentifier: myLabel.identifier)
                UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
                UIViewController.attemptRotationToDeviceOrientation()

                spreadsheetview.frame = CGRect(x: 0, y: 0, width: view_of_spreadsheet.frame.size.width, height: view_of_spreadsheet.frame.size.height)
                view_of_spreadsheet.addSubview(spreadsheetview)
                spreadsheetview.dataSource = self
             


                viewModel.dataArrayday.subscribe(onNext: {
                [self] respone in

                self.spreadsheetview.reloadData()

                })
       }
       
       func getListDay(startday:String,endDay:String){
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd"
           dLog(self.viewModel.dataDay.value.DateForm)
           let startDate = dateFormatter.date(from: startday)
           let endDate = dateFormatter.date(from: endDay)
                                             
           var listOfDates = Utils().getListOfDates(startDate: startDate!, endDate: endDate!)
           self.viewModel.dataArrayday.accept(listOfDates)
       }
}

extension ManagementInterestMovieViewController: SpreadsheetViewDataSource {
    
    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }
    
    
    
   
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: myLabel.identifier, for: indexPath) as! myLabel
        
        if indexPath.section == 0 && indexPath.row == 0 {
            // This is the top-left cell, set it to empty or something else if needed
            cell.setup(text: "", imageURL: "")
            cell.backgroundColor = .white
        } else if indexPath.section == 0 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateAsString = dateFormatter.string(from: viewModel.dataArrayday.value[indexPath.row])
            let dayOfWeek = Utils().getDayOfWeek(today: dateAsString) ?? 0 // Provide a default value if nil
            let dateOfWeekString = String(dayOfWeek)
            cell.setup(text: "thứ " + dateOfWeekString + " " + dateAsString, imageURL: "")
            cell.backgroundColor = ColorUtils.gray_200()
        } else if indexPath.row == 0 {
            // Display times in the first column
            cell.setup(text: dataTime[indexPath.section - 1], imageURL: "")
            cell.backgroundColor = ColorUtils.gray_200()
        } else {
            cell.setup(text: "", imageURL: "") // Reset giá trị của ô
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateAsString = dateFormatter.string(from: viewModel.dataArrayday.value[indexPath.row])
            var dataMovie = viewModel.dataArrayMovie.value
            var dataListInterest = viewModel.pagationDataArray.value
            dataListInterest.RoomLists.MovieLists.enumerated().forEach{ (index1,value1) in
    
                let startTimes = value1.startTime.components(separatedBy: "T")
                 let endTimes = value1.endTime.components(separatedBy: "T")
                let Times = startTimes[1].components(separatedBy: ":")
                let TimesTable = dataTime[indexPath.section - 1].components(separatedBy: ":")
               
               
                    if TimesTable[0] == Times[0] &&  dateAsString == startTimes[0] {
                       
                        cell.setup(text: value1.namemovie, imageURL: value1.image)
                        cell.tag = value1.idMovie
                    }
//                    else {
//                        cell.setup(text: "THỜI GIAN CHỜ", imageURL: "")
//                   }
                

              
            }
            
                cell.button.rx.tap.asDriver().drive(onNext: { [self] in
               


            
                var dataMovie = self.viewModel.pagationDataArray.value.MovieLists.filter{$0.idMovie == cell.tag}
                self.viewModel.dataArrayInterestInfo.accept(dataMovie)
            
                    
                self.presentDialogPopUpListInfoInterest(namemovie:cell.label.text!,imageMovie:cell.urlPoster)
                dLog(cell.label.text)
            })
            cell.backgroundColor = .white
        }
        
        return cell
    }

    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return viewModel.dataArrayday.value.count
    }
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return dataTime.count
    }
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        return 300
    }
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        return 48
    }
}
//class myLabel: Cell {
//
//    static let identifier = "Mylabel"
//
//    private let label = UILabel()
//
//    private let image  = UIImage()
//
//    public var date = ""
//
//    public func setup(text:String,image:String) {
//    self.image.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: image)), placeholder:  UIImage(named: "image_defauft_medium"))
//        label.text = text
//        label.textAlignment = .center
//        label.numberOfLines = 0
//        contentView.addSubview(label)
//        contentView.addSubview(image)
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        label.frame = contentView.bounds
//    }
//}
class myLabel: Cell {
    
    static let identifier = "Mylabel"
    
    public let label = UILabel()
   public let button = UIButton()

    
    private let imageView = UIImageView() // Changed 'image' to 'imageView'
    public var urlPoster = ""
    public var date = ""
    
    public func setup(text: String, imageURL: String) {
        imageView.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: imageURL)), placeholder: UIImage(named: "image_defauft_medium"))
        urlPoster = imageURL
        label.text = text
        label.textAlignment = .center
      
    
        label.numberOfLines = 0
        contentView.addSubview(label)
           contentView.addSubview(imageView)
          contentView.addSubview(button)
        if !imageURL.isEmpty && urlPoster != "" {
            imageView.isHidden = false
            button.isHidden = false
               imageView.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: imageURL)), placeholder: UIImage(named: "image_defauft_medium"))
            
           
            imageView.translatesAutoresizingMaskIntoConstraints = false
                  label.translatesAutoresizingMaskIntoConstraints = false
                  
                  // Add constraints for imageView
                  NSLayoutConstraint.activate([
                      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                      imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                      imageView.widthAnchor.constraint(equalToConstant: 50), // Adjust width as needed
                      imageView.heightAnchor.constraint(equalToConstant: 50) // Adjust height as needed
                  ])
                  
                  // Add constraints for label
                NSLayoutConstraint.activate([
                      label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8), // Adjust spacing as needed
                      label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
                  ])
            
           
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = .clear // Set the background color to clear
                           NSLayoutConstraint.activate([
                     
                           button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                           button.topAnchor.constraint(equalTo: contentView.topAnchor),
             button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                    button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                           ])
                  
            
                
                  
           
           } else {
               imageView.isHidden = true
            button.isHidden = true
            // Hide imageView if imageURL is empty
           }
               
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = contentView.bounds
        
        // Position the imageView, adjust the frame as needed
        imageView.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width, height: contentView.bounds.height / 2)
    }
}
