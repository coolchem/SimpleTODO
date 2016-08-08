//
//  DetailsViewController.m
//  SimpleTODO
//
//  Created by Sai anuja reddy Kadi Reddy on 7/22/16.
//  Copyright © 2016 Varun Reddy Nalagatla. All rights reserved.
//

#import "DetailsViewController.h"
#import "ViewController.h"

@interface DetailsViewController ()
{
    FIRDatabaseReference *userRef;
    NSDictionary *todo;
}
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.TodoList.text = self.detailText;
    userRef = [[FIRDatabase database] referenceFromURL:@"https://todoslogin-24559.firebaseio.com/"];
    NSString *uid = [FIRAuth auth].currentUser.uid;

    userRef = [userRef child:uid];
    userRef = [userRef child:@"todos"];

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

- (IBAction)todoBackClicked:(id)sender {
    
    
    if([self.TodoList.text isEqualToString:@""])
    {
        //[self showMessagePrompt:@"Enter some todo"];
    }
    else{
        //self.todoTableView.hidden = NO;
        if([self.status isEqualToString:@"add"])
        {
            NSString *key = [userRef childByAutoId].key;
            
            todo = @{
                     key:self.TodoList.text
                     };
            
            [userRef updateChildValues: todo];
            
        }
        else
        {
            todo = @{
                     self.editkey:self.TodoList.text
                     };
            
            [userRef updateChildValues: todo];
            // NSLog(@"the todo text%@", self.TodoList.text);
        }
        
        //[self loadDataFromFirebase];
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
   // [self performSegueWithIdentifier:@"todoList" sender:self];
}

- (IBAction)shareClicked:(id)sender {
   NSArray *itemsTOShare = @[self.TodoList.text];
    UIActivityViewController *activityAc = [[UIActivityViewController alloc]initWithActivityItems:itemsTOShare applicationActivities:nil ];
   // activityAc.excludedActivityTypes = @[];
    [self presentViewController:activityAc animated:YES completion:nil];
}
@end
