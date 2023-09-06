//
//  DetailMovieRouter.swift
//  CinemaBook
//
//  Created by dungtien on 8/14/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit

class  DetailMovieRouter
{
    var viewController:UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController() -> UIViewController {
        let view = DetailMovieViewController(nibName: "DetailMovieViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceview(_ sourceview:UIViewController?){
        guard let view = sourceview else {fatalError("error")}
        self.sourceView = view
    }
    
    func makePopToViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
    
    func navigationMakeToBookingChairViewController(){
        let bookingchairViewController = TimeShowRouter().viewController
        sourceView?.navigationController?.pushViewController(bookingchairViewController, animated: true)
    }
    
    func navigationMakeVideoYoutubeViewController(videoid:String) {
        let viewvideo = videoRouter().viewController as! VideoViewController
        viewvideo.videoId = videoid
        sourceView?.navigationController?.pushViewController(viewvideo, animated: true)
    }
}
