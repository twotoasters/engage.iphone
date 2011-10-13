//
//  SharingActivityWithBadParamsViewController.h
//  ApiTester
//
//  Created by lilli on 10/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigurationData.h"
#import "StartTestViewController.h"

@interface SharingActivityWithBadParamsViewController : UIViewController <UITextFieldDelegate>
{
    ConfigurationData *config;

    UIScrollView *scrollView;
    UIView       *contentView;

    UIToolbar   *keyboardToolbar;
    UITextField *currentResponder;
}
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIView       *contentView;
@property (nonatomic, retain) IBOutlet UIToolbar    *keyboardToolbar;

- (IBAction)infoButtonPressed:(id)sender;
- (IBAction)doneButtonPressed:(id)sender;
- (IBAction)prevNextSegButtonPressed:(id)sender;
@end
