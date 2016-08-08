//
//  Copyright (c) 2016 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import<Canvas.h>

@interface EmailViewController : UIViewController
{
    BOOL State;
    __weak IBOutlet UITextField *emailfield;
    __weak IBOutlet UITextField *passwordfield;
}
- (IBAction)backgroundClicked:(id)sender;
- (IBAction)backToLoginClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *checkedBox;
- (IBAction)checkedBoxClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIControl *mainview;

- (IBAction)touchedIDClicked:(id)sender;

@end
