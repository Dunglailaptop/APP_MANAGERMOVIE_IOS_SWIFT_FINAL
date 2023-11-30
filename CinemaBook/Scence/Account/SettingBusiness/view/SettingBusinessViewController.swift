//
//  SettingBusinessViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 30/11/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import MapKit
import GooglePlaces
import RxCocoa
import RxRelay
import RxSwift
import ObjectMapper
import GoogleMaps
import CoreLocation
import JonAlert
import Photos

class SettingBusinessViewController: BaseViewController {
    
    @IBOutlet weak var txt_namemovie: UITextField!
    @IBOutlet weak var txt_description: UITextView!
    @IBOutlet weak var txt_phone_number: UITextField!
    @IBOutlet weak var txt_name_cinema: UITextField!
    @IBOutlet weak var image_cinema: UIImageView!
    var viewModel = SettingBusinessViewModel()
    var router = SettingBusinessRouter()
    var idcinema = 0
    var imagecover = [UIImage]()
     var selectedAssets = [PHAsset]()
    var nameImage: [String] = []
    var imageAvatarFireBase = UIImage()
    @IBOutlet weak var view_map: UIView!
    
    @IBOutlet weak var txt_address: UITextField!
    var mapView2 : GMSMapView!
        var placesClient: GMSPlacesClient!
        var searchQuery = "restaurants" // Từ khóa tìm kiếm
        let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        GMSServices.provideAPIKey("AIzaSyAG3SSMXPUldPt4ogGe_lwZIFbqDF7KM6A")
        GMSPlacesClient.provideAPIKey("AIzaSyCKPMo2ytoB9Hxp687JTjDY5dv9r_HUouA")
        _ = txt_address.rx.text.map{(str) in
            if str!.count > 50 {
//                self.showWarningMessage(content: "Độ dài tối đa 50 ký tự")
            }
            return String(str!.prefix(50))
        }.map({(str) -> Cinema in
            var datacinema = self.viewModel.dataciema.value
            datacinema.address = str ?? ""
            self.getCoordinatesForCity(str)
            self.setupMapView()
            return datacinema
        }).bind(to: viewModel.dataciema).disposed(by: rxbag)
        _ = txt_name_cinema.rx.text.map{(str) in
            if str!.count > 50 {
//                self.showWarningMessage(content: "Độ dài tối đa 50 ký tự")
            }
            return String(str!.prefix(50))
        }.map({(str) -> Cinema in
            var datacinema = self.viewModel.dataciema.value
            datacinema.namecinema = str ?? ""
            self.getCoordinatesForCity(str)
            self.setupMapView()
            return datacinema
        }).bind(to: viewModel.dataciema).disposed(by: rxbag)
        _ = txt_description.rx.text.map{(str) in
            if str!.count > 50 {
//                self.showWarningMessage(content: "Độ dài tối đa 50 ký tự")
            }
            return String(str!.prefix(50))
        }.map({(str) -> Cinema in
            var datacinema = self.viewModel.dataciema.value
            datacinema.describes = str ?? ""
            self.getCoordinatesForCity(str)
            self.setupMapView()
            return datacinema
        }).bind(to: viewModel.dataciema).disposed(by: rxbag)
        _ = txt_phone_number.rx.text.map{(str) in
            if str!.count > 50 {
//                self.showWarningMessage(content: "Độ dài tối đa 50 ký tự")
            }
            return String(str!.prefix(50))
        }.map({(str) -> Cinema in
            var datacinema = self.viewModel.dataciema.value
            datacinema.phone = str ?? ""
            self.getCoordinatesForCity(str)
            self.setupMapView()
            return datacinema
        }).bind(to: viewModel.dataciema).disposed(by: rxbag)
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.idcinema.accept(ManageCacheObject.getCurrentCinema().idcinema)
        getinfoDetail()
    }

    @IBAction func btn_makeTochooseimage(_ sender: Any) {
        openPhotoLibrary()
    }
    
    @IBAction func btn_update_info(_ sender: Any) {
        imagecover.count > 0 ? postUpdateWithAvatar():updateinfocinema()
    }
    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
    
    
}
extension SettingBusinessViewController {
    func setupMapView() {
        let camera = GMSCameraPosition.camera(withLatitude: 10.7765713, longitude: 106.7012093, zoom: 12.0)
              mapView2 = GMSMapView.map(withFrame: view_map.bounds, camera: camera)

              if let mapView = mapView2 {
                  mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                  mapView.isMyLocationEnabled = true
                  mapView.settings.myLocationButton = true
                  view_map.addSubview(mapView)
              }
       }

       func moveCameraToLocation(latitude: Double, longitude: Double) {
           let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 12.0)
           mapView2.animate(to: camera)
           //call1
           let marker = GMSMarker()
           marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                  marker.title = "Your Title"
                  marker.snippet = "Your Snippet"
                  marker.icon = GMSMarker.markerImage(with: .red) // Đặt màu của marker thành màu đỏ
                  marker.map = mapView2
       }

    func getCoordinatesForCity(_ cityName: String) {
            let placesClient = GMSPlacesClient.shared()
            let geocoder = CLGeocoder()

            geocoder.geocodeAddressString(cityName) { (placemarks, error) in
                guard let placemark = placemarks?.first else {
                    dLog("Location not found")
                    return
                }
                let location = placemark.location
                dLog("Coordinates for \(cityName): \(location?.coordinate.latitude ?? 0), \(location?.coordinate.longitude ?? 0)")
                self.moveCameraToLocation(latitude: location?.coordinate.latitude ?? 0, longitude:  location?.coordinate.longitude ?? 0)
            }
        }
}

extension SettingBusinessViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }

        // Lấy thông tin vị trí hiện tại
        let currentCoordinate = location.coordinate
        print("Current Location: \(currentCoordinate.latitude), \(currentCoordinate.longitude)")

        // Di chuyển bản đồ đến vị trí hiện tại
        mapView2.animate(to: GMSCameraPosition.camera(withTarget: currentCoordinate, zoom: 15))
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error requesting location: \(error.localizedDescription)")
    }

}
extension SettingBusinessViewController {
    func postUpdateWithAvatar(){
        var medias = [Medias]()
        var medias_request = Medias()
        var dataImage = viewModel.dataciema.value
        medias_request.image = imagecover[0]
        dLog(nameImage)
        
        medias_request.name = nameImage[0]
        medias_request.type = 1
        medias.append(medias_request)
        viewModel.media_request.accept(medias)
        viewModel.uploadImage()
        let connectImage = nameImage[0] + "/" + nameImage[0];
        dataImage.picture = connectImage
        viewModel.dataciema.accept(dataImage)
     
         updateinfocinema()
//        if  type_dy == "CREATE" {
//            postCreateEmployee()
//        } else  {
//                postUpdateAccount()
//        }
    
    }
    
    
    func getinfoDetail() {
        viewModel.getDetailCinema().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Cinema>().map(JSONObject: response.data) {
                    self.viewModel.dataciema.accept(data)
                    self.txt_address.text = data.address
                    self.txt_description.text = data.describes
                    self.txt_name_cinema.text = data.namecinema
                    self.txt_phone_number.text = data.phone
                    self.image_cinema.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data.picture)), placeholder:  UIImage(named: "image_defauft_medium"))
                    self.getCoordinatesForCity(data.address)
                    self.setupMapView()
                   
                   }
            }
        })
    }
    
    func updateinfocinema() {
        viewModel.updateCinemas().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let data = Mapper<Cinema>().map(JSONObject: response.data) {
                    self.getinfoDetail()
                }
            }else {
                JonAlert.showError(message: "Có lỗi xảy ra trong qua trình kết nối")
            }
        })
    }
}
extension SettingBusinessViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     @objc func openPhotoLibrary() {
           let imagePicker = UIImagePickerController()
           imagePicker.sourceType = .photoLibrary
           imagePicker.delegate = self
           present(imagePicker, animated: true, completion: nil)
       
       }
       
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
               // Lưu ảnh đã chọn vào biến imageView
               image_cinema.image = selectedImage
               self.imagecover.append(selectedImage)
               imageAvatarFireBase = selectedImage
               // Lấy URL của ảnh đã chọn
               if let imageUrl = info[.imageURL] as? URL {
                   let imageName = imageUrl.lastPathComponent
                   dLog("Tên ảnh: \(imageName)")
                nameImage.append(imageName)
               }
           }
           picker.dismiss(animated: true, completion: nil)
       }
       
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
       }
}
