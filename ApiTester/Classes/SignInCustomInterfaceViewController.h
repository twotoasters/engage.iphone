//
//  SignInCustomInterfaceViewController.h
//  ApiTester
//
//  Created by lilli on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestConfigurationTableViewCell.h"
#import "ConfigurationData.h"
#import "StartTestViewController.h"

@interface SignInCustomInterfaceViewController : UITableViewController 
{
    NSArray *cellTitles;
    ConfigurationData *config;
}

@end
