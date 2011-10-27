//
//  SharingEmailSmsViewController.h
//  ApiTester
//
//  Created by lilli on 9/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigurationData.h"
#import "StartTestViewController.h"
#import "TestConfigurationTableViewCell.h"

@interface SharingEmailSmsViewController : UITableViewController <TestConfigurationTableViewCellDelegate>
{

    NSArray *cellTitles;
    ConfigurationData *config;

    UIView  *emailCustomizationsView;
    UIView  *smsCustomizationsView;

    NSArray *allEmailChoices;
    NSArray *allSmsChoices;

    NSMutableArray *selectedEmailChoices;
    NSMutableArray *selectedSmsChoices;

    NSMutableArray *cellSwitchStates;
}

@end
