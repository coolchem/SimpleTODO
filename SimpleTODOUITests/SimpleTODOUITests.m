//
//  SimpleTODOUITests.m
//  SimpleTODOUITests
//
//  Created by Varun Reddy Nalagatla on 6/18/16.
//  Copyright © 2016 Varun Reddy Nalagatla. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EmailViewController.h"

@interface SimpleTODOUITests : XCTestCase

@end

@implementation SimpleTODOUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLogin {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.textFields[@"Username"] tap];
   [app.textFields[@"Username"]typeText:@"anu.ruchi92@gmail.com"];
   // [app.textFields set:@"anu.ruchi92@gmail.com"];
    
    XCUIElement *passwordSecureTextField = app.secureTextFields[@"Password"];
    [passwordSecureTextField tap];
    //[passwordSecureTextField tap];
    [app.secureTextFields[@"Password"]typeText:@"anuja12345"];
    //app.secureTextFields[@"Password"]
    [app.buttons[@"Return"] tap];
    //[app typeText:@"\n"];
    [app.buttons[@"LOGIN"] tap];
    [app.buttons[@"LogOut"] tap];
    
    
    
}

@end
