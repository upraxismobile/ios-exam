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
    var id:String!
    var store_name = [[String: String]]()
    var tiTle = [[String: String]]()
    var petitions = [[String: String]]()
    var priceData = [[String: String]]()
    var imagePic = [[String: String]]()
    var user_Id = [[String: String]]()
    
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
      
        
        Alamofire.request("http://edmeralarte.x10host.com/webservice/showallfaculty.php", method: .post, encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    
                    
                    
                    
                    //start
                    
                    let json = JSON(data)
                    
                    if let human = json["users"].array{
                        
                        
                        
                        
                        for person in human{
                            
                            let user_id: String = person["UserID"].stringValue
                            let country: String = person["country"].stringValue
                            let prce: String = person["Age"].stringValue
                            let firstName: String = person["FName"].stringValue
                            let lastName: String = person["LName"].stringValue
                            let image_name: String = person["image_name"].stringValue
                            
                            let objImageName = ["image_name": image_name]
                            let objprice = ["Age": prce]
                            let objTitle = ["name": firstName]
                            let objstorename = ["country": country]
                            let objImage_Name = ["image_name": image_name]
                            let objuser_id = ["user_id": user_id]
                            
                            self.user_Id.append(objuser_id)
                            self.priceData.append(objprice)
                            self.tiTle.append(objTitle)
                            self.store_name.append(objstorename)
                            self.imagePic.append(objImage_Name)
                            self.petitions.append(objprice)
                            
                            print("USER_ID \(person["UserID"])")
                            print("image_name \(person["image_name"])")
                            print("Age \(person["Age"])")
                            print("name \(person["FName"]) \(person["LName"])")
                            print(country)
                        }
                        
                        self.cView.reloadData()
                        print("COUNT OF ITEMS \(self.petitions.count)")
                    }
                    
                }
                break
                
            case .failure(_):
                print("ERROR",response.result.error)
                break
                
            }
        }
        
    }
    
    
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return petitions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.photoCell, for: indexPath) as! PhotoCell

        let domain = "http://edmeralarte.x10host.com/"
        print("PIC NAME:  \(domain+imagePic[indexPath.row]["image_name"]!)")
        let url = URL(string: domain+imagePic[indexPath.row]["image_name"]!)
        
        let placeholderImage = UIImage(named: "irene")!

        cell.age.text = "age \(priceData[indexPath.row]["Age"]!)"
        cell.name.text = tiTle[indexPath.row]["name"]
        let compnme =  store_name[indexPath.row]["country"]
        if compnme  != nil {
            cell.country.text = "\(self.store_name[indexPath.row]["country"]!)"
        }
    
        
        // CACHE IMAGES AND PREVENTS LOADING FROM SOURCE WHEN CACHED
        cell.photoImageView.sd_setImage(with: url, placeholderImage: placeholderImage, options: [.continueInBackground, .progressiveDownload])
        
        return cell
    }
    
    //Use for size
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var size = CGSize(width: 200, height: 10)
        return size
        
    }
    //Use for interspacing
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? PhotoCell,
            let indexPath = self.cView.indexPath(for: cell) {
            
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! DetailViewController
            controller.id = user_Id[indexPath.row]["user_id"]!
            
            
        }
    }
    
}
