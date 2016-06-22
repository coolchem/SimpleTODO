//
//  LoginViewController.h
//  SimpleTODO
//
//  Created by Sai anuja reddy Kadi Reddy on 6/20/16.
//  Copyright © 2016 Varun Reddy Nalagatla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property(weak, nonatomic) IBOutlet UITextField *emailField;
@property(weak, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)LoginClicked:(id)sender;
- (IBAction)signupClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *passwordError;

@end
