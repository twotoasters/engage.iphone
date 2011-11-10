//
//  StartTest.h
//  ApiTester
//
//  Created by lilli on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigurationData.h"
#import "JRPublishActivityController.h"
#import "TestResultsViewController.h"

@interface StartTestViewController : UIViewController <UIPopoverControllerDelegate, UITableViewDataSource,
                                                       UITableViewDelegate, ConfigurationDataDelegate>
{
    ConfigurationData *config;

    UIButton *startButton;

    UILabel            *navigationLabel;
    UILabel            *padDisplayLabel;
    UISegmentedControl *navigationRadio;
    UISegmentedControl *padDisplayRadio;

    JRRoundedRect      *padDisplayToast;
    UIButton           *padDisplayListener;
    UIImageView        *padDisplayTouchIndicator;
    UIBarButtonItem    *padDisplayBarButtonItem;

    UIPopoverController *arrowDirectionPopover;

    UILabel *titleLabel;

    CGPoint padDisplayLocation;
    UIPopoverArrowDirection arrowDirection;

    BOOL libraryDialogShowing;
}
@property (nonatomic, retain) IBOutlet UIButton           *startButton;
@property (nonatomic, retain) IBOutlet UILabel            *padDisplayLabel;
@property (nonatomic, retain) IBOutlet UILabel            *navigationLabel;
@property (nonatomic, retain) IBOutlet UISegmentedControl *navigationRadio;
@property (nonatomic, retain) IBOutlet UISegmentedControl *padDisplayRadio;
@property (nonatomic, retain) IBOutlet JRRoundedRect      *padDisplayToast;
- (IBAction)startButtonPressed:(id)sender;
- (IBAction)resultsButtonPressed:(id)sender;
//- (IBAction)navigationRadioChanged:(id)sender;
//- (IBAction)padDisplayRadioChanged:(id)sender;
@end
