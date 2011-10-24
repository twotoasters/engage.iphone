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
#import "SignInProviderConfigViewController.h"
#import "SharingEmailSmsViewController.h"
#import "SharingCustomInterfaceViewController.h"
#import "SharingActivityChangesViewController.h"


@class TestTypesViewController;
@protocol TestTypesViewControllerDelegate <NSObject>
@optional
- (void)testTypesViewController:(TestTypesViewController*)testTypes tableView:(UITableView *)tableView didSelectViewController:(UIViewController*)viewController;
@end

@interface TestTypesViewController : UITableViewController
{
    NSArray *signInTestTypes;
    NSArray *sharingTestTypes;

    ConfigurationData *config;

    UILabel *titleLabel;
    id<TestTypesViewControllerDelegate> delegate;
}
@property (nonatomic, retain) id<TestTypesViewControllerDelegate> delegate;
@end
