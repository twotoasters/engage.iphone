//
//  SharingActivityChangesViewController.h
//  ApiTester
//
//  Created by lilli on 9/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestConfigurationTableViewCell.h"
#import "JRActivityObject.h"
#import "ConfigurationData.h"
#import "StartTestViewController.h"

@interface SharingActivityChangesViewController : UIViewController <TestConfigurationTableViewCellDelegate,
                                                                    UIPickerViewDataSource, UIPickerViewDelegate,
                                                                    UITableViewDataSource, UITableViewDelegate>
{
    UIPickerView *picker;
    UITableView  *table;
    UIImageView  *thinDivider;
    UIImageView  *sliderDivider;
    UIButton     *sliderButton;

    NSMutableArray *activityArray;
    NSMutableArray *cellSwitchStates;

    NSArray *cellTitles;
    ConfigurationData *config;

    BOOL sliderUp;
}
@property (retain, nonatomic) IBOutlet UIPickerView *picker;
@property (retain, nonatomic) IBOutlet UITableView  *table;
@property (retain, nonatomic) IBOutlet UIImageView  *thinDivider;
@property (retain, nonatomic) IBOutlet UIImageView  *sliderDivider;
@property (retain, nonatomic) IBOutlet UIButton     *sliderButton;
- (IBAction)sliderButtonPressed:(id)sender;
@end
