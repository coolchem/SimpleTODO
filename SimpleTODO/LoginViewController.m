//
//  LoginViewController.m
//  SimpleTODO
//
//  Created by Sai anuja reddy Kadi Reddy on 6/20/16.
//  Copyright © 2016 Varun Reddy Nalagatla. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"

@interface LoginViewController ()
@property(nonatomic,strong) NSManagedObjectContext *managedobject;
@property(nonatomic,strong) NSFetchRequest *fetch;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)LoginClicked:(id)sender {
    
  // NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    _managedobject = [appdelegate managedObjectContext];
  // NSEntityDescription *entity = [NSEntityDescription entityForName:@"LoginDetails" inManagedObjectContext:_managedobject];
    //fetch = [NSFetchRequest fetchRequestWithEntityName:@"LoginDetails"];
    _fetch = [[NSFetchRequest alloc] initWithEntityName:@"LoginDetails"];

    
    NSError *error = nil;
    NSArray *result = [_managedobject executeFetchRequest:_fetch error:&error];
    
    
    if (error) {
        NSLog(@"Unable to execute fetch request.");
        NSLog(@"%@, %@", error, error.localizedDescription);
        
    } else {
        if (result == nil) {
            abort();
        }
        for( NSDictionary* obj in result ) {
            NSLog(@"PersonName: %@", [obj valueForKey:@"userName"]);
            NSLog(@"PersonPassword: %@", [obj valueForKey:@"password"]);
            if([obj valueForKey:@"userName"] == self.emailField.text && [obj valueForKey:@"password"] == self.passwordField.text)
            {
                NSLog(@"Match");
                [self performSegueWithIdentifier:@"login" sender:self];
            }
            else{
                self.passwordError.hidden = NO;

                self.passwordError.text = @"Password Not Matched";
            }
        }
       /* NSLog(@"fetch sucess");
      if (result.count > 0) {
            NSManagedObject *person = (NSManagedObject *)[result objectAtIndex:0];
            //NSLog(@"1 - %@", person);
          NSMutableArray *names = [person valueForKey:@"userName"];
          // NSLog(@"%@ %@", [person valueForKey:@"userName"], [person valueForKey:@"password"]);
          
          NSLog(@"inside if");
           // NSLog(@"2 - %@", person);
        }*/
    }
}

- (IBAction)signupClicked:(id)sender {
    [self performSegueWithIdentifier:@"signup" sender:self];
}
@end
