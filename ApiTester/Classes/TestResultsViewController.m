//
//  TestResultsViewController.m
//  ApiTester
//
//  Created by lilli on 10/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TestResultsViewController.h"
#import "ConfigurationData.h"

@implementation TestResultsViewController
@synthesize resultsTable;
@synthesize closeDetailButton;
@synthesize detailTextView;
@synthesize detailView;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self)
//    {
//
//    }
//    return self;
//}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    config = [ConfigurationData sharedConfigurationData];

    resultsArray = [config resultsArray];

    self.navigationItem.rightBarButtonItem =
            [[[UIBarButtonItem alloc] initWithTitle:@"Refresh"
                                              style:UIBarButtonItemStyleBordered
                                             target:self
                                             action:@selector(refresh:)] autorelease];
}

- (void)refresh:(id)sender
{
    [resultsArray release];
    resultsArray = [config resultsArray];

    [resultsTable reloadData];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [resultsArray count];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 65;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if (cell == nil)
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"] autorelease];

    ResultObject *resultObject = [resultsArray objectAtIndex:indexPath.row];

    cell.textLabel.text       = resultObject.summary;
    cell.detailTextLabel.text = resultObject.timestamp;

    NSString *imageName;
    switch (resultObject.resultStat)
    {
        case RSUserCanceled:
        case RSDone:
        case RSInfo:
            imageName = @"blue_dot.png";
            break;
        case RSError:
        case RSErrorStarting:
        case RSPermanentAuthFailure:
        case RSPermanentShareFailure:
        case RSTokenUrlFailure:
        case RSBadParametersPermanentFailure:
            imageName = @"red_dot.png";
            break;
        case RSRecoverableAuthFailure:
        case RSRecoverableShareFailure:
        case RSBadParametersRecoverableFailure:
            imageName = @"orange_dot.png";
            break;
        case RSWarn:
            imageName = @"yellow_dot.png";
            break;
        case RSAuthSucceeded:
        case RSPublishSucceeded:
        case RSPublishCompleted:
        case RSTokenUrlSucceeded:
            imageName = @"green_dot.png";
            break;
        case RSNone:
        default:
            imageName = @"gray_dot.png";
            break;
    }

    cell.imageView.image = [UIImage imageNamed:imageName];
    cell.imageView.frame = CGRectMake(4, 4, 32, 32);

    return cell;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    [resultsTable release];
    [closeDetailButton release];
    [detailTextView release];
    [detailView release];
    [super dealloc];
}

@end
