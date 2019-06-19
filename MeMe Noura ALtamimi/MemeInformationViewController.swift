//
//  MemeInformationViewController.swift
//  MeMe Noura ALtamimi
//
//  Created by noura tamimi on 29/04/2019.
//  Copyright © 2019 noura tamimi. All rights reserved.
//

import UIKit

class MemeInformationViewController: UIViewController {

 
    var ImageInformation = UIImage()
  
    
    @IBOutlet weak var imageView: UIImageView!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = ImageInformation
    }
}
