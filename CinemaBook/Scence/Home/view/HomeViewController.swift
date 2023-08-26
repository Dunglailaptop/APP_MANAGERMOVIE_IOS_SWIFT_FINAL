//
//  HomeViewController.swift
//  CinemaBook
//
//  Created by dungtien on 8/2/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController {
   
  
   var viewModel = HomeViewModel()
    
    
    @IBOutlet weak var collection_view: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
      
       
        
        
        
    }

   
   
    
     
      

}
//extension HomeViewController {
    
//    func resgister() {
//         let bannertableviewcell = UINib(nibName: "FlimsCollectionViewCell", bundle: .main)
//             collection_view.register(bannertableviewcell, forCellWithReuseIdentifier: "FlimsCollectionViewCell")
//       let bannertableviewcell2 = UINib(nibName: "headerCollectionViewCell", bundle: .main)
//                 collection_view.register(bannertableviewcell2, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderReuseIdentifier")
//
//        setupCollectionView()
//    }
//
//        func setupCollectionView() {
//            let layout = UICollectionViewFlowLayout()
//            layout.scrollDirection = .vertical
//    //        layout.scrollDirection = .horizontal
//            layout.itemSize = CGSize(width: view.frame.width/2.2, height: view.frame.width/2.2)
//
//            collection_view.collectionViewLayout = layout
//            collection_view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//            collection_view.translatesAutoresizingMaskIntoConstraints = false
//
//
//
//        }
//
//    func binđDataTableCollectionView(){
//
//                   viewModel.listtablecell.bind(to: collection_view.rx.items)
//                   { [self] (table, index, employee) -> UICollectionViewCell in
//                       let indexPath = IndexPath(row: index, section: 0)
//                       switch index {
//                       case 0:
//                        let cell = self.collection_view.dequeueReusableCell(withReuseIdentifier: "headerCollectionViewCell", for: indexPath) as! headerCollectionViewCell
//
//
//                           return cell
//                       case 1:
//                        let cell = self.collection_view.dequeueReusableCell(withReuseIdentifier: "FlimsCollectionViewCell", for: indexPath) as! FlimsCollectionViewCell
//
//
//                           return cell
//                       default:
//                        let cell = self.collection_view.dequeueReusableCell(withReuseIdentifier: "headerCollectionViewCell", for: indexPath) as! headerCollectionViewCell
//
//
//                           return cell
//                       }
//
//
//                       }.disposed(by: rxbag)
//
//          }
       

//extension HomeViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        // Return the size for the header view
//        return CGSize(width: collectionView.frame.width, height: 100) // Adjust height as needed
//    }
//
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionView.elementKindSectionHeader {
//            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCollectionReusableView", for: indexPath) as! headerCollectionReusableView
//            // Configure header view if needed
//            return headerView
//        }
//        fatalError("Unexpected element kind")
//    }
//
//}
