//
//  ManagementInterestMoviesViewModel.swift
//  CinemaBook
//
//  Created by Nguyen Xuan Tien Dung on 17/10/2023.
//  Copyright © 2023 dungtien. All rights reserved.
//
import UIKit
import RxCocoa
import RxRelay
import RxSwift

class ManagementInterestMoviesViewModel: BaseViewModel {
    private(set) weak var view: ManagementInterestMoviesViewController?
    private var router: ManagementInterestMoviesRouter?
    

 
    /// DATA SEARCH
    public var dataSearchMovie:BehaviorRelay<[Movie]> = BehaviorRelay(value: [])
    public var dataSearchMovieHistory:BehaviorRelay<[Movie]> = BehaviorRelay(value: [])



    public var dataArrayInterest: BehaviorRelay<[RoomList]> = BehaviorRelay(value: [])
    public var dataArrayInterestInfo: BehaviorRelay<[MovieList]> = BehaviorRelay(value: [])

    public var dataArrayMovie: BehaviorRelay<[Movie]> = BehaviorRelay(value: [])
    public var dataArrayRoom: BehaviorRelay<[Room]> = BehaviorRelay(value: [])
    public var dataDay: BehaviorRelay<(DateForm:String,DateTo:String,dateStart:String,dateEnd:String)> = BehaviorRelay(value: (DateForm: Utils.getCurrentDateStringFormatyyyyMMdd(),DateTo:Utils.getCurrentDateStringFormatyyyyMMdd(),dateStart:"2023-09-19T16:02:37.650Z",dateEnd:"2023-09-19T16:02:37.650Z"))
    public var allvalue: BehaviorRelay<(page:Int,limit:Int,status:Int,idcinema:Int,idroom:Int,idinterest:Int,statusInterest:Int)> = BehaviorRelay(value: (page:0,limit:20,status:1,idcinema:ManageCacheObject.getCurrentCinema().idcinema ,idroom:0,idinterest:0,statusInterest:0))
    public var pagationData: BehaviorRelay<(MovieLists: MovieList,RoomLists:RoomList)> = BehaviorRelay(value:  (MovieLists: MovieList(),RoomLists:RoomList()))
    public var pagationDataArray: BehaviorRelay<(MovieLists: [MovieList],RoomLists:RoomList,Rooms:Room)> = BehaviorRelay(value:  (MovieLists:[],RoomLists:RoomList(),Rooms:Room()))
    public var selectedDataMovie: BehaviorRelay<[Movie]> = BehaviorRelay(value: [])

    public var movielist: BehaviorRelay<[MovieList]> = BehaviorRelay(value: [])
    //data

    
    
    func clearData() {
        var data = pagationDataArray.value
        data.MovieLists = []
        data.RoomLists.idroom = 0
        pagationDataArray.accept(data)
      
    }
    
    
    func bind(view: ManagementInterestMoviesViewController, router: ManagementInterestMoviesRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    
}
extension ManagementInterestMoviesViewModel {
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
        return appServiceProvider.rx.request(.getListInterestsMovie(idcinema: allvalue.value.idcinema, idroom: allvalue.value.idroom,date: dataDay.value.dateStart))
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
        dLog(pagationDataArray.value.MovieLists)
        dLog(pagationDataArray.value.RoomLists)
        return appServiceProvider.rx.request(.postListInterest(roomlist: pagationDataArray.value.RoomLists, movieList: pagationDataArray.value.RoomLists.MovieLists, dayStart: dataDay.value.DateForm, dayEnd: dataDay.value.DateTo))
                   .filterSuccessfulStatusCodes()
                   .mapJSON().asObservable()
                   .showAPIErrorToast()
                   .mapObject(type: APIResponse.self)
           }
    func updateSatusInterest() -> Observable<APIResponse> {
        dLog(allvalue.value)
        return appServiceProvider.rx.request(.updateSatus(idinterest: allvalue.value.idinterest, status: allvalue.value.statusInterest))
                      .filterSuccessfulStatusCodes()
                      .mapJSON().asObservable()
                      .showAPIErrorToast()
                      .mapObject(type: APIResponse.self)
              }
}
