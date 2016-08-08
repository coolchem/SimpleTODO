 //
//  ViewController.m
//  SimpleTODO
//
//  Created by Varun Reddy Nalagatla on 6/18/16.
//  Copyright © 2016 Varun Reddy Nalagatla. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "UIViewController+Alerts.h"
#import "DetailsViewController.h"
#import "SWRevealViewController.h"

@interface ViewController ()
{
    FIRDatabaseReference *userRef,*Ref;
    UITableViewCell *cell;
    NSDictionary *todo,*dictvalue;
    NSString *i,*dictkey1,*dictkey,*databaseData,*editkey;
    NSString *status;
}
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation ViewController

- (void)viewDidLoad {
    // Do any additional setup after loading the view, typically from a nib.
    
        [self.barButton setTarget: self.revealViewController];
        [self.barButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    [super viewDidLoad];
    //setting textfield boder
    self.todoText.layer.cornerRadius = 8.0f;
    self.todoText.layer.masksToBounds = YES;
    self.todoText.layer.borderColor = [[UIColor cyanColor]CGColor];
    self.todoText.layer.borderWidth = 1.0f;
    
    //TO initially load the values from firebase
    userRef = [[FIRDatabase database] referenceFromURL:@"https://todoslogin-24559.firebaseio.com/"];
    NSString *uid = [FIRAuth auth].currentUser.uid;
    
    userRef = [userRef child:uid];
    userRef = [userRef child:@"todos"];
    //self.todoList.text = i;
    [self loadDataFromFirebase];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate
{
    return NO;
}
-(NSUInteger)supportedInterfaceOriantations
{
    return UIInterfaceOrientationMaskPortrait;
}
-(void)loadDataFromFirebase
{

    [userRef observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot) {
        self.data=[[NSMutableArray alloc] init];
       
for (FIRDataSnapshot* child in snapshot.children)
{
       dictkey = child.key;
    
    //NSLog(@"key:%@", dictkey);
       dictvalue = snapshot.value;
    //NSLog(@"total:%@",dictvalue);
    //NSLog(@"values:%@", [dictvalue valueForKey:dictkey]);
    [self.data addObject:[dictvalue valueForKey:dictkey]];
    [self.todoTableView reloadData];
}
       
        //NSString * addvalue = snapshot.value;
       // NSLog(@"updated:%@", addvalue);
    
      
        
    }];
        

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField            // called when 'return' key pressed. return NO to ignore.
{
    [self.todoText resignFirstResponder];
    return YES;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return [self.data count];
}


// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
  // NSLog(@"in table view");
    
    
    cell.textLabel.text =[self.data objectAtIndex: indexPath.row];
    
    
    //[self performSegueWithIdentifier:@"fullTodo" sender:self];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *deletekey;
   i = [self.data objectAtIndex:indexPath.row];
    deletekey = [[NSArray alloc] initWithObjects:[dictvalue allKeysForObject:i], nil];
    //NSLog(@"deletekey%@",deletekey);
    editkey= [[deletekey objectAtIndex: 0]componentsJoinedByString:@""];
    NSString *str = [NSString stringWithFormat: @"%@%@%@", userRef, @"/", editkey];
    Ref = [[FIRDatabase database] referenceFromURL:str];

    
  //  i = [i appendString:[NSString stringWithFormat:"%@", [self.data objectAtIndex:indexPath.row]]];
    status = @"edit";
    [self performSegueWithIdentifier:@"fullTodo" sender:self];
    
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;

}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
       
       NSUInteger index = indexPath.row;
       NSString * deleteValue = [self.data objectAtIndex: indexPath.row];
      // NSLog(@"deletevalue:%@",deleteValue);
       NSArray *deletekey;
       //Remove data from the array
       [_data removeObjectAtIndex:index];
        //Remove data from tableview
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
        
        //Remove the record from Firebase.
        deletekey = [[NSArray alloc] initWithObjects:[dictvalue allKeysForObject:deleteValue], nil];
        //NSLog(@"deletekey%@",deletekey);
        NSString * arrayvalue = [[deletekey objectAtIndex: 0]componentsJoinedByString:@""];
        NSString *str = [NSString stringWithFormat: @"%@%@%@", userRef, @"/", arrayvalue];
        FIRDatabaseReference *userRef1 = [[FIRDatabase database] referenceFromURL:str];
        [userRef1 removeValue];
     
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[DetailsViewController class]])
    {
       
        DetailsViewController *controller = segue.destinationViewController;
       // NSLog(@"the string:%@",i);
        controller.detailText = i;
        controller.status = status;
        if([status isEqualToString:@"edit"])
        {
            controller.ref = Ref;
            controller.editkey = editkey;
        }
    }
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (IBAction)addButtonClicked:(id)sender {
 
    status = @"add";
    [self performSegueWithIdentifier:@"fullTodo" sender:self];
}

/*- (IBAction)LogoutClicked:(id)sender {
    
    [self performSegueWithIdentifier:@"logout" sender:self];
}*/
@end
