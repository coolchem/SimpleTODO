//
//  MapViewController.h
//  SimpleTODO
//
//  Created by Sai anuja reddy Kadi Reddy on 8/27/16.
//  Copyright © 2016 Varun Reddy Nalagatla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocationManager.h>
#import <MapKit/MapKit.h>
#import <Firebase/Firebase.h>

@interface MapViewController : UIViewController
- (IBAction)DirectionButtonClicked:(id)sender;
- (IBAction)SaveLocationClicked:(id)sender;
- (IBAction)ShowActionClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButton;
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;

@end
