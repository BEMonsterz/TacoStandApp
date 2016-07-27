//
//  AddTacosViewController.swift
//  TacoStandApp
//
//  Created by Bryan Ayllon on 7/26/16.
//  Copyright © 2016 Bryan Ayllon. All rights reserved.
//

import UIKit

class AddTacosViewController: UIViewController {

    
    @IBOutlet weak var tacoName: UITextField!
    @IBOutlet weak var tacoPrice: UITextField!
    @IBOutlet weak var tacosURL: UITextField!

   
    
    
    @IBAction func close() {
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    
    
    @IBAction func postButton() {
        self.dismissViewControllerAnimated(true, completion: nil)

        let url = "https://taco-stand.herokuapp.com/api/tacos/"
        
        guard let tacoURL = NSURL(string: url) else {
            fatalError("URL incorrect")
        }
        
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: tacoURL)
        request.HTTPMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        
        let parameters = ["name":"\(tacoName.text!)","price":"\(tacoPrice.text!)","photo_url": "\(tacosURL.text!)"]

  
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(parameters, options: .PrettyPrinted)
        
        session.dataTaskWithRequest(request) { (data :NSData?, response :NSURLResponse?, error: NSError?) in
            
            
            print("finished")
            
            }.resume()
        
        
    }
    
}
