//
//  MemeTableViewController.swift
//  MeMe Noura ALtamimi
//
//  Created by noura tamimi on 29/04/2019.
//  Copyright © 2019 noura tamimi. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
        var memes : [Meme]!{
            let object = UIApplication.shared.delegate
            let appDelegate = object as! AppDelegate
            return appDelegate.memes
        }
        
        @IBOutlet weak var tableView: UITableView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
                   self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MemeTableCell")
            // Do any additional setup after loading the view.
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            tableView.reloadData()
            
        }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            print("selected\(memes.count)")
            return memes.count
        }
    
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "MemeTableCell", for: indexPath)
            let meme = self.memes[(indexPath as NSIndexPath).row]
            
            cell.textLabel?.text = meme.topText+"**"+meme.bottomText
            cell.imageView?.image = meme.memedImage
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "sendDetails", sender: self)
        }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            guard let destiontionVc = segue.destination as? MemeInformationViewController else {return}
            let selectedRow = indexPath.row
            destiontionVc.ImageInformation = memes[selectedRow].memedImage
         }
       }

}
