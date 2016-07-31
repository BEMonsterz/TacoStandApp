//
//  DisplayTacoViewController.swift
//  TacoStandApp
//
//  Created by Bryan Ayllon on 7/26/16.
//  Copyright © 2016 Bryan Ayllon. All rights reserved.
//

import UIKit

class DisplayTacoViewController: UIViewController {
    var allTacos = Taco()
    
    
    @IBOutlet weak var tacosName: UILabel!
    @IBOutlet weak var tacosPrice: UILabel!
    @IBOutlet weak var tacosURL: UIImageView!

    
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        
        
        self.tacosName.text = self.allTacos.name
        self.tacosPrice.text = self.allTacos.price
        
        
        let tacosURL = NSURL(string: self.allTacos.photo_url)
        let imageData = NSData(contentsOfURL: tacosURL!)
        let tacoImage = UIImage(data: imageData!)
        
        self.tacosURL.image = tacoImage
        
        

//        print(tacos)
           }
    
//    func getImage(atURL urlString: String) -> UIImage! {
//        guard let url = NSURL(string: urlString) else {
//            print("String(\(urlString)) did not contain a valid URL"); return nil
//        }
//        guard let data = NSData(contentsOfURL: url) else {
//            print("TacoDetailTableViewController: Did not find image data at the URL\(url.description)"); return nil
//        }
//        let image = UIImage(data: data)
//        return image
//    }
//    
    
    
    @IBAction func close() {
    
    self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
