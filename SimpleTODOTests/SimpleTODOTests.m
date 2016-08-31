//
//  SimpleTODOTests.m
//  SimpleTODOTests
//
//  Created by Varun Reddy Nalagatla on 6/18/16.
//  Copyright © 2016 Varun Reddy Nalagatla. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EmailViewController.h"
#import "ShowAddressViewController.h"
#import "ShowFullAddressViewController.h"

@interface SimpleTODOTests : XCTestCase
@property (nonatomic)ShowFullAddressViewController *vcToTest;
@end

@implementation SimpleTODOTests

- (void)setUp {
    [super setUp];
    self.vcToTest = [[ShowFullAddressViewController alloc] init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testaddress{
    
   /* NSString *originalLatitude = @"himynameisandy";
    NSString *reversedString = [self.vcToTest viewDidLoad:originalLatitude];
    NSString *expectedReversedString = @"ydnasiemanymih";
    XCTAssertEqualObjects(expectedReversedString, reversedString, @"The reversed string did not match the expected reverse”;
                          }*/
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ShowFullAddressViewController *vc = [storyboard instantiateViewControllerWithIdentifier: @"ShowFullAddressViewController"];
    //[vc viewDidLoad];
    vc.view.hidden = NO;
    /*NSString *originalLatitude = @"himynameisandy";
    NSString *reversedString = [vc.Latitude:originalLatitude];
    NSString *expectedReversedString = @"ydnasiemanymih";
    XCTAssertEqualObjects(expectedReversedString, reversedString, @"The reversed string did not match the expected reverse”);*/
    
    XCTAssertNotNil(vc, @"MyViewController should not be nil");

    
}




@end
