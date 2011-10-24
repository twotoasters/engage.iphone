//
//  Created by lillialexis on 10/21/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ConfigurationData.h"
#import "RootViewController.h"
#import "TestTypesViewController.h"

@interface DoubleTableViewController : UIViewController <RootViewControllerDelegate, TestTypesViewControllerDelegate>
{
    UIView *rightView;
    UIView *leftView;

    RootViewController      *rootViewController;
    TestTypesViewController *testTypesViewController;

    ConfigurationData *config;
}
@property (nonatomic, retain) IBOutlet RootViewController      *rootViewController;
@property (nonatomic, retain) IBOutlet TestTypesViewController *testTypesViewController;
@property (nonatomic, retain) IBOutlet UIView *rightView;
@property (nonatomic, retain) IBOutlet UIView *leftView;

@end
