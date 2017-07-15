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
                
                    
                    
                    
                    //start
                    
                    let json = JSON(data)
                    
                    if let quote = json["users"].array{
                        
                        
                        
                        
                        for price in quote{
                            
                            let country: String = price["country"].stringValue
                            let prce: String = price["Age"].stringValue
                            let firstName: String = price["FName"].stringValue
                            let lastName: String = price["LName"].stringValue
                            let objprice = ["Age": prce]
                            let objTitle = ["name": firstName]
                            let objstorename = ["country": country]
                            self.priceData.append(objprice)
                            self.tiTle.append(objTitle)
                            self.store_name.append(objstorename)
                            
                            self.petitions.append(objprice)
                            
                            print("Age \(price["Age"])")
                           print("name \(price["FName"]) \(price["LName"])")
                            print(country)
                        }
                        
                        
                     
                        self.cView.reloadData()
                        print("COUNT OF ITEMS \(self.petitions.count)")
                    }
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
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return petitions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.photoCell, for: indexPath) as! PhotoCell
        print("HELLO cellForItemAt")
        
        let petition = petitions[indexPath.row]
        
//        let url = URL(string: petition["image"]!)!
//        let placeholderImage = UIImage(named: "MobileGadgets")!
//        
//        
//        print("collectionURL \(url)")
        
        cell.age.text = "Age \(priceData[indexPath.row]["Age"]!)"
       
        cell.name.text = tiTle[indexPath.row]["name"]
        let compnme =  store_name[indexPath.row]["country"]
        if compnme  != nil {
            cell.country.text = "\(self.store_name[indexPath.row]["country"]!)"
        }
//        cell.photoImageView.af_setImage(withURL: url, placeholderImage: placeholderImage, filter: nil,imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: true, completion: nil)
//        print("cellForItemAt \(petition["image"]!)")
        
        
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

}
