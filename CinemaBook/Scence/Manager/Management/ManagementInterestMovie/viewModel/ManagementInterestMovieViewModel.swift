//
//  ManagementInterestMovieViewModel.swift
//  CinemaBook
//
//  Created by dungtien on 9/15/23.
//  Copyright © 2023 dungtien. All rights reserved.
//



import UIKit
import RxSwift
import RxCocoa

class ManagementInterestMovieViewModel: BaseViewModel{
    private(set) weak var view: ManagementInterestMovieViewController?
    private var router: ManagementInterestMovieRouter?
    
    public var dataArray: BehaviorRelay<[Int]> = BehaviorRelay(value: [0,1])
    
//    public var dataArrayRoom: BehaviorRelay<[Int]> = BehaviorRelay(value: [0,1,2,3,4,5,6,7,8,9])
     public var dataArrayInterest: BehaviorRelay<[RoomList]> = BehaviorRelay(value: [])
    public var dataArrayInterestInfo: BehaviorRelay<[MovieList]> = BehaviorRelay(value: [])
    public var dataArrayday: BehaviorRelay<[Date]> = BehaviorRelay(value: [])
    public var dataArrayMovie: BehaviorRelay<[Movie]> = BehaviorRelay(value: [])
      public var dataArrayRoom: BehaviorRelay<[Room]> = BehaviorRelay(value: [])
    public var dataDay: BehaviorRelay<(DateForm:String,DateTo:String,dateStart:String,dateEnd:String)> = BehaviorRelay(value: (DateForm: Utils.getCurrentDateStringFormatyyyyMMdd(),DateTo:Utils.getCurrentDateStringFormatyyyyMMdd(),dateStart:"2023-09-19T16:02:37.650Z",dateEnd:"2023-09-19T16:02:37.650Z"))
    public var allvalue: BehaviorRelay<(page:Int,limit:Int,status:Int,idcinema:Int,idroom:Int)> = BehaviorRelay(value: (page:0,limit:20,status:1,idcinema:ManageCacheObject.getCurrentCinema().idcinema ,idroom:0))
    public var pagationData: BehaviorRelay<(MovieLists: MovieList,RoomLists:RoomList)> = BehaviorRelay(value:  (MovieLists: MovieList(),RoomLists:RoomList()))
    public var pagationDataArray: BehaviorRelay<(MovieLists: [MovieList],RoomLists:RoomList,Rooms:Room)> = BehaviorRelay(value:  (MovieLists:[],RoomLists:RoomList(),Rooms:Room()))
    public var selectedDataMovie: BehaviorRelay<[Movie]> = BehaviorRelay(value: [])
      public var selectedDataRoom: BehaviorRelay<[Room]> = BehaviorRelay(value: [])
    
    //data
    public var DateList: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    //data inesert room array
    public var dataRoomCreate: BehaviorRelay<Room> = BehaviorRelay(value: Room())
    public var dataArrayRoomCreate: BehaviorRelay<[Room]> = BehaviorRelay(value: [])
    public var Idroom:BehaviorRelay<Int> = BehaviorRelay(value: 0)
    func bind(view: ManagementInterestMovieViewController, router: ManagementInterestMovieRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    func makePopToViewController() {
        router?.navigationPopToViewController()
    }
    func clearData() {
        var data = pagationDataArray.value
        data.MovieLists = []
        data.RoomLists.idroom = 0
        pagationDataArray.accept(data)
      
    }
  
}
extension ManagementInterestMovieViewModel {
    func getListMovieShow() -> Observable<APIResponse> {
           return appServiceProvider.rx.request(.Moive(page: allvalue.value.page, limit: allvalue.value.limit,status: allvalue.value.status))
                .filterSuccessfulStatusCodes()
                .mapJSON().asObservable()
                .showAPIErrorToast()
                .mapObject(type: APIResponse.self)
        }
    func getListRoom() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListRoom(idcinema: allvalue.value.idcinema))
                   .filterSuccessfulStatusCodes()
                   .mapJSON().asObservable()
                   .showAPIErrorToast()
                   .mapObject(type: APIResponse.self)
           }
    
    func getListInterestAutoCreate() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListInterestsMovie(idcinema: allvalue.value.idcinema, idroom: allvalue.value.idcinema))
                      .filterSuccessfulStatusCodes()
                      .mapJSON().asObservable()
                      .showAPIErrorToast()
                      .mapObject(type: APIResponse.self)
              }
     func getListInterestAuto() -> Observable<APIResponse> {
        dLog(pagationDataArray.value)
        return appServiceProvider.rx.request(.getListAutoInterest(roomlist: pagationDataArray.value.RoomLists, movieList: pagationDataArray.value.MovieLists, dayStart: dataDay.value.DateForm, dayEnd: dataDay.value.DateTo))
                .filterSuccessfulStatusCodes()
                .mapJSON().asObservable()
                .showAPIErrorToast()
                .mapObject(type: APIResponse.self)
        }
    func CreateArrayInterest() -> Observable<APIResponse> {
           dLog(pagationDataArray.value)
        return appServiceProvider.rx.request(.postListInterest(roomlist: pagationDataArray.value.RoomLists, movieList: pagationDataArray.value.RoomLists.MovieLists, dayStart: dataDay.value.DateForm, dayEnd: dataDay.value.DateTo))
                   .filterSuccessfulStatusCodes()
                   .mapJSON().asObservable()
                   .showAPIErrorToast()
                   .mapObject(type: APIResponse.self)
           }
}
