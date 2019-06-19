//
//  MemeCollectionViewController.swift
//  MeMe Noura ALtamimi
//
//  Created by noura tamimi on 29/04/2019.
//  Copyright © 2019 noura tamimi. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UIViewController , UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var memes : [Meme]!{
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionCell", for: indexPath) as! MemeCollectionViewCell
       
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.MemeImage.image = meme.memedImage
        
        return cell
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CollectionCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "MemeCollectionCell")
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = collectionView.indexPathsForSelectedItems {
            guard let destiontionVc = segue.destination as? MemeInformationViewController
                else {return}
            let selectedRow = indexPath.startIndex
            destiontionVc.ImageInformation = memes[selectedRow].memedImage
        }
    }
    
    
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "sendInformation", sender: self)
        
        
        
    }


   
}
