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
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var bday: UILabel!
    @IBOutlet weak var mobile: UILabel!
    
    @IBOutlet weak var contactperson: UILabel!
    
    @IBOutlet weak var contactPersonNumber: UILabel!
    let domain = "http://edmeralarte.x10host.com/"
    
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
                    if let human = json["users"].array{
                        
                        for person in human{
                            
                            let user_id: String = person["UserID"].stringValue
                            let country: String = person["country"].stringValue
                            let Age: String = person["Age"].stringValue
                            let firstName: String = person["FName"].stringValue
                            let lastName: String = person["LName"].stringValue
                            let image_name: String = person["image_name"].stringValue
                            let Address: String = person["address"].stringValue
                            let Email: String = person["email"].stringValue
                            let Mobile: String = person["mobile"].stringValue
                            let ContactPerson: String = person["contactperson"].stringValue
                            let BDate: String = person["BDate"].stringValue
                            let ContactpersonNumber: String = person["contactpersonNumber"].stringValue
                           
                            print("PIC NAME:  \(self.domain+image_name)")
                            
                            let url = URL(string: self.domain+image_name)
                            
                            print(user_id)
                            print(country)
                            print(Age)
                            print(firstName)
                            print(lastName)
                            print(image_name)
                            print(Address)
                            self.age.text = "age: \(Age)"
                            self.name.text = firstName + " " + lastName
                            self.Country.text = country
                            self.address.text = "address: \(Address)"
                            self.email.text = "email: \(Email)"
                            self.mobile.text = "mobile: \(Mobile)"
                            self.bday.text = "birthdate: \(BDate)"
                            self.contactperson.text = "contact person: \(ContactPerson)"
                            self.contactPersonNumber.text = "contact person's number: \(ContactpersonNumber)"
                            
                            let placeholderImage = UIImage(named: "irene")!
//                            self.photo.af_setImage(withURL: url!, placeholderImage: placeholderImage, filter: nil,imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: true, completion: nil)
                            
                            
                            // CACHE IMAGES AND PREVENTS LOADING FROM SOURCE WHEN CACHED
                              self.photo.sd_setImage(with: url!, placeholderImage: placeholderImage, options: [.continueInBackground, .progressiveDownload])
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
