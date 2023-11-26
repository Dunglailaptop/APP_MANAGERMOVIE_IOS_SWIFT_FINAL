//
//  ListInfoCinemaViewController.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 25/11/2023.
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

class ListInfoCinemaViewController: UIViewController {
    
    @IBOutlet weak var image_cinema: UIImageView!
    
    @IBOutlet weak var lbl_name_cinema: UILabel!
    @IBOutlet weak var txt_view_discription: UITextView!
    @IBOutlet weak var lbl_address: UILabel!
    var idcinema = 0
    //    @IBOutlet weak var view_map: UIView!
    
    var viewModel = ListinfoCinemaViewModel()
    var router = ListInfoCinemaRouter()
    @IBOutlet weak var mapView: MKMapView!
    var mapView2 : GMSMapView!
       var placesClient: GMSPlacesClient!
       var searchQuery = "restaurants" // Từ khóa tìm kiếm
    let locationManager = CLLocationManager()
    @IBOutlet weak var view_map: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        GMSServices.provideAPIKey("AIzaSyAG3SSMXPUldPt4ogGe_lwZIFbqDF7KM6A")
        GMSPlacesClient.provideAPIKey("AIzaSyCKPMo2ytoB9Hxp687JTjDY5dv9r_HUouA")
//        placesClient = GMSPlacesClient.shared()
//
//            // Khởi tạo bản đồ Google Maps
//            let camera = GMSCameraPosition.camera(withLatitude: 37.7749, longitude: -122.4194, zoom: 12.0)
//            let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//            mapView.isMyLocationEnabled = true
//            mapView.settings.myLocationButton = true
//
//            // Thêm bản đồ vào view hierarchy
//            view = mapView
//
//            // Tạo điểm đánh dấu trên bản đồ
//            let marker = GMSMarker()
//            marker.position = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
//            marker.title = "San Francisco"
//            marker.snippet = "California, USA"
//            marker.map = mapView
//
//            // Gọi hàm tìm kiếm vị trí
//            searchPlaces()
        
        // Khởi tạo CLLocationManager
//            locationManager.delegate = self
//            locationManager.requestWhenInUseAuthorization()
//            locationManager.startUpdatingLocation()
//
//            // Khởi tạo bản đồ Google Maps
//            let camera = GMSCameraPosition.camera(withLatitude: 10.7765713, longitude: 106.7012093, zoom: 12.0)
//            mapView2 = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//            mapView2.isMyLocationEnabled = true
//            mapView2.settings.myLocationButton = true
//            view = mapView2
      
      
//       moveCameraToLocation(latitude:  10.8305255, longitude:  106.6360984)
        
        

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.idcinema.accept(idcinema)
        getDetailInfo()
    }
    
   
    
    func setupMapView() {
//           let camera = GMSCameraPosition.camera(withLatitude: 10.7765713, longitude: 106.7012093, zoom: 12.0)
//           mapView2 = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//           mapView2.isMyLocationEnabled = true
//           mapView2.settings.myLocationButton = true
        
//        if let mapView = mapView2 {
//                   mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//                   mapView.isMyLocationEnabled = true
//                   mapView.settings.myLocationButton = true
//                   view_map.addSubview(mapView)
//               }
//        view_map.addSubview(mapView2)
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
//           //call 2
//           let firstLocation = CLLocationCoordinate2D(latitude: 10.8305255, longitude: 106.6360984)
//                  let secondLocation = CLLocationCoordinate2D(latitude: 10.806172, longitude: 106.634953)
//
//                  // Add markers for both locations
//                  let marker1 = GMSMarker()
//                  marker1.position = firstLocation
//                  marker1.title = "First Location"
//                  marker1.map = mapView2
//
//                  let marker2 = GMSMarker()
//                  marker2.position = secondLocation
//                  marker2.title = "Second Location"
//                  marker2.map = mapView2
//
//                  // Draw a polyline between the two locations
//                  let path = GMSMutablePath()
//                  path.add(firstLocation)
//                  path.add(secondLocation)
//
//                  let polyline = GMSPolyline(path: path)
//                  polyline.strokeColor = UIColor.red
//                  polyline.strokeWidth = 2.0
//                  polyline.map = mapView2
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

    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
    
}
extension ListInfoCinemaViewController: CLLocationManagerDelegate {
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

extension ListInfoCinemaViewController{
    func getDetailInfo() {
        viewModel.getDetailCinema().subscribe(onNext: {
            (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue{
                if let data = Mapper<Cinema>().map(JSONObject: response.data) {
                    self.viewModel.dataciema.accept(data)
                    self.lbl_address.text = data.address
                    self.image_cinema.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data.picture)), placeholder:  UIImage(named: "image_defauft_medium"))
                    self.txt_view_discription.text = data.describes
                    self.lbl_name_cinema.text = data.namecinema
                    self.getCoordinatesForCity(data.describes)
                    self.setupMapView()
                }
            }else {
                JonAlert.showError(message: "Có lỗi xảy ra")
            }
        })
    }
}
