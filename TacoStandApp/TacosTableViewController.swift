//
//  PopulateTableViewController.swift
//  PopulateTableUsingJSON
//
//  Created by Bryan Ayllon on 7/26/16.
//  Copyright © 2016 Bryan Ayllon. All rights reserved.
//

import UIKit

class TacosTableViewController: UITableViewController {
    
    var tacos = [Taco]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        taco()
        
        
    }
    
    private func taco() {
        
        let populateAPI = "https://taco-stand.herokuapp.com/api/tacos"
        
        guard let url = NSURL(string: populateAPI) else {
            fatalError("Invalid URL")
        }
        
        let session = NSURLSession.sharedSession()
        
        
        session.dataTaskWithURL(url) { (data :NSData?, response :NSURLResponse?, error :NSError?) in
            
            guard let jsonResult = NSString(data: data!, encoding: NSUTF8StringEncoding) else {
                fatalError("Unable to format data")
            }
            
            let tacoDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            
            let tacoArray = tacoDictionary["tacos"]as! NSArray
            
            
            
            for item in tacoArray {
                
                let moreTacos = Taco()
                moreTacos.name = item.valueForKey("name") as! String
                
                moreTacos.photo_url = item.valueForKey("photo_url") as! String
                
                self.tacos.append(moreTacos)
                
                
                
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                
            self.tableView.reloadData()
                
            })
            
            
            
            }.resume()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tacos.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let taco = self.tacos[indexPath.row]
        
        let q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(q){
            
            guard let imageURL = NSURL(string: taco.photo_url) else {
                fatalError("Invalid URL")
            }
            
            let imageData = NSData(contentsOfURL: imageURL)
            
            let image = UIImage(data: imageData!)
            dispatch_async(dispatch_get_main_queue(),{
                
                cell.imageView?.image = image
                self.tableView.reloadData()
            })
        }
        
        
        
        cell.textLabel?.text = taco.name
        
        return cell
    }
    
}
