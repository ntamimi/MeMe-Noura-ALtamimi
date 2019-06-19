//
//  MemeCollectionViewController.swift
//  MeMe Noura ALtamimi
//
//  Created by noura tamimi on 29/04/2019.
//  Copyright © 2019 noura tamimi. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UIViewController , UICollectionViewDelegate,UICollectionViewDataSource{

    
        
        @IBOutlet var memeCollectionView: UICollectionView!
        var memes : [Meme]!{
            let object = UIApplication.shared.delegate
            let appDelegate = object as! AppDelegate
            return appDelegate.memes
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
      
        }
        
     func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            collectionView.reloadData()
        }
        
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return memes.count
        }
        
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! Meme1CollectionViewCell
            let meme = self.memes[(indexPath as NSIndexPath).row]
            print(meme.topText)
            
            cell.viewImage?.image = meme.memedImage
            
            return cell
        }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let indexPath = memeCollectionView.indexPathsForSelectedItems {
                guard let destiontionVc = segue.destination as? MemeDetailsViewController else {return}
                let selectedRow = indexPath.startIndex
                destiontionVc.dataImage = memes[selectedRow].memedImage
            }
        }
        
        
        override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            performSegue(withIdentifier: "sendData", sender: self)
            
            
            
        }
}
