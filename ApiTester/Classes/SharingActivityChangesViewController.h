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

@interface SharingActivityChangesViewController : UIViewController 
{
    UIPickerView *picker;
    UITableView  *table;
    
    NSMutableArray *activityArray;
    NSInteger selectedActivity;
    
    NSArray *cellTitles;
    ConfigurationData *config;
}
@property (retain, nonatomic) IBOutlet UIPickerView *picker;
@property (retain, nonatomic) IBOutlet UITableView  *table;
@end
