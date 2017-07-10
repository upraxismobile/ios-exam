//
//  PersonTableViewController.swift
//  Exam
//
//  Created by Mark Angelo Noquera on 09/07/2017.
//  Copyright © 2017 Mark Angelo Noquera. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class PersonTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var personList = [PersonViewModel]()
    
    var persons: Variable<[PersonViewModel]>!
    
    let disposeBag = DisposeBag()
    let endpointService = EndpointService()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Persons"
        tableView.estimatedRowHeight = 80
        
        endpointService.getParsePerson { (response, error) in
            guard error == nil else {
                self.displayError(error)
                return
            }
            
            for person in response as! [Person] {
                self.personList.append(PersonViewModel(person: person))
            }
            
            self.persons = Variable(self.personList)
            self.bindData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = sender as? NSIndexPath, let detailVC = segue.destination as? PersonDetailViewController else {
            return
        }
        detailVC.personViewModel = persons.value[indexPath.row]
    }
    
    // MARK: - Utils
    
    func bindData() {
        persons.asObservable().bind(to: self.tableView.rx.items(cellIdentifier: "PersonCell", cellType: PersonTableViewCell.self)) {
            (index, personViewModel: PersonViewModel, cell) in
            cell.personViewModel = personViewModel
            }.addDisposableTo(disposeBag)
        
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self]indexPath in
                self?.performSegue(withIdentifier: "showDetail", sender: indexPath)
                self?.tableView.deselectRow(at: indexPath, animated: true)
            }).addDisposableTo(disposeBag)
    }
    
    func displayError(_ error: Error?) {
        if let e = error {
            let alertController = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // do nothing...
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}







