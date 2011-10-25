//
//  TestResultsViewController.h
//  ApiTester
//
//  Created by lilli on 10/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ConfigurationData.h"

@interface TestResultsViewController : UIViewController <UITableViewDataSource, UITabBarDelegate>
{
    ConfigurationData *config;

    UITableView *resultsTable;
    UIView      *detailView;
    UITextView  *detailTextView;
    UIButton    *closeDetailButton;

    NSArray *resultsArray;
}
@property(nonatomic, retain) IBOutlet UITableView *resultsTable;
@property(nonatomic, retain) IBOutlet UIButton    *closeDetailButton;
@property(nonatomic, retain) IBOutlet UITextView  *detailTextView;
@property(nonatomic, retain) IBOutlet UIView      *detailView;

@end
