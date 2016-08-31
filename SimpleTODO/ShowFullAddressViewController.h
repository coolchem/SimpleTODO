//
//  ShowFullAddressViewController.h
//  SimpleTODO
//
//  Created by Sai anuja reddy Kadi Reddy on 8/29/16.
//  Copyright © 2016 Varun Reddy Nalagatla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocationManager.h>
#import <MapKit/MapKit.h>


@interface ShowFullAddressViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *addressTextView;
@property (weak, nonatomic) NSString *Latitude;
@property (weak, nonatomic) NSString *Longitude;
@end
