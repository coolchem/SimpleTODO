//
//  ViewController.m
//  SimpleTODO
//
//  Created by Varun Reddy Nalagatla on 6/18/16.
//  Copyright © 2016 Varun Reddy Nalagatla. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
//#import <Firebase/Analytics/Firebase.h>
//@import FirebaseDatabase;
//@import FirebaseAuth;
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField            // called when 'return' key pressed. return NO to ignore.
{
    [self.todoText resignFirstResponder];
    self.tableViewView.hidden = NO;
    self.todoTableView.hidden = NO;
    self.todoButton.hidden = NO;
     Firebase *myRootRef = [[Firebase alloc] referenceFromURL:@"https://todoslogin-24559.firebaseio.com/"];
    // Write data to Firebaser
   // [myRootRef setValue:<#(nullable id)#> forKey:<#(nonnull NSString *)#>];
    return YES;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    //cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
    return cell;
}



- (IBAction)logOutClicked:(id)sender {
    
   // UIStoryboard *mystoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
   // LoginViewController *LoginViewController = [mystoryboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
   // [self presentViewController: LoginViewController animated:YES completion:NULL];
    [self performSegueWithIdentifier:@"logout" sender:self];
}
@end
