//
//  RootViewController.m
//  ApiTester
//
//  Created by lilli on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DLog(...)
#endif

#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#import "RootViewController.h"
#import "ConfigurationData.h"

@implementation RootViewController
@synthesize delegate;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    config = [ConfigurationData sharedConfigurationData];

    UILabel *titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 44)] autorelease];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
    titleLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"Sign-In or Sharing?";

    self.navigationItem.titleView = titleLabel;
    self.title = @"Start";

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        config.iPad = YES;


//    DLog(@"%f, %f, %f, %f", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);

//    if (config.iPad)
//    {
//        self.tableView.scrollEnabled = NO;
//    }
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView                         { return 1; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  { return 2; }
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section { return 70; }

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (config.iPad)
        return nil;

    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)] autorelease];
    view.backgroundColor = [UIColor whiteColor];//JANRAIN_BLUE_20;

    UIView *backgroundView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)] autorelease];
    backgroundView.backgroundColor = JANRAIN_BLUE_20;

    UILabel *headerLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 56)] autorelease];
    headerLabel.font = [UIFont boldSystemFontOfSize:14.0];
    headerLabel.textColor = [UIColor darkGrayColor];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.numberOfLines = 2;
    headerLabel.text = @"Welcome to the Janrain Engage for iOS Test Harness app.";

    UIImageView *headerDivider = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"divider.png"]] autorelease];
    headerDivider.frame = CGRectMake(0, 56, 320, 14);

    [view addSubview:backgroundView];
    [view addSubview:headerLabel];
    [view addSubview:headerDivider];

    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

	if (indexPath.row == 0)
        cell.textLabel.text = @"Test Sign-In";
    else
        cell.textLabel.text = @"Test Sharing";

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

	if (indexPath.row == 0)
        config.signInOrSharing = CDSignIn;
    else
        config.signInOrSharing = CDSharing;

    if (config.iPad)
    {
        if ([delegate respondsToSelector:@selector(rootViewController:tableView:didSelectRowAtIndexPath:)])
                [delegate rootViewController:self tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    else
    {
        TestTypesViewController *level1ViewController =
            [[TestTypesViewController alloc] initWithNibName:@"TestTypesViewController"
                                                      bundle:nil];

        [self.navigationController pushViewController:level1ViewController animated:YES];
        [level1ViewController release];
    }
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [delegate release];

    [super dealloc];
}
@end

