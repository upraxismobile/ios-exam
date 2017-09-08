//
//  PersonTableViewController.swift
//  ExamMVVM
//
//  Created by Michelle Conchina on 9/6/17.
//  Copyright © 2017 Michelle Conchina. All rights reserved.
//

import UIKit

class PersonTableViewController: UITableViewController {

    var personList = [Person]()
    @IBOutlet var personViewModel: PersonViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personViewModel.getPersonList { 
            self.tableView.reloadData()
        }
        self.tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personViewModel.numberOfRows(in: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        cell.textLabel?.text = personViewModel.fullNameString(for: indexPath)
        cell.detailTextLabel?.text = personViewModel.emailAdressString(for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailsTableViewController") as! DetailsTableViewController
        detailViewController.personDetails = personViewModel.personList[indexPath.row]
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
