//
//  SignUPViewController.h
//  SimpleTODO
//
//  Created by Sai anuja reddy Kadi Reddy on 6/20/16.
//  Copyright © 2016 Varun Reddy Nalagatla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUPViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)submitButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;


@end
