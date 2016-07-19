//
//  ViewController.h
//  SimpleTODO
//
//  Created by Varun Reddy Nalagatla on 6/18/16.
//  Copyright © 2016 Varun Reddy Nalagatla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>


@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *todoText;
@property (weak, nonatomic) IBOutlet UITableView *todoTableView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIView *tableViewView;
- (IBAction)logOutClicked:(id)sender;
- (IBAction)addButtonClicked:(id)sender;
- (IBAction)checkButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lable;

@end

