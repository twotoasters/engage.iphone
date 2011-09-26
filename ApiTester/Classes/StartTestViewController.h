//
//  StartTest.h
//  ApiTester
//
//  Created by lilli on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigurationData.h"

@interface StartTestViewController : UIViewController 
{
    ConfigurationData *config;
    
    UIButton *startButton;
    UISegmentedControl *navigationRadio;
    UISegmentedControl *padDisplayRadio;
    
    UILabel *titleLabel;
}
@property (nonatomic, retain) IBOutlet UIButton *startButton;
@property (nonatomic, retain) IBOutlet UISegmentedControl *navigationRadio;
@property (nonatomic, retain) IBOutlet UISegmentedControl *padDisplayRadio;

- (IBAction)startButtonPressed:(id)sender;
//- (IBAction)navigationRadioChanged:(id)sender;
//- (IBAction)padDisplayRadioChanged:(id)sender;
@end
