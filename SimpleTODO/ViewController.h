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
@property (weak, nonatomic) IBOutlet UITextView *todoText;
@property (weak, nonatomic) IBOutlet UITableView *todoTableView;
//- (IBAction)LogoutClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIView *tableViewView;
//- (IBAction)logOutClicked:(id)sender;
- (IBAction)addButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButton;
@property (weak, nonatomic) IBOutlet UILabel *lable;
//@property (strong, nonatomic) IBOutlet UITextView *todoList;
//@property (nonatomic, readonly) NSInteger row;

@end

