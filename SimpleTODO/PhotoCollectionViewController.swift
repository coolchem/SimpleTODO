//
//  PhotoViewControllerCollectionViewController.swift
//  SimpleTODO
//
//  Created by Sai anuja reddy Kadi Reddy on 8/8/16.
//  Copyright © 2016 Varun Reddy Nalagatla. All rights reserved.
//

import UIKit
import Photos
import Firebase

private let reuseIdentifier = "Cell"

class PhotoViewControllerCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var PhotoBarButton: UIBarButtonItem!
    // Get a reference to the storage service, using the default Firebase App
    var userRef: FIRDatabaseReference = FIRDatabaseReference()
    
    
    var uid: String = String()
    var key1: NSString = NSString()
    var dictvalue: NSDictionary = NSDictionary()
    var arrayvalue: String = String()
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedimage: NSMutableArray = NSMutableArray()
    var encodedimages: NSMutableArray = NSMutableArray()
    var fullimage: UIImage = UIImage()
    
    override func viewDidLoad() {
        PhotoBarButton.target = self.revealViewController()
        PhotoBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer());
        userRef = FIRDatabase.database().referenceFromURL("https://todoslogin-24559.firebaseio.com/")
        uid = FIRAuth.auth()!.currentUser!.uid
        userRef = userRef.child(uid)
        userRef = userRef.child("image")
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        self.loadDataFromFirebase()
        
        
    }
    
    func loadDataFromFirebase() {
        
        //UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        self.collectionView.reloadData()
        userRef.observeEventType(.Value, withBlock: { snapshot in
            //var tempItems = [NSDictionary]()
            
            if (self.selectedimage.count == 0 || self.encodedimages.count == 0){
                self.selectedimage = NSMutableArray()
                self.encodedimages = NSMutableArray()
            }
            else{
                self.selectedimage.removeAllObjects()
                self.encodedimages.removeAllObjects()
                // Do your stuff here
            }
            
            for item in snapshot.children {
                let child = item as! FIRDataSnapshot
                let dictkey = child.key
                self.dictvalue = snapshot.value as! NSDictionary
                let str = self.dictvalue.valueForKey(dictkey) as! String
                self.encodedimages.addObject(str)
                var decodedData:NSData = NSData()
                decodedData = NSData(base64EncodedString: str , options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)!
                
                let decodedimage = UIImage(data: decodedData)!
                
                self.selectedimage.addObject(decodedimage)
            }
            
            
            self.collectionView.reloadData()
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cameraClicked(sender: AnyObject) {
        
        if (UIImagePickerController.isSourceTypeAvailable(.Camera))
        {
            //load camera
            let picker: UIImagePickerController = UIImagePickerController()
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.delegate = self
            picker.allowsEditing = false
            self.presentViewController(picker, animated: true, completion: nil)
            
        }else{
            //no camera available
            let alert = UIAlertController(title: "ERROR", message: "No Camera Available", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: {(alertAction)in
                
                alert.dismissViewControllerAnimated(true, completion: nil)
                
            }))
        }
    }
    
    @IBAction func folderClicked(sender: AnyObject) {
        
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier!  as String == "photoSegue")
        {
            let fullPhoto: FullPhotoViewController = segue.destinationViewController as! FullPhotoViewController
            fullPhoto.image = self.fullimage
            fullPhoto.deletekey = self.arrayvalue
            
        }
    }
    
    // CollectionView DelegateMethods
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        fullimage = self.selectedimage.objectAtIndex(indexPath.row) as! UIImage
        var deletekey:NSArray = NSArray()
        let i = self.encodedimages.objectAtIndex(indexPath.row)
        deletekey = self.dictvalue.allKeysForObject(i)
        arrayvalue = deletekey.objectAtIndex(0) as! String
        
        /* NSArray *deletekey;
         i = [self.data objectAtIndex:indexPath.row];
         deletekey = [[NSArray alloc] initWithObjects:[dictvalue allKeysForObject:i], nil];
         //NSLog(@"deletekey%@",deletekey);
         editkey= [[deletekey objectAtIndex: 0]componentsJoinedByString:@""];*/
        
        performSegueWithIdentifier("photoSegue", sender: self)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    @available(iOS 6.0, *)
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.selectedimage.count;
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @available(iOS 6.0, *)
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        
        let Cell: PhotoCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("photoCell", forIndexPath: indexPath) as! PhotoCollectionViewCell
        
        let image = self.selectedimage.objectAtIndex(indexPath.row) as! UIImage
        //Cell.backgroundColor = UIColor .redColor()
        Cell.setImage(image);
        return Cell;
    }
    
    
    // UIImagePickerControllerDelegate Methods
    
    
    @available(iOS 2.0, *)
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        // selectedimage.addObject(image)
        
        
        key1 = userRef.childByAutoId().key
        
        var data: NSData = NSData()
        
        // if let image = photoImageView.image {
        data = UIImageJPEGRepresentation(image,0.1)!
        // }
        
        let base64String = data.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        let user: NSDictionary = [key1:base64String]
        userRef.updateChildValues(user as [NSObject : AnyObject])
    }
    
    
    @available(iOS 2.0, *)
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    // UICollectionViewDelegateFlowLayout methods
    
    /* func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat
     {
     return 2
     }
     
     func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat
     {
     return 1
     }*/
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
