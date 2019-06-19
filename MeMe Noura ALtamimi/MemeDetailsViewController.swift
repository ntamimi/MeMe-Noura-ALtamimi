//
//  MemeDetailsViewController.swift
//  MeMe Noura ALtamimi
//
//  Created by noura tamimi on 28/04/2019.
//  Copyright © 2019 noura tamimi. All rights reserved.
//


import UIKit

class MemeDetailsViewController: UIViewController {
    
    var dataImage = UIImage()
    //var name: String?
    
    @IBOutlet weak var imageView: UIImageView!
    //@IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = dataImage
    }
}
