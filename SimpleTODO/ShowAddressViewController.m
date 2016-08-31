//
//  ShowAddressViewController.m
//  SimpleTODO
//
//  Created by Sai anuja reddy Kadi Reddy on 8/29/16.
//  Copyright © 2016 Varun Reddy Nalagatla. All rights reserved.
//

#import "ShowAddressViewController.h"
#import "ShowFullAddressViewController.h"

@interface ShowAddressViewController ()<UIAdaptivePresentationControllerDelegate,UIPopoverPresentationControllerDelegate>{
    
    FIRDatabaseReference *userRef,*Ref;
    UITableViewCell *cell;
    NSDictionary *todo,*dictvalue;
    NSString *i,*dictkey1,*dictkey,*databaseData,*editkey,*Latitude,*longitude, *strL, *strLo;
    
}
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation ShowAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    userRef = [[FIRDatabase database] referenceFromURL:@"https://todoslogin-24559.firebaseio.com/"];
    NSString *uid = [FIRAuth auth].currentUser.uid;
    
    userRef = [userRef child:uid];
    userRef = [userRef child:@"Address"];
    //self.todoList.text = i;
    [self loadDataFromFirebase];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadDataFromFirebase
{
    
    [userRef observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot) {
        self.data=[[NSMutableArray alloc] init];
        
        for (FIRDataSnapshot* child in snapshot.children)
        {
            dictkey = child.key;
            dictvalue = snapshot.value;
            [self.data addObject: dictkey];
            [self.MyTableView reloadData];
        }
    }];
    
    
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
    
    // NSLog(@"in table view");
    
    
    cell.textLabel.text =[self.data objectAtIndex: indexPath.row];
    
    
    //[self performSegueWithIdentifier:@"fullTodo" sender:self];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   // NSIndexPath *indexPath = [self.MyTableView indexPathForCell:sender];
    /*NSIndexPath* indexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
     UITableViewCell *cell = [self.MyTableView cellForRowAtIndexPath:indexPath];
     NSIndexPath *indexPath = [self.MyTableView indexPathForSelectedRow];*/
    
    NSArray *location;
    
    i = [self.data objectAtIndex:indexPath.row];
    location = [[NSArray alloc] initWithObjects:[dictvalue valueForKey:i],nil];
    Latitude = [[location valueForKey:@"Latitude"]componentsJoinedByString:@""];
    longitude = [[location valueForKey:@"Longitude"] componentsJoinedByString:@""];
    [self performSegueWithIdentifier:@"showpopover" sender:self];
    

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
        NSArray *deletekey;
        //Remove data from the array
        [_data removeObjectAtIndex:index];
        //Remove data from tableview
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
        
        //Remove the record from Firebase.
        deletekey = [[NSArray alloc] initWithObjects:[dictvalue allKeysForObject:deleteValue], nil];
        NSString * arrayvalue = [[deletekey objectAtIndex: 0]componentsJoinedByString:@""];
        NSString *str = [NSString stringWithFormat: @"%@%@%@", userRef, @"/", arrayvalue];
        FIRDatabaseReference *userRef1 = [[FIRDatabase database] referenceFromURL:str];
        [userRef1 removeValue];
        
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)discloserButtonClicked:(id)sender {
    
    [self performSegueWithIdentifier:@"showpopover" sender:self];
    
}

- (IBAction)showDirectionsClicked:(id)sender {
   // NSIndexPath *indexPath = [self.MyTableView indexPathForCell:sender];
    NSIndexPath *indexPath = [self.MyTableView indexPathForSelectedRow];
    
    NSArray *location;
    
    i = [self.data objectAtIndex:indexPath.row];
    location = [[NSArray alloc] initWithObjects:[dictvalue valueForKey:i],nil];
    Latitude = [[location valueForKey:@"Latitude"]componentsJoinedByString:@""];
    longitude = [[location valueForKey:@"Longitude"] componentsJoinedByString:@""];
    
        
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier  isEqual: @"showpopover"])
    {
        
        ShowFullAddressViewController *controller = segue.destinationViewController;
        self.modalPresentationStyle = UIModalPresentationPopover;
        controller.popoverPresentationController.delegate = self;
        controller.Latitude = Latitude;
        controller.Longitude = longitude;
        
       
    }
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}


@end
