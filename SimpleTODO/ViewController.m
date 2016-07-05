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
{
    FIRDatabaseReference *userRef;
    NSString *databaseData;
    UITableViewCell *cell;
    NSEnumerator *denu;
    int i;
    
}
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation ViewController
/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //link the CloudViewController with its View
    NSBundle *appBundle = [NSBundle mainBundle];
    
    self = [super initWithNibName:@"ViewController" bundle:appBundle];
    if (self) {
        self.todoTableView.delegate = self;
        self.todoTableView.dataSource = self;
        [self loadDataFromFirebase];
        [self.todoTableView reloadData];
    }
    return self;
}*/

- (void)viewDidLoad {
    [super viewDidLoad];
    i = 0;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadDataFromFirebase
{
    
    [userRef observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *snapshot) {
        //cell.textLabel.text = databaseData;
        
        //NSLog(@"updated:%@", snapshot.value);
        
        

        //if(i > 0)
       // {
        NSString * addvalue = snapshot.value;
        NSLog(@"updated:%@", addvalue);
        [self.data addObject:addvalue ];
        NSLog(@"arrayvalue:%@", self.data);
        //denu = self.data.reverseObjectEnumerator;
        [self.todoTableView reloadData];
            //i=0;
            
       // }
                  // i = i+1;
       
        
        
    }];
        

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField            // called when 'return' key pressed. return NO to ignore.
{
    [self.todoText resignFirstResponder];
    self.tableViewView.hidden = NO;
    self.todoTableView.hidden = NO;
    self.todoButton.hidden = NO;

    
    //Firebase *myRootRef = [[Firebase alloc] referenceFromURL:@"https://todoslogin-24559.firebaseio.com/"];
    userRef = [[FIRDatabase database] referenceFromURL:@"https://todoslogin-24559.firebaseio.com/"];
    NSString *uid = [FIRAuth auth].currentUser.uid;

    userRef = [userRef child:uid];
    NSString *key = [userRef childByAutoId].key;
    NSDictionary *todo = @{
                           key:self.todoText.text,
                               };
    
    [userRef updateChildValues: todo];
    self.data=[[NSMutableArray alloc] init];
        [self loadDataFromFirebase];
    
    
    //
        //cell.textLabel.text =[data objectAtIndex:indexPath.row];
    

   
 // [[userRef childByAutoId] setValue:@{@"todo": @"lol", @"hum": @"kek"}}];
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
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    //cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
    //[userRef observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot) {
       // NSLog(@"updated:%@", snapshot.value);
       // cell.textLabel.text = databaseData;
    //unsigned int i, count=[];
   // NSLog(@"count;%lu",(unsigned long)[self.data count]);
   //for(NSUInteger i= [self.data count]-1; i>0; i--)
  // {
       // NSLog(@"i value:%lu",(unsigned long)i);
    //NSInteger index = indexPath.row - 1;
   NSLog(@"in table view");
    
    //NSUInteger *num = indexPath.row;
    //NSUInteger *
    cell.textLabel.text =[self.data objectAtIndex: indexPath.row];
    //}];
   //

    return cell;
}



- (IBAction)logOutClicked:(id)sender {
    
   // UIStoryboard *mystoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
   // LoginViewController *LoginViewController = [mystoryboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
   // [self presentViewController: LoginViewController animated:YES completion:NULL];
    [self performSegueWithIdentifier:@"logout" sender:self];
}
@end
