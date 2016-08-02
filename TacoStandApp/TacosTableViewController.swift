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
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(TacosTableViewController.tableReloaded(_:)), name: "reload", object: nil)
        taco()
        
        
    }
    
    private func taco() {
        
        let tacoAPI = "https://taco-stand.herokuapp.com/api/tacos/"
        
        guard let url = NSURL(string: tacoAPI) else {
            fatalError("Invalid URL")
        }
        
        let session = NSURLSession.sharedSession()
        
        
        session.dataTaskWithURL(url) { (data :NSData?, response :NSURLResponse?, error :NSError?) in
            
            guard let jsonResult = NSString(data: data!, encoding: NSUTF8StringEncoding) else {
                fatalError("Unable to format data")
            }
            
            let tacoDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            
            let tacoArray = tacoDictionary["tacos"] as! NSArray;
            
            
            for taco in tacoArray {
                let myTaco = Taco()
                myTaco.name = taco.valueForKey("name") as! String
                
                myTaco.photo_url = taco.valueForKey ("photo_url")as! String
                
                
                myTaco.price = taco.valueForKey("price") as! String
                
                self.tacos.append(myTaco)
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
                
            })
            
            
            }.resume()
    }
    
    
    func tableReloaded(notfication: NSNotification) {
        
        taco()
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.tacos.count

    }
    
   
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        
        
        let elTaco = self.tacos[indexPath.row]
        
        guard let imageURL = NSURL(string: elTaco.photo_url) else {
            fatalError("Invalid URL")
        }
        
//        let imageData = NSData(contentsOfURL: imageURL)
//        
//        let image = UIImage(data: imageData!)
//        
//        cell.imageView?.image = image
//        
//        print(elTaco.photo_url)
        
        cell.textLabel?.text = elTaco.name
        cell.detailTextLabel?.text = elTaco.price
        

        return cell
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "detailTaco"){
            let tacoInfoViewController = segue.destinationViewController as! DisplayTacoViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow?.row
            
            tacoInfoViewController.allTacos = tacos[indexPath!]
        }
    }
}
