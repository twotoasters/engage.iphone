//
//  SignInProviderConfigViewController.h
//  ApiTester
//
//  Created by lilli on 9/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestConfigurationTableViewCell.h"
#import "ConfigurationData.h"
#import "StartTestViewController.h"
#import "JRSessionData.h"

@interface SignInProviderConfigViewController : UITableViewController <TestConfigurationTableViewCellDelegate>
{
    ConfigurationData *config;

    NSArray *cellTitles;
    UIView  *excludeProvidersView;
    NSArray *configuredProviders;

    NSMutableArray *excludedProviders;
    NSMutableArray *cellSwitchStates;
    NSMutableArray *excludedProvidersSwitchStates;
}

@end
