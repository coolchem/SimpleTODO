//
//  SignUPViewController.m
//  SimpleTODO
//
//  Created by Sai anuja reddy Kadi Reddy on 6/20/16.
//  Copyright © 2016 Varun Reddy Nalagatla. All rights reserved.
//

#import "SignUPViewController.h"
#import "AppDelegate.h"

@interface SignUPViewController ()
{
    //NSMutableArray * user = [[NSMutableArray alloc] NSManagedObject];
//NSMutableArray  * users= [[NSMutableArray alloc] NSManagedObject];
}
@end

@implementation SignUPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //user = [NSManagedObject array];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)textFieldShouldReturn:(UITextField *)textField              // called when 'return' key pressed. return NO to ignore.
{
    if(self.nameTextField.text != nil && self.passwordTextField.text != nil)
    {
        self.submitButton.enabled = YES;
    }
    [self.nameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    return YES;
}
- (IBAction)submitButtonClicked:(id)sender {
    //self.savedetails(self.nameTextField.text, self.passwordTextField.text)
    [self savedetails:self.nameTextField.text :self.passwordTextField.text];
    
}
- (void) savedetails:(NSString *) name :(NSString *) password
{
    AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * managedcontext = appdelegate.managedObjectContext;
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"LoginDetails" inManagedObjectContext:managedcontext];
    NSManagedObject *newPerson = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:managedcontext];
    [newPerson setValue:@"username" forKey:@"userName"];
    [newPerson setValue:@"password" forKey:@"password"];
    
    NSError *error = nil;
    
    if (![newPerson.managedObjectContext save:&error]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    
    
}
@end
