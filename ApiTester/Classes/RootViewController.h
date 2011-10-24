//
//  RootViewController.h
//  ApiTester
//
//  Created by lilli on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigurationData.h"
#import "TestTypesViewController.h"

@class RootViewController;
@protocol RootViewControllerDelegate <NSObject>
@optional
- (void)rootViewController:(RootViewController*)viewController tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface RootViewController : UITableViewController
{
    ConfigurationData *config;

    id<RootViewControllerDelegate> delegate;
}
@property (retain, nonatomic) id<RootViewControllerDelegate> delegate;
@end
