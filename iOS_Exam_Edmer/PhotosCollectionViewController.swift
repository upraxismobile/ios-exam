//
//  PhotosCollectionViewController.swift
//  iOS_Exam_Edmer
//
//  Created by Edmer Alarte on 15/07/2017.
//  Copyright © 2017 Edmer Alarte. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

private let reuseIdentifier = "Cell"

class PhotosCollectionViewController: UICollectionViewController {

    @IBOutlet weak var cView: UICollectionView!
    
    var store_name = [[String: String]]()
    var tiTle = [[String: String]]()
    var petitions = [[String: String]]()
    var priceData = [[String: String]]()
    
    struct Storyboard{
        static let photoCell = "PhotoCell"
        static let headerCell = "HeaderCell"
        static let showDetailSegue = "ShowDetail"
        
        static let leftAndRightPaddings:CGFloat = 24.0
        
        static let numberOfItemsPerRow:CGFloat = 2.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 print("HELLO ")
        let collectionViewWidth = collectionView?.frame.width
        
        let itemWidth = (collectionViewWidth! - Storyboard.leftAndRightPaddings)/Storyboard.numberOfItemsPerRow
        
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width:itemWidth,height:itemWidth)
        layout.minimumLineSpacing = 10
        //        layout.minimumInteritemSpacing = 20
        
//        Alamofire.request("https://marketplaceapi.bigbenta.com/index.php/api/search", method: .post, parameters: parameterss, encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
        
        Alamofire.request("http://edmeralarte.x10host.com/webservice/showallfaculty.php", method: .post, encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    // print("SUCCESS",data)
                    
                    
                    
                    //start
                    
//                    let json = JSON(data)
//                    print("JSON DATA  \(json)")
//                    if let quote = json["data"]["stores"]["stores"].array{
//                        
//                        
//                        
//                        
//                        for price in quote{
//                            
//                            let storename: String = price["store_name"].stringValue
//                            let prce: String = price["price"].stringValue
//                            let tit: String = price["title"].stringValue
//                            let objprice = ["price": prce]
//                            let objTitle = ["title": tit]
//                            let objstorename = ["store_name": storename]
//                            self.priceData.append(objprice)
//                            self.tiTle.append(objTitle)
//                            self.store_name.append(objstorename)
//                            print(prce)
//                            print(tit)
//                            print(storename)
//                        }
//                        
//                        
//                        for image in quote{
//                            let pic: String = image["image"][0]["image_md"].stringValue
//                            print(pic)
//                            let obj = ["image": pic]
//                            self.petitions.append(obj)
//                            
//                            
//                        }
//                        self.cView.reloadData()
//                        print(self.petitions.count)
//                    }
                  //end
                    
                }
                break
                
            case .failure(_):
                print("ERROR",response.result.error)
                break
                
            }
        }


        // Do any additional setup after loading the view.
    }

 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
