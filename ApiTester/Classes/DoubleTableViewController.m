//
//  Created by lillialexis on 10/21/11.
//
// To change the template use AppCode | Preferences | File Templates.
//

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DLog(...)
#endif

#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)


#import <UIKit/UIKit.h>
#import "DoubleTableViewController.h"
#import "RootViewController.h"
#import "TestTypesViewController.h"

@implementation DoubleTableViewController
@synthesize rootViewController;
@synthesize testTypesViewController;
@synthesize rightView;
@synthesize leftView;


- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
    }

    return self;
}

- (void)viewDidLoad
{
    DLog(@"");

    [super viewDidLoad];
    config = [ConfigurationData sharedConfigurationData];

//    rootViewController      = [[RootViewController alloc]
//                                    initWithNibName:@"RootViewController" bundle:nil];
//    testTypesViewController = [[TestTypesViewController alloc]
//                                    initWithNibName:@"TestTypesViewController" bundle:nil];

    rootViewController.delegate = self;
    testTypesViewController.delegate = self;

    [leftView  addSubview:rootViewController.view];
    [rightView addSubview:testTypesViewController.view];
}

- (void)testTypesViewController:(TestTypesViewController*)testTypes tableView:(UITableView *)tableView didSelectViewController:(UIViewController*)viewController
{
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)rootViewController:(RootViewController*)viewController tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [testTypesViewController.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"YO!!!");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)dealloc
{
    [rootViewController release];
    [testTypesViewController release];
    [rightView release];
    [leftView release];

    [super dealloc];
}
@end
