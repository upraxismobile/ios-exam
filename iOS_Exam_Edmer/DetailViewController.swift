//
//  DetailViewController.swift
//  iOS_Exam_Edmer
//
//  Created by Edmer Alarte on 15/07/2017.
//  Copyright © 2017 Edmer Alarte. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class DetailViewController: UIViewController {
    var id:String?
    
    @IBOutlet weak var Country: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    
    
    var store_name = [[String: String]]()
    var tiTle = [[String: String]]()
    var petitions = [[String: String]]()
    var priceData = [[String: String]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let parameterss: [String: Any] = [
            "UserID": id!
        ]
        print("ID IN DETAILVIEW CONTROLLER \(id!)")
        Alamofire.request("http://edmeralarte.x10host.com/webservice/showall3.php", method: .get, parameters: parameterss, encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{

                    let json = JSON(data)
                    if let quote = json["users"].array{

                        for price in quote{
                            
                            let user_id: String = price["UserID"].stringValue
                            let country: String = price["country"].stringValue
                            let Age: String = price["Age"].stringValue
                            let firstName: String = price["FName"].stringValue
                            let lastName: String = price["LName"].stringValue
                            let image_name: String = price["image_name"].stringValue
                            let Address: String = price["address"].stringValue
                            let domain = "http://edmeralarte.x10host.com/"
                            print("PIC NAME:  \(domain+image_name)")
                            let url = URL(string: domain+image_name)
                            let placeholderImage = UIImage(named: "irene")!
                            print(user_id)
                            print(country)
                            print(Age)
                            print(firstName)
                            print(lastName)
                            print(image_name)
                            print(Address)
                            self.age.text = "Age: \(Age)"
                            self.name.text = firstName + " " + lastName
                            self.Country.text = country
                            self.address.text = Address
                            self.photo.af_setImage(withURL: url!, placeholderImage: placeholderImage, filter: nil,imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: true, completion: nil)
                        }

                    }

                }
                break
                
            case .failure(_):
                print("ERROR",response.result.error)
                break
                
            }
        }
        
    }
    
@IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
