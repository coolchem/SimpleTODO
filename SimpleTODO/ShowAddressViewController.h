//
//  ShowAddressViewController.h
//  SimpleTODO
//
//  Created by Sai anuja reddy Kadi Reddy on 8/29/16.
//  Copyright © 2016 Varun Reddy Nalagatla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface ShowAddressViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *MyTableView;
- (IBAction)discloserButtonClicked:(id)sender;
- (IBAction)showDirectionsClicked:(id)sender;

@end
