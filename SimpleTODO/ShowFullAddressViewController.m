//
//  ShowFullAddressViewController.m
//  SimpleTODO
//
//  Created by Sai anuja reddy Kadi Reddy on 8/29/16.
//  Copyright © 2016 Varun Reddy Nalagatla. All rights reserved.
//

#import "ShowFullAddressViewController.h"

@interface ShowFullAddressViewController ()
{
    NSString *address;
    double CLLocationDegrees;
    CLPlacemark *placemark;
    float lat,lon;
    CLLocation *location;
   // CLLocationCoordinate2D location;
   // CLLocation *Location;
}

@property (nonatomic, strong) CLGeocoder *myGeocoder;

@end

@implementation ShowFullAddressViewController

- (void)viewDidLoad {
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    NSLog(@"Lat:%@", self.Latitude);
    
    
    
  //  Location.coordinate.latitude = [self.Latitude floatValue];
   // Location.coordinate.longitude = [self.Longitude floatValue];
    lat = (CLLocationDegrees)[self.Latitude floatValue];
    lon = (CLLocationDegrees)[self.Longitude floatValue];
    location = [[CLLocation alloc] initWithLatitude: lat longitude:lon];
    //CLLocation *location = [[CLLocation alloc] initWithLatitude:  longitude:  lon];
    //LocationAtual.coordinate.latitude = [self.Latitude floatValue];
   // LocationAtual.coordinate.longitude = [self.Longitude floatValue];
   /* [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if(placemarks && placemarks.count > 0)
         {
             CLPlacemark *placemark= [placemarks objectAtIndex:0];
             
             //address is NSString variable that declare in .h file.
             address = [NSString stringWithFormat:@"%@ , %@ , %@",[placemark thoroughfare],[placemark locality],[placemark administrativeArea]];
            // NSLog(@"New Address Is:%@",address);
         }
     }];*/
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            address = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                 placemark.subThoroughfare, placemark.thoroughfare,
                                 placemark.postalCode, placemark.locality,
                                 placemark.administrativeArea,
                                 placemark.country];
            _addressTextView.text = address;

        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
    
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

- (IBAction)getDirectionsClicked:(id)sender {
    
    NSString *urlstring = [NSString stringWithFormat: @"%@%@%@%@", @"http://maps.apple.com/maps?daddr=",self.Latitude,@",",self.Longitude];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlstring]];

}
@end
