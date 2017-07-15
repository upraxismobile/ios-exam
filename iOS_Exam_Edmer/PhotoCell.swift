//
//  PhotoCellCollectionViewCell.swift
//  iOS_Exam_Edmer
//
//  Created by Edmer Alarte on 15/07/2017.
//  Copyright © 2017 Edmer Alarte. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
   
    
    @IBOutlet weak var country: UILabel!
  
    @IBOutlet weak var name: UILabel!
   
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var imageName: String!{
        didSet{
            photoImageView.image = UIImage(named:imageName )
        }
        
    }

    
    
}
