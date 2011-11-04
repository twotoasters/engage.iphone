//
//  SignInProviderConfigViewController.m
//  ApiTester
//
//  Created by lilli on 9/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SignInProviderConfigViewController.h"


@implementation SignInProviderConfigViewController


#define PROVIDER_LABEL_OFFSET  100
#define PROVIDER_SWITCH_OFFSET 200
#define CELL_TAG_OFFSET        300

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
                    @"Exclude Providers", @"Select providers below that you wish to exclude", @"sl", nil];

    cellSwitchStates = [[NSMutableArray alloc] initWithCapacity:([cellTitles count] / 3)];
    for (NSUInteger i = 0; i < ([cellTitles count] / 3); i++)
        [cellSwitchStates insertObject:[NSNumber numberWithBool:NO] atIndex:i];

    configuredProviders           = [[NSArray alloc] initWithArray:[[JRSessionData jrSessionData] basicProviders]];
    excludeProvidersView          = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, [configuredProviders count] * 35)];
    excludedProvidersSwitchStates = [[NSMutableArray alloc] initWithCapacity:[configuredProviders count]];

    for (NSUInteger i = 0; i < [configuredProviders count]; i++)
    {
        UILabel *providerLabel = [[[UILabel alloc] initWithFrame:CGRectMake(25, (i * 35), 125, 35)] autorelease];

        providerLabel.backgroundColor = [UIColor clearColor];
        providerLabel.font = [UIFont systemFontOfSize:15.0];
        providerLabel.text = [configuredProviders objectAtIndex:i];
        providerLabel.tag  = PROVIDER_LABEL_OFFSET + i;

        UISwitch *providerSwitch = [[[UISwitch alloc] initWithFrame:CGRectMake(155, (i * 35) + 4, 97, 27)] autorelease];

        [providerSwitch addTarget:self
                           action:@selector(switchChanged:)
                 forControlEvents:UIControlEventValueChanged];

        providerSwitch.tag = PROVIDER_SWITCH_OFFSET + i;

        [excludedProvidersSwitchStates insertObject:[NSNumber numberWithBool:NO] atIndex:i];

        [excludeProvidersView addSubview:providerLabel];
        [excludeProvidersView addSubview:providerSwitch];
    }

    [self.tableView setSeparatorColor:[UIColor darkGrayColor]];
    [self.tableView setAllowsSelection:NO];

    self.navigationItem.rightBarButtonItem =
            [[[UIBarButtonItem alloc] initWithTitle:@"Next"
                                              style:UIBarButtonItemStyleDone
                                             target:self
                                             action:@selector(next:)] autorelease];
}

- (void)switchChanged:(id)sender
{
    UISwitch *sw = (UISwitch*)sender;
    NSUInteger index = ((NSUInteger)sw.tag - PROVIDER_SWITCH_OFFSET);

    UILabel *providerLabel =
                (UILabel*)[excludeProvidersView viewWithTag:index + PROVIDER_LABEL_OFFSET];

    if (sw.on == YES)
    {
        providerLabel.textColor = [UIColor lightGrayColor];
        providerLabel.text =
                [NSString stringWithFormat:@"%@ (excluded)", [configuredProviders objectAtIndex:index]];

        [excludedProvidersSwitchStates replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:YES]];
        //[excludedProvidersSwitchStates insertObject:[NSNumber numberWithBool:YES] atIndex:index];
    }
    else
    {
        providerLabel.textColor = [UIColor blackColor];
        providerLabel.text = [configuredProviders objectAtIndex:index];

        [excludedProvidersSwitchStates replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:NO]];
        //[excludedProvidersSwitchStates insertObject:[NSNumber numberWithBool:NO] atIndex:index];
    }
}

typedef enum
{
    CINativeLogin = 0,
    CIAlwaysForceReauth,
//    CISkipUserLanding,
    CIExcludeProviders,
} CellIndex;


- (void)next:(id)sender
{
    [config resetSignIn];
    [config resetActivity];
    [config resetCustomInterface];

    for (NSUInteger i = 0; i < [cellTitles count] / 3; i++)
    {
//        TestConfigurationTableViewCell *cell =
//            (TestConfigurationTableViewCell*)
//                    [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];

        BOOL switchState = [((NSNumber*)[cellSwitchStates objectAtIndex:i]) boolValue];

        switch ((CellIndex)i)
        {
            case CINativeLogin:
                if (switchState == YES) [config setSigninAddNativeLogin:YES];
                else [config setSigninAddNativeLogin:NO];
                break;
            case CIAlwaysForceReauth:
                if (switchState == YES) [config setSigninAlwaysForceReauth:YES];
                else [config setSigninAlwaysForceReauth:NO];
                break;
//            case CISkipUserLanding:
//                if (switchState == YES) [config setSigninSkipUserLanding:YES];
//                else [config setSigninSkipUserLanding:NO];
//                break;
            case CIExcludeProviders:
                if (switchState == YES) [config setSigninExcludeProviders:YES];
                else [config setSigninExcludeProviders:NO];
                break;
            default:
                break;
        }
    }

    if (config.signinExcludeProviders)
    {
        excludedProviders = [NSMutableArray arrayWithCapacity:10];

        for (NSUInteger i = 0; i < [configuredProviders count]; i++)
        {
            UISwitch *sw = (UISwitch*)[excludeProvidersView viewWithTag:i + PROVIDER_SWITCH_OFFSET];

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

- (void)turnOnExcludedProviderSwitches
{
    for (NSUInteger i = 0; i < [excludedProvidersSwitchStates count]; i++)
        if([((NSNumber*)[excludedProvidersSwitchStates objectAtIndex:i]) boolValue])
            [(UISwitch *)([excludeProvidersView viewWithTag:(i + PROVIDER_SWITCH_OFFSET)]) setOn:YES animated:YES];
}

- (void)turnOffExcludedProviderSwitches
{
    for (NSUInteger i = 0; i < [excludedProvidersSwitchStates count]; i++)
        [(UISwitch *)([excludeProvidersView viewWithTag:(i + PROVIDER_SWITCH_OFFSET)]) setOn:NO animated:YES];
}

- (void)testConfigurationTableViewCell:(TestConfigurationTableViewCell*)cell switchDidChange:(UISwitch*)cellSwitch
{
    NSInteger cellIndex = cell.tag - CELL_TAG_OFFSET;

    if (cellIndex < [cellSwitchStates count])
        [cellSwitchStates replaceObjectAtIndex:(NSUInteger)cellIndex withObject:[NSNumber numberWithBool:cellSwitch.on]];

    if (cellIndex == CIExcludeProviders)
    {
        if (cellSwitch.on)
            [self turnOnExcludedProviderSwitches];
        else
            [self turnOffExcludedProviderSwitches];
    }
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (config.iPad)
        return YES;

    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

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

    if (indexPath.row == CIExcludeProviders)//([cellTitles count] / 3) - 1)
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

    cell.tag = CELL_TAG_OFFSET + indexPath.row;
    cell.delegate = self;

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
    [excludedProviders release];
    [cellSwitchStates release];

    [excludedProvidersSwitchStates release];
    [super dealloc];
}


@end

