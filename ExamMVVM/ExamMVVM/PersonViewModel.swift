//
//  PersonViewModel.swift
//  ExamMVVM
//
//  Created by Michelle Conchina on 9/7/17.
//  Copyright © 2017 Michelle Conchina. All rights reserved.
//

import UIKit
import EGOCache
import Cache

class PersonViewModel: NSObject {
    var personList = [Person]()
    let cache = HybridCache(name: "CacheObject")
    
    func getPersonList(completion: @escaping () -> Void) {
        let urlString = "https://my-json-server.typicode.com/michelleconchina/demo/list"
        //Check available cache
        self.cache.object("reponseJSONCache") { (jsonList:JSON?) in
            if jsonList != nil {
                print(" .....completion")
                self.personList = PersonHelper().convertToPersonList(list: jsonList!.object)
                completion()
            } else {
                print(" ....getRequest")
                Service().request(urlString: urlString, withBlock: { (response, error) in
                    if error == nil {
                        self.personList = PersonHelper().convertToPersonList(list: response!)
                        completion()
                    } else {
                        completion()
                    }
                })
                
            }
        }
    }
    
    func numberOfRows(in section: Int) -> Int {
        return self.personList.count 
    }
    
    func fullNameString(for indexPath: IndexPath) -> String {
        return self.personList[indexPath.row].firstName! + " " + self.personList[indexPath.row].lastName!
    }
    
    func emailAdressString(for indexPath: IndexPath) -> String {
        return self.personList[indexPath.row].emailAddress!
    }    
}
