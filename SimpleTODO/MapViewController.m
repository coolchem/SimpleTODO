//
//  MapViewController.m
//  SimpleTODO
//
//  Created by Sai anuja reddy Kasi Reddy on 8/27/16.
//  Copyright © 2016 Varun Reddy Nalagatla. All rights reserved.
//

#import "MapViewController.h"
#import "SWRevealViewController.h"
#import "UIViewController+Alerts.h"



@interface MapViewController () <MKMapViewDelegate, CLLocationManagerDelegate, UIAlertViewDelegate>{
    CLLocationManager *locationManager;
    MKUserLocation  *currentLocation;
    FIRDatabaseReference *userRef,*Ref;
    NSDictionary *todo,*dictvalue;
    NSString *i,*dictkey1,*dictkey,*databaseData,*editkey, *key;
    //NSMutableArray *data;
    
   // NSDictionary *todo,*dictvalue;
}
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [self.barButton setTarget: self.revealViewController];
    [self.barButton setAction: @selector( revealToggle: )];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [super viewDidLoad];
    locationManager = [CLLocationManager new];
    if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager stopUpdatingLocation];
    [locationManager.delegate self];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
    // locationManager = [CLLocationManager new];
    if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [locationManager requestWhenInUseAuthorization];
    }
    
    _myMapView.showsUserLocation = YES;
    [locationManager stopUpdatingLocation];
    
    //DataBase Connections.
    
    userRef = [[FIRDatabase database] referenceFromURL:@"https://todoslogin-24559.firebaseio.com/"];
    NSString *uid = [FIRAuth auth].currentUser.uid;
    
    userRef = [userRef child:uid];
    userRef = [userRef child:@"Address"];
    //self.todoList.text = i;
   // [self loadDataFromFirebase];

    
   
    
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation NS_AVAILABLE(10_9, 4_0)
{
    MKMapCamera *camera = [MKMapCamera cameraLookingAtCenterCoordinate:userLocation.coordinate fromEyeCoordinate:CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude) eyeAltitude:100000];
    //NSLog(@"latitude%f",userLocation.coordinate.latitude);
    [mapView setCamera:camera animated:YES];
    currentLocation = userLocation;
    
    NSLog(@"latitude%@", userLocation);
    
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
 NSString *urlstring = @"http://maps.apple.com/maps?daddr=-33.852261,151.210615";
 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlstring]];
*/

- (IBAction)DirectionButtonClicked:(id)sender {
    
       /*NSString *urlstring = [NSString stringWithFormat: @"%@%f%@%f", @"http://maps.apple.com/maps?daddr=",-33.852261,@",",151.210615];*/
    NSString *urlstring = @"http://maps.apple.com/maps";
    NSLog(@"url:%@", urlstring);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlstring]];
}

- (IBAction)SaveLocationClicked:(id)sender {
    
   /* [self
     showTextInputPromptWithMessage:@"Enter Title:"
     completionBlock:^(BOOL userPressedOK, NSString *_Nullable userInput) {
         if (!userPressedOK || !userInput.length) {
             return;
         }

           key = userInput;
     }];*/
    
   // if ([self supportsAlertController]) {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Title" message:@"Enter Title" preferredStyle:UIAlertControllerStyleAlert];
    //[alert.delegate.self ];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"Title";
    }];
    NSString *lat = [NSString stringWithFormat: @"%f",currentLocation.coordinate.latitude];
    NSString *lon = [NSString stringWithFormat: @"%f",currentLocation.coordinate.longitude];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {
                                                         UITextField *textFiel = [alert.textFields firstObject];
                                                         key = textFiel.text;
                                                          //userRef = [userRef child:key];
                                                         /*todo = @{
                                                                  @"Latitude": stringL
                                                                  @"Longitude": stringLo
                                                                  };*/
                                                         todo = @{key : @{
                                                                      @"Latitude": lat,
                                                                      @"Longitude": lon
                                                                      }};
                                                         
                                                         [userRef updateChildValues: todo];
                                                         
                                                         [self showMessagePrompt:@"Location Saved"];
                                                         //[fruits addObject:textFiel.text];
                                                     }];
    [alert addAction:okAction];
    //[alert show];
    
   [self presentViewController:alert animated:YES completion:nil];
    
    

    
}

- (IBAction)ShowActionClicked:(id)sender {
    [self performSegueWithIdentifier:@"detailedList" sender:self];
}
@end
