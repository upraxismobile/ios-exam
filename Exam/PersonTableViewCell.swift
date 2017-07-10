//
//  PersonTableViewCell.swift
//  Exam
//
//  Created by Mark Angelo Noquera on 09/07/2017.
//  Copyright © 2017 Mark Angelo Noquera. All rights reserved.
//

import UIKit
import RxSwift

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    var personViewModel: PersonViewModel? {
        didSet {
            guard let pvm = personViewModel else {
                return
            }
            
            pvm.firstNameText.bind(to: titleLabel.rx.text).addDisposableTo(self.disposeBag)
            pvm.lastNameText.bind(to: detailLabel.rx.text).addDisposableTo(self.disposeBag)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
