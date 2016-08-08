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
#import "ViewController.h"


@import FirebaseAuth;
@import LocalAuthentication;

@interface EmailViewController ()
{
    NSUserDefaults * nsDef;
    NSString *presentState;
}

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
    self.emailField.layer.cornerRadius = 8.0f;
    self.emailField.layer.masksToBounds = YES;
    self.emailField.layer.borderColor = [[UIColor cyanColor]CGColor];
    self.emailField.layer.borderWidth = 1.0f;
    
    self.passwordField.layer.cornerRadius = 8.0f;
    self.passwordField.layer.masksToBounds = YES;
    self.passwordField.layer.borderColor = [[UIColor cyanColor]CGColor];
    self.passwordField.layer.borderWidth = 1.0f;
    
    self.passwordTextField.layer.cornerRadius = 8.0f;
    self.passwordTextField.layer.masksToBounds = YES;
    self.passwordTextField.layer.borderColor = [[UIColor cyanColor]CGColor];
    self.passwordTextField.layer.borderWidth = 1.0f;
   
    self.nameTextField.layer.cornerRadius = 8.0f;
    self.nameTextField.layer.masksToBounds = YES;
    self.nameTextField.layer.borderColor = [[UIColor cyanColor]CGColor];
    self.nameTextField.layer.borderWidth = 1.0f;
    
    State = NO;
    /*nsDef = [NSUserDefaults standardUserDefaults];
    presentState = [nsDef stringForKey:@"myState"];
    NSLog(presentState);*/
    
   /* if([presentState isEqualToString:@"YES"])
    {
        //NSUserDefaults * nsDef = [NSUserDefaults standardUserDefaults];
        NSString *user = [nsDef stringForKey:@"myUser"];
        NSString *userPass = [nsDef stringForKey:@"myPass"];
        emailfield.text = user;
        passwordfield.text = userPass;
    }*/

    
}

- (void)viewWillAppear:(BOOL)animated {
    if([presentState isEqualToString:@"YES"])
    {
    //NSUserDefaults * nsDef = [NSUserDefaults standardUserDefaults];
    NSString *user = [nsDef stringForKey:@"myUser"];
    NSString *userPass = [nsDef stringForKey:@"myPass"];
    emailfield.text = user;
    passwordfield.text = userPass;
    }
    
}
- (void)viewWillDisappear:(BOOL)animated {
    
    if([presentState isEqualToString:@"YES"])
    {
    NSString * userName = emailfield.text;
    NSString * Password = passwordfield.text;
    [[NSUserDefaults standardUserDefaults] setObject: userName forKey:@"myUser"];
    [[NSUserDefaults standardUserDefaults] setObject: Password forKey:@"myPass"];
    }
}
-(BOOL)shouldAutorotate
{
    return NO;
}
-(NSUInteger)supportedInterfaceOriantations
{
    return UIInterfaceOrientationMaskPortrait;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField              // called when 'return' key pressed. return NO to ignore.
{
    //if(self.nameTextField.text != nil && self.passwordTextField.text != nil)
    //{
        //self.submitButton.enabled = YES;
   // }
    [self.nameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.emailField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
}

- (IBAction)didTapEmailLogin:(id)sender {
    
    //[self.mainview startCanvasAnimation];
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
                               [UIView beginAnimations:@"flipview" context:nil];
                               [UIView setAnimationDuration:2];
                               [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                               [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.mainview cache:YES];
                               //[self.view addSubview:self.mainview.view];
                               [self performSegueWithIdentifier:@"toMainview" sender:self];
                               [UIView commitAnimations];
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
    if(self.nameTextField.text.length != 0)
    {
        if(self.passwordTextField.text.length == 0)
        {
            [self showMessagePrompt:@"Password Field Empty"];

        }
    }
    else
    {
     [self showMessagePrompt:@"Username Field Empty"];
    }
    
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
                                                                [self performSegueWithIdentifier:@"toMainview" sender:self];
                                                             }];
                                                             // [END_EXCLUDE]
                                                           }];
                                              // [END create_user]
                                            }];}
    else{
        [self showMessagePrompt:@"Password Length should be greater than 6"];
    }

     }

- (IBAction)backgroundClicked:(id)sender {
    [self.nameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.emailField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

- (IBAction)backToLoginClicked:(id)sender {
    [self performSegueWithIdentifier:@"login" sender:self];
}
- (IBAction)checkedBoxClicked:(id)sender {
    
    if(!State)
    {
        [self.checkedBox setImage:[UIImage imageNamed:@"Checkbox_checked.png"] forState:UIControlStateNormal];
        State = YES;
        //presentState = @"YES";
        //NS* state = State;
        [[NSUserDefaults standardUserDefaults] setObject: @"Yes" forKey:@"myState"];
        
    }
    else
    {
        [self.checkedBox setImage:[UIImage imageNamed:@"Checkbox_not_checked.png"] forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] setObject: @"NO" forKey:@"myState"];
        State = NO;
    }
    
}
- (IBAction)touchedIDClicked:(id)sender {
    
    [self touchidcall];
}
-(void)touchidcall
{
    LAContext *authContext = [[LAContext alloc]init];
    NSError *error;
    if([authContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error])
    {
        [authContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"todo touch" reply:^(BOOL wasSucessful,NSError *error){
            
            if(wasSucessful)
            {
                [self performSegueWithIdentifier:@"toMainview" sender:self];
            }
            
            
        }];
    
    
    }
    
}

@end
