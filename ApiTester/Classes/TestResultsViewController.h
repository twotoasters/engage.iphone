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
    UIImageView *detailViewIcon;
    UILabel     *detailViewSummaryLabel;
    UITextView  *detailViewTextView;
    UIButton    *detailViewCloseButton;

    NSArray *resultsArray;
}
@property(nonatomic, retain) IBOutlet UITableView *resultsTable;
@property(nonatomic, retain) IBOutlet UIView      *detailView;
@property(nonatomic, retain) IBOutlet UIImageView *detailViewIcon;
@property(nonatomic, retain) IBOutlet UILabel     *detailViewSummaryLabel;
@property(nonatomic, retain) IBOutlet UITextView  *detailViewTextView;
@property(nonatomic, retain) IBOutlet UIButton    *detailViewCloseButton;
- (IBAction)closeButtonPressed:(id)sender;
@end
