//
//  HttpService.swift
//  Exam
//
//  Created by Mark Angelo Noquera on 09/07/2017.
//  Copyright © 2017 Mark Angelo Noquera. All rights reserved.
//

import UIKit
import RxCocoa
import Alamofire
import RxAlamofire
import RxSwift
import ObjectMapper
import Cache

typealias ResultBlock = (_ response: Any?, _ error: Error?) -> Void

class HttpService: NSObject {
 
    let disposeBag = DisposeBag()
    let cache = SpecializedCache<JSON>(name: "JSONCache")

    let urlString = "http://54.255.133.47:9090/exam/people"
    
    func getService(completion: @escaping ResultBlock) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        RxAlamofire.requestJSON(.get, urlString)
            .debug()
            .subscribe(onNext: { (response, json) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.cache.async.addObject(JSON.array(json as! [Any]), forKey: "JSONResponse")
                completion(json as Any, nil)
            }, onError: {(error) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                completion(nil, error)
            })
            .addDisposableTo(disposeBag)
    }
}

class EndpointService {
    
    let httpService = HttpService()
    let cache = SpecializedCache<JSON>(name: "JSONCache")
    
    func getParsePerson(completion: @escaping ResultBlock) {
        httpService.getService { (object, error) in
            guard error == nil else {
                self.cache.object(forKey: "JSONResponse") != nil ?
                    completion(self.personArray(array: self.cache.object(forKey: "JSONResponse")?.object as! NSArray), nil) :
                    completion(nil, error)
                return
            }
            
            completion(self.personArray(array: object as! NSArray), nil)
            
        }
    }
    
    func personArray(array: NSArray) -> [Person] {
        var persons = [Person]()
        for personArray in array {
            let person = Mapper<Person>().map(JSON: personArray as! [String : Any])
            persons.append(person!)
        }
        return persons
    }
}

