//
//  Copyright (c) 2016 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "EmailViewController.h"
#import "UIViewController+Alerts.h"


@import FirebaseAuth;

@interface EmailViewController ()
@property(weak, nonatomic) IBOutlet UITextField *emailField;
@property(weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@end

@implementation EmailViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1.png"]];
    //self.emailField.layer.borderColor= UIColor(
    
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField              // called when 'return' key pressed. return NO to ignore.
{
    if(self.nameTextField.text != nil && self.passwordTextField.text != nil)
    {
        self.submitButton.enabled = YES;
    }
    [self.nameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.emailField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    return YES;
}

- (IBAction)loginClicked:(id)sender {
    
}

- (IBAction)didTapEmailLogin:(id)sender {
  [self showSpinner:^{
    // [START headless_email_auth]
    [[FIRAuth auth] signInWithEmail:_emailField.text
                           password:_passwordField.text
                         completion:^(FIRUser *user, NSError *error) {
                           // [START_EXCLUDE]
                           [self hideSpinner:^{
                             if (error) {
                               [self showMessagePrompt:error.localizedDescription];
                               return;
                             }
                             //[self.navigationController popViewControllerAnimated:YES];
                               [self performSegueWithIdentifier:@"login" sender:self];
                           }];
                           // [END_EXCLUDE]
                         }];
    // [END headless_email_auth]
  }];
}

/** @fn requestPasswordReset
 @brief Requests a "password reset" email be sent.
 */

- (IBAction)didRequestPasswordReset:(id)sender {
  [self
      showTextInputPromptWithMessage:@"Email:"
                     completionBlock:^(BOOL userPressedOK, NSString *_Nullable userInput) {
                       if (!userPressedOK || !userInput.length) {
                         return;
                       }

                       [self showSpinner:^{
                         // [START password_reset]
                         [[FIRAuth auth]
                             sendPasswordResetWithEmail:userInput
                                             completion:^(NSError *_Nullable error) {
                                               // [START_EXCLUDE]
                                               [self hideSpinner:^{
                                                 if (error) {
                                                   [self
                                                       showMessagePrompt:error
                                                                             .localizedDescription];
                                                   return;
                                                 }

                                                 [self showMessagePrompt:@"Sent"];
                                               }];
                                               // [END_EXCLUDE]
                                             }];
                         // [END password_reset]
                       }];
                     }];
}

/** @fn getProvidersForEmail
 @brief Prompts the user for an email address, calls @c FIRAuth.getProvidersForEmail:callback:
 and displays the result.
 */
- (IBAction)didGetProvidersForEmail:(id)sender {
  [self
      showTextInputPromptWithMessage:@"Email:"
                     completionBlock:^(BOOL userPressedOK, NSString *_Nullable userInput) {
                       if (!userPressedOK || !userInput.length) {
                         return;
                       }

                       [self showSpinner:^{
                         // [START get_providers]
                         [[FIRAuth auth]
                             fetchProvidersForEmail:userInput
                                         completion:^(NSArray<NSString *> *_Nullable providers,
                                                      NSError *_Nullable error) {
                                           // [START_EXCLUDE]
                                           [self hideSpinner:^{
                                             if (error) {
                                               [self showMessagePrompt:error.localizedDescription];
                                               return;
                                             }

                                             [self showMessagePrompt:
                                                       [providers componentsJoinedByString:@", "]];
                                           }];
                                           // [END_EXCLUDE]
                                         }];
                         // [END get_providers]
                       }];
                     }];
}
- (IBAction)signupClicked:(id)sender {
    [self performSegueWithIdentifier:@"signup" sender:self];
}

- (IBAction)didCreateAccount:(id)sender {
 /*[self
    showTextInputPromptWithMessage:@"Email:"
                     completionBlock:^(BOOL userPressedOK, NSString *_Nullable email) {
                       if (!userPressedOK || !email.length) {
                         return;
                       }

                       [self
                           showTextInputPromptWithMessage:@"Password:"
                                          completionBlock:^(BOOL userPressedOK,
                                                            NSString *_Nullable password) {
                                            if (!userPressedOK || !password.length) {
                                              return;
                                            }*/
    if(self.passwordTextField.text.length >= 6)
    {

                                            [self showSpinner:^{
                                              // [START create_user]
                                              [[FIRAuth auth]
                                                  createUserWithEmail:self.nameTextField.text
                                                             password:self.passwordTextField.text
                                                           completion:^(FIRUser *_Nullable user,
                                                                        NSError *_Nullable error) {
                                                             // [START_EXCLUDE]
                                                             [self hideSpinner:^{
                                                               if (error) {
                                                                 [self
                                                                     showMessagePrompt:
                                                                         error
                                                                             .localizedDescription];
                                                                 return;
                                                               }
                                                               NSLog(@"%@ created", user.email);
                                                               //[self.navigationController popViewControllerAnimated:YES];
                                                               //  UIStoryboard *mystoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                                                // LoginViewController *LoginViewController = [mystoryboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                                                                // [self presentViewController:  animated:YES completion:NULL];
                                                                [self performSegueWithIdentifier:@"login" sender:self];
                                                             }];
                                                             // [END_EXCLUDE]
                                                           }];
                                              // [END create_user]
                                            }];}
    else{
        [self showMessagePrompt:@"Password Length should be greater than 6"];
    }
                                         // }];
                    // }];
   /* [[FIRAuth auth]
createUserWithEmail:_nameTextField.text
password:_passwordTextField.text
     completion: ^(FIRUser * user,
                   NSError * error){
   // user, error;
    
   if (error !=nil) {
       
       NSLog(@"error");
   }
       
   
    else{
        
        NSLog(@"created");
    }
    
}];*/
     }

- (IBAction)backgroundClicked:(id)sender {
    [self.nameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.emailField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}
@end
