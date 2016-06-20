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
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * managedcontext = appdelegate.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"LoginDetails" inManagedObjectContext:managedcontext];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *result = [managedcontext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"Unable to execute fetch request.");
        NSLog(@"%@, %@", error, error.localizedDescription);
        
    } else {
        //NSLog(@"%@", result);
        if (result.count > 0) {
            NSManagedObject *person = (NSManagedObject *)[result objectAtIndex:0];
            NSLog(@"1 - %@", person);
            NSLog(@"%@ %@", [person valueForKey:@"userName"], [person valueForKey:@"password"]);
            NSLog(@"2 - %@", person);
        }
    }
}
@end
