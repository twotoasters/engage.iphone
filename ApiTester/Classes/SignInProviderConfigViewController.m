//
//  SignInProviderConfigViewController.m
//  ApiTester
//
//  Created by lilli on 9/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignInProviderConfigViewController.h"


@implementation SignInProviderConfigViewController


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];

    config = [ConfigurationData sharedConfigurationData];

    cellTitles = [[NSArray alloc] initWithObjects:
                    @"Add Native Login", @"Add custom login above the list of providers", @"sl",
                    @"Always Force Reauthentication", @"Force the user to always reenter his login credentials", @"sl",
//                    @"Skip The User Landing Page", @"Always open to the list of providers first",  @"sl",
                    @"Exclude Providers", @"Select providers below that you wish to exclude", @"sl" ,nil];

    [self.tableView setSeparatorColor:[UIColor darkGrayColor]];
    [self.tableView setAllowsSelection:NO];

    configuredProviders = [[NSArray alloc] initWithArray:[[JRSessionData jrSessionData] basicProviders]];
    excludeProvidersView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, [configuredProviders count] * 35)];

    for (NSInteger i = 0; i < [configuredProviders count]; i++)
    {
        UILabel *providerLabel = [[[UILabel alloc] initWithFrame:CGRectMake(25, (i * 35), 125, 35)] autorelease];

        providerLabel.backgroundColor = [UIColor clearColor];
        providerLabel.font = [UIFont systemFontOfSize:15.0];
        providerLabel.text = [configuredProviders objectAtIndex:i];
        providerLabel.tag  = 200 + i;

        UISwitch *providerSwitch = [[[UISwitch alloc] initWithFrame:CGRectMake(155, (i * 35) + 4, 97, 27)] autorelease];

        [providerSwitch addTarget:self
                           action:@selector(switchChanged:)
                 forControlEvents:UIControlEventValueChanged];

        providerSwitch.tag = 100 + i;

        [excludeProvidersView addSubview:providerLabel];
        [excludeProvidersView addSubview:providerSwitch];
    }

    self.navigationItem.rightBarButtonItem =
            [[[UIBarButtonItem alloc] initWithTitle:@"Next"
                                              style:UIBarButtonItemStyleDone
                                             target:self
                                             action:@selector(next:)] autorelease];

//    [self setToolbarItems:
//        [NSArray arrayWithObjects:
//         [[[UIBarButtonItem alloc] initWithTitle:@"Reset" style:UIBarButtonItemStyleBordered target:self action:@selector(reset:)] autorelease],
//         [[[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(next:)] autorelease],
//         [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease], nil]];

}

- (void)switchChanged:(id)sender
{
    UISwitch *sw = (UISwitch*)sender;

    //UISwitch *switch = (UISwitch*)sender;

    if (sw.on == YES)
    {
        UILabel *providerLabel = (UILabel*)[excludeProvidersView viewWithTag:sw.tag + 100];
        providerLabel.textColor = [UIColor lightGrayColor];
        providerLabel.text = [NSString stringWithFormat:@"%@ (excluded)", [configuredProviders objectAtIndex:sw.tag - 100]];// providerLabel.text];
    }
    else
    {
        UILabel *providerLabel = (UILabel*)[excludeProvidersView viewWithTag:sw.tag + 100];
        providerLabel.textColor = [UIColor blackColor];
        providerLabel.text = [configuredProviders objectAtIndex:sw.tag - 100];
    }
}



typedef enum
{
    CINativeLogin = 0,
    CIAlwaysForceReauth,
//    CISkipUserLanding,
    CIExcludeProviders,
} CellIndex;

- (void)reset:(id)sender {}

- (void)next:(id)sender
{
    [config resetSignIn];
    [config resetActivity];
    [config resetCustomInterface];

    for (int i = 0; i < [cellTitles count] / 3; i++)
    {
        TestConfigurationTableViewCell *cell =
            (TestConfigurationTableViewCell*)
                    [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];

        switch ((CellIndex)i)
        {
            case CINativeLogin:
                if (cell.cellSwitch.on) [config setSigninAddNativeLogin:YES];
                else [config setSigninAddNativeLogin:NO];
                break;
            case CIAlwaysForceReauth:
                if (cell.cellSwitch.on) [config setSigninAlwaysForceReauth:YES];
                else [config setSigninAlwaysForceReauth:NO];
                break;
//            case CISkipUserLanding:
//                if (cell.cellSwitch.on) [config setSigninSkipUserLanding:YES];
//                else [config setSigninSkipUserLanding:NO];
//                break;
            case CIExcludeProviders:
                if (cell.cellSwitch.on) [config setSigninExcludeProviders:YES];
                else [config setSigninExcludeProviders:NO];
                break;
            default:
                break;
        }
    }

    if (config.signinExcludeProviders)
    {
        excludedProviders = [NSMutableArray arrayWithCapacity:10];

        for (NSInteger i = 0; i < [configuredProviders count]; i++)
        {
            UISwitch *sw = (UISwitch*)[excludeProvidersView viewWithTag:i + 100];

            if (sw.on == YES)
                [excludedProviders addObject:[configuredProviders objectAtIndex:i]];
        }

        if ([excludedProviders count])
            [config setExcludeProvidersArray:excludedProviders];
    }

    StartTestViewController *startTestViewController =
            [[[StartTestViewController alloc] initWithNibName:@"StartTestViewController" bundle:nil] autorelease];
                [self.navigationController pushViewController:startTestViewController animated:YES];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [cellTitles count] / 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == ([cellTitles count] / 3) - 1)
        return 65 + excludeProvidersView.frame.size.height;

    return 65;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestConfigurationTableViewCell *cell =
            (TestConfigurationTableViewCell*)
                    [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell_%d", indexPath.row]];

    if (cell == nil)
    {
        cell = [[[TestConfigurationTableViewCell alloc]
                 initTestConfigurationTableViewCellWithStyle:TCTableViewCellStyleSwitch
                                             reuseIdentifier:[NSString stringWithFormat:@"cell_%d", indexPath.row]]
                autorelease];
    }

    cell.cellTitle.text = [cellTitles objectAtIndex:(indexPath.row * 3)];
    cell.cellSubtitle.text = [cellTitles objectAtIndex:((indexPath.row * 3) + 1)];

    if (indexPath.row == ([cellTitles count] / 3) - 1)
    {
        cell.previewStyle = TCTableViewCellPreviewStyleCustom;
        [cell.cellPreview setBackgroundImage:nil forState:UIControlStateNormal];
        [cell.cellPreview addSubview:excludeProvidersView];

    }
    else
    {
        [cell.cellPreview setHidden:YES];
    }

    [cell.cellBorder setHidden:YES];

    return cell;
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [cellTitles release];
    [excludeProvidersView release];
    [configuredProviders release];
//    [excludeProvidersSwitches release];
    [excludedProviders release];

    [super dealloc];
}


@end

