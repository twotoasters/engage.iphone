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
    NSArray           *cellTitles;
    ConfigurationData *config;

    NSArray        *configuredProviders;
    NSString       *directProvider;
    NSMutableArray *excludedProviders;

    UIView *directProvidersView;
    UIView *excludeProvidersView;


    NSMutableArray *cellSwitchStates;
    NSMutableArray *directProvidersSwitchStates;
    NSMutableArray *excludedProvidersSwitchStates;
}

@end
