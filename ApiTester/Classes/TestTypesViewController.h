//
//  TestOptionsLevel1.h
//  ApiTester
//
//  Created by lilli on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigurationData.h"
#import "StartTestViewController.h"
#import "SignInCustomInterfaceViewController.h"

@interface TestTypesViewController : UITableViewController 
{
    NSArray *signInTestTypes;
    NSArray *sharingTestTypes;

    ConfigurationData *config;
    
    UILabel *titleLabel;
}

@end
