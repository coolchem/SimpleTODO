//
//  DetailsViewController.h
//  SimpleTODO
//
//  Created by Sai anuja reddy Kadi Reddy on 7/22/16.
//  Copyright © 2016 Varun Reddy Nalagatla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *TodoList;
- (IBAction)todoBackClicked:(id)sender;

@property(strong, nonatomic) NSString * detailText;
@property(strong, nonatomic) NSString * status, *editkey;
- (IBAction)shareClicked:(id)sender;
@property(strong,nonatomic) FIRDatabaseReference *ref;
@end
