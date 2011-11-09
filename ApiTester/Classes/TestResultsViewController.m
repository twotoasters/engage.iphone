//
//  TestResultsViewController.m
//  ApiTester
//
//  Created by lilli on 10/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TestResultsViewController.h"

@implementation TestResultsViewController
@synthesize resultsTable;
@synthesize detailViewIcon;
@synthesize detailViewSummaryLabel;
@synthesize detailViewTextView;
@synthesize detailViewCloseButton;
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


    UIViewController *viewController = [[[UIViewController alloc] init] autorelease];
    viewController.view = detailView;

    detailViewController = [[UINavigationController alloc] initWithRootViewController:viewController];
    detailViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;

    viewController.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    viewController.navigationItem.rightBarButtonItem =
            [[[UIBarButtonItem alloc] initWithTitle:@"Close"
                                              style:UIBarButtonItemStyleBordered
                                             target:self
                                             action:@selector(closeButtonPressed:)] autorelease];


    detailViewSummaryLabel.font = [UIFont boldSystemFontOfSize:12.0];
    detailViewTextView.font = [UIFont systemFontOfSize:11.0];

//    detailViewController.view.backgroundColor = [UIColor clearColor];

//    [detailView setFrame:CGRectMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2, 0, 0)];
//    [self.view addSubview:detailView];

    self.title = @"Test Results";
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

- (NSString *)imageNameForResultStat:(ResultStat)resultStat
{
    switch (resultStat)
    {
        case RSUserCanceled:
        case RSDone:
        case RSInfo:
            return @"blue_dot.png";
        case RSError:
        case RSErrorStarting:
        case RSPermanentAuthFailure:
        case RSPermanentShareFailure:
        case RSTokenUrlFailure:
        case RSBadParametersPermanentFailure:
            return @"red_dot.png";
        case RSRecoverableAuthFailure:
        case RSRecoverableShareFailure:
        case RSBadParametersRecoverableFailure:
            return @"orange_dot.png";
        case RSWarn:
            return @"yellow_dot.png";
        case RSGood:
        case RSAuthSucceeded:
        case RSPublishSucceeded:
        case RSPublishCompleted:
        case RSTokenUrlSucceeded:
            return @"green_dot.png";
        case RSNone:
        default:
            return @"gray_dot.png";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if (cell == nil)
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"] autorelease];

    ResultObject *resultObject = [resultsArray objectAtIndex:indexPath.row];

    cell.textLabel.text       = resultObject.summary;
    cell.detailTextLabel.text = resultObject.timestamp;
    cell.imageView.image      = [UIImage imageNamed:[self imageNameForResultStat:resultObject.resultStat]];

    cell.textLabel.font       = [UIFont boldSystemFontOfSize:16.0];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0];


    return cell;
}

#pragma mark -
#pragma mark Detail view handling

- (void)populateDetailViewWithResult:(ResultObject *)resultObject
{
    detailViewSummaryLabel.text = resultObject.summary;
    detailViewTextView.text     = resultObject.detail;
    detailViewIcon.image        = [UIImage imageNamed:[self imageNameForResultStat:resultObject.resultStat]];
}

- (void)clearDetailView
{
    detailViewSummaryLabel.text = @"";
    detailViewTextView.text     = @"";
    detailViewIcon.image        = [UIImage imageNamed:@"gray_dot.png"];
}

- (void)openDetailView
{
    [self presentModalViewController:detailViewController animated:YES];

//    [UIView beginAnimations:@"close_detail_view" context:nil];
//    if (config.iPad)
//        [detailView setFrame:CGRectMake((self.view.frame.size.width / 2) - 200,
//                                        (self.view.frame.size.height / 2) - 250, 400, 500)];
//    else
//        [detailView setFrame:CGRectMake((self.view.frame.size.width / 2) - 150,
//                                        (self.view.frame.size.height / 2) - 200, 300, 400)];
//    [UIView commitAnimations];
}

- (void)closeDetailView
{
    [self dismissModalViewControllerAnimated:YES];


//    [UIView beginAnimations:@"close_detail_view" context:nil];
//    [detailView setFrame:CGRectMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2, 0, 0)];
//    [UIView commitAnimations];
}

- (IBAction)closeButtonPressed:(id)sender
{
    [self clearDetailView];
    [self closeDetailView];
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    if (indexPath.row >= [resultsArray count]) // Uh oh!
        return;

    [self populateDetailViewWithResult:[resultsArray objectAtIndex:indexPath.row]];
    [self openDetailView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (config.iPad)
        return YES;

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
    [detailViewIcon release];
    [detailViewSummaryLabel release];
    [detailViewTextView release];
    [detailViewCloseButton release];
    [detailView release];

    [detailViewController release];

    [super dealloc];
}

@end
