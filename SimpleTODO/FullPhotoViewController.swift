//
//  FullPhotoViewController.swift
//  SimpleTODO
//
//  Created by Sai anuja reddy Kadi Reddy on 7/28/16.
//  Copyright © 2016 Varun Reddy Nalagatla. All rights reserved.
//

import UIKit
import Firebase

class FullPhotoViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage!
    var userRef: FIRDatabaseReference = FIRDatabaseReference()
    var uid: String = String()
    var key1: NSString = NSString()
   // var fullvalues: NSDictionary = NSDictionary()
    var deletekey: String = String()
    
    override func viewDidLoad() {
        userRef = FIRDatabase.database().reference(fromURL: "https://todoslogin-24559.firebaseio.com/")
        uid = FIRAuth.auth()!.currentUser!.uid
        userRef = userRef.child(uid)
        userRef = userRef.child("image")
        
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.hidesBarsOnTap = true
        imageView.image = image

            }
    
    @IBAction func deleteClicked(_ sender: AnyObject) {
        
      /* var data: NSData = NSData()
        
        // if let image = photoImageView.image {
        var deletekey:NSArray = NSArray()
        
        data = UIImageJPEGRepresentation(image,0.1)!
        // }
        for items in fullvalues
        {
            let dictkey = items.key
            //let dictvalue = fullvalues
            let str = fullvalues.valueForKey(dictkey as! String) as! String
            var decodedData:NSData = NSData()
            decodedData = NSData(base64EncodedString: str, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)!
            if (decodedData.isEqualToData(data))
            {
            deletekey = self.fullvalues.allKeysForObject(base64String)
            let arrayvalue = deletekey.objectAtIndex(0) as! String*/
            let str = "https://todoslogin-24559.firebaseio.com/" + uid + "/" + "image/" + deletekey
            let userRef1 = FIRDatabase.database().reference(fromURL: str)
            userRef1.removeValue()
            self.navigationController?.popToRootViewController(animated: true)
           /* break
            }
        }*/
        
    }

    @IBAction func cancelClicked(_ sender: AnyObject) {
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    @IBAction func shareClicked(_ sender: AnyObject) {
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
