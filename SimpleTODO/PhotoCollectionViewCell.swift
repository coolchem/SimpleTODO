//
//  PhotoCollectionViewCell.swift
//  SimpleTODO
//
//  Created by Sai anuja reddy Kadi Reddy on 7/28/16.
//  Copyright © 2016 Varun Reddy Nalagatla. All rights reserved.
//

import UIKit
import Firebase



class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func setImage(_ image: UIImage) -> Void {
    
       // let name = nameTextField.text
        
        imageView.image = image
    }
    
        
}
