//
//  SharingCustomInterfaceViewController.h
//  ApiTester
//
//  Created by lilli on 9/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigurationData.h"
#import "TestConfigurationTableViewCell.h"


@interface SharingCustomInterfaceViewController : UITableViewController <TestConfigurationTableViewCellDelegate>
{
    NSArray           *cellTitles;
    ConfigurationData *config;

    NSMutableArray    *cellSwitchStates;
}

@end
