//
//  SignInProviderConfigViewController.m
//  ApiTester
//
//  Created by lilli on 9/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DLog(...)
#endif

#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#import "SignInProviderConfigViewController.h"

@implementation SignInProviderConfigViewController


#define CELL_TAG_OFFSET                 100
#define EXCLUDED_PROVIDER_LABEL_OFFSET  200
#define EXCLUDED_PROVIDER_SWITCH_OFFSET 300
#define DIRECT_PROVIDER_LABEL_OFFSET    400
#define DIRECT_PROVIDER_SWITCH_OFFSET   500


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];

    config = [ConfigurationData sharedConfigurationData];

    cellTitles = [[NSArray alloc] initWithObjects:
                    @"Add Native Login", @"Add custom login above the list of providers", @"sl",
                    @"Always Force Reauthentication", @"Force the user to always reenter his login credentials", @"sl",
                    @"Direct Sign-In", @"Choose a provider with which you can authenticate directly", @"sl",
//                    @"Skip The User Landing Page", @"Always open to the list of providers first",  @"sl",
                    @"Exclude Providers", @"Select providers below that you wish to exclude", @"sl", nil];

    cellSwitchStates = [[NSMutableArray alloc] initWithCapacity:([cellTitles count] / 3)];
    for (NSUInteger i = 0; i < ([cellTitles count] / 3); i++)
        [cellSwitchStates insertObject:[NSNumber numberWithBool:NO] atIndex:i];

    configuredProviders           = [[NSArray alloc] initWithArray:[[JRSessionData jrSessionData] basicProviders]];

    excludeProvidersView          = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, [configuredProviders count] * 35)];
    excludedProvidersSwitchStates = [[NSMutableArray alloc] initWithCapacity:[configuredProviders count]];

    directProvidersView           = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, [configuredProviders count] * 35)];
    directProvidersSwitchStates   = [[NSMutableArray alloc] initWithCapacity:[configuredProviders count]];

    for (NSUInteger i = 0; i < [configuredProviders count]; i++)
    {
        UILabel *dProviderLabel = [[[UILabel alloc] initWithFrame:CGRectMake(25, (i * 35), 125, 35)] autorelease];
        UILabel *eProviderLabel = [[[UILabel alloc] initWithFrame:CGRectMake(25, (i * 35), 125, 35)] autorelease];

        dProviderLabel.backgroundColor = eProviderLabel.backgroundColor = [UIColor clearColor];
        dProviderLabel.font            = eProviderLabel.font            = [UIFont systemFontOfSize:15.0];
        dProviderLabel.text            = eProviderLabel.text            = [configuredProviders objectAtIndex:i];

        dProviderLabel.tag = DIRECT_PROVIDER_LABEL_OFFSET   + i;
        eProviderLabel.tag = EXCLUDED_PROVIDER_LABEL_OFFSET + i;

        UISwitch *dProviderSwitch = [[[UISwitch alloc] initWithFrame:CGRectMake(155, (i * 35) + 4, 97, 27)] autorelease];
        UISwitch *eProviderSwitch = [[[UISwitch alloc] initWithFrame:CGRectMake(155, (i * 35) + 4, 97, 27)] autorelease];

        [dProviderSwitch addTarget:self
                            action:@selector(directSwitchChanged:)
                  forControlEvents:UIControlEventValueChanged];

        [eProviderSwitch addTarget:self
                            action:@selector(excludeSwitchChanged:)
                  forControlEvents:UIControlEventValueChanged];

        dProviderSwitch.tag = DIRECT_PROVIDER_SWITCH_OFFSET   + i;
        eProviderSwitch.tag = EXCLUDED_PROVIDER_SWITCH_OFFSET + i;

        [directProvidersSwitchStates   insertObject:[NSNumber numberWithBool:NO] atIndex:i];
        [excludedProvidersSwitchStates insertObject:[NSNumber numberWithBool:NO] atIndex:i];

        [directProvidersView addSubview:dProviderLabel];
        [directProvidersView addSubview:dProviderSwitch];

        [excludeProvidersView addSubview:eProviderLabel];
        [excludeProvidersView addSubview:eProviderSwitch];
    }

    [self.tableView setSeparatorColor:[UIColor darkGrayColor]];
    [self.tableView setAllowsSelection:NO];

    self.navigationItem.rightBarButtonItem =
            [[[UIBarButtonItem alloc] initWithTitle:@"Next"
                                              style:UIBarButtonItemStyleDone
                                             target:self
                                             action:@selector(next:)] autorelease];
}

- (void)directSwitchChanged:(id)sender
{
    UISwitch  *sw    = (UISwitch*)sender;
    NSUInteger index = ((NSUInteger)sw.tag - DIRECT_PROVIDER_SWITCH_OFFSET);

    UILabel *providerLabel =
                (UILabel*)[excludeProvidersView viewWithTag:index + DIRECT_PROVIDER_LABEL_OFFSET];

    if (sw.on == YES)
    {
        providerLabel.textColor = [UIColor blackColor];

        NSArray *directProvidersSwitchStatesCopy = [[directProvidersSwitchStates copy] autorelease];
        for (NSUInteger i = 0; i < [directProvidersSwitchStatesCopy count]; i++)
        {
            if([((NSNumber*)[directProvidersSwitchStatesCopy objectAtIndex:i]) boolValue])
            {
                [(UISwitch *)([directProvidersView viewWithTag:(i + DIRECT_PROVIDER_SWITCH_OFFSET)]) setOn:NO animated:YES];
                [directProvidersSwitchStates replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:NO]];
            }
        }

        [directProvidersSwitchStates replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:YES]];
    }
    else
    {
        providerLabel.textColor = [UIColor lightGrayColor];

        [directProvidersSwitchStates replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:NO]];
    }
}

- (void)excludeSwitchChanged:(id)sender
{
    UISwitch  *sw    = (UISwitch*)sender;
    NSUInteger index = ((NSUInteger)sw.tag - EXCLUDED_PROVIDER_SWITCH_OFFSET);

    UILabel *providerLabel =
                (UILabel*)[excludeProvidersView viewWithTag:index + EXCLUDED_PROVIDER_LABEL_OFFSET];

    if (sw.on == YES)
    {
        providerLabel.textColor = [UIColor lightGrayColor];
        providerLabel.text =
                [NSString stringWithFormat:@"%@ (excluded)", [configuredProviders objectAtIndex:index]];

        [excludedProvidersSwitchStates replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:YES]];
    }
    else
    {
        providerLabel.textColor = [UIColor blackColor];
        providerLabel.text = [configuredProviders objectAtIndex:index];

        [excludedProvidersSwitchStates replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:NO]];
    }
}

typedef enum
{
    CINativeLogin = 0,
    CIAlwaysForceReauth,
    CIGoStraightToProvider,
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
            case CIGoStraightToProvider:
                if (switchState == YES) [config setSigninStraightToProvider:YES];
                else [config setSigninStraightToProvider:NO];
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

    if (config.signinStraightToProvider)
    {
        for (NSUInteger i = 0; i < [configuredProviders count]; i++)
        {
            UILabel  *providerLabel  =  (UILabel*)[directProvidersView viewWithTag:i + DIRECT_PROVIDER_LABEL_OFFSET];
            UISwitch *providerSwitch = (UISwitch*)[directProvidersView viewWithTag:i + DIRECT_PROVIDER_SWITCH_OFFSET];

            if (providerSwitch.on == YES)
                directProvider = providerLabel.text;

            DLog(@"provider: %@", directProvider);
        }

        if (directProvider)
            [config setGoStraightToProvider:directProvider];
        else
            [config setSigninStraightToProvider:NO];
    }

    if (config.signinExcludeProviders)
    {
        excludedProviders = [NSMutableArray arrayWithCapacity:10];

        for (NSUInteger i = 0; i < [configuredProviders count]; i++)
        {
            UISwitch *sw = (UISwitch*)[excludeProvidersView viewWithTag:i + EXCLUDED_PROVIDER_SWITCH_OFFSET];

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

- (void)turnOnDirectProviderSwitches
{
    for (NSUInteger i = 0; i < [directProvidersSwitchStates count]; i++)
        if([((NSNumber*)[directProvidersSwitchStates objectAtIndex:i]) boolValue])
            [(UISwitch *)([directProvidersView viewWithTag:(i + DIRECT_PROVIDER_SWITCH_OFFSET)]) setOn:YES animated:YES];
}

- (void)turnOffDirectProviderSwitches
{
    for (NSUInteger i = 0; i < [directProvidersSwitchStates count]; i++)
        [(UISwitch *)([directProvidersView viewWithTag:(i + DIRECT_PROVIDER_SWITCH_OFFSET)]) setOn:NO animated:YES];
}

- (void)turnOnExcludedProviderSwitches
{
    for (NSUInteger i = 0; i < [excludedProvidersSwitchStates count]; i++)
        if([((NSNumber*)[excludedProvidersSwitchStates objectAtIndex:i]) boolValue])
            [(UISwitch *)([excludeProvidersView viewWithTag:(i + EXCLUDED_PROVIDER_SWITCH_OFFSET)]) setOn:YES animated:YES];
}

- (void)turnOffExcludedProviderSwitches
{
    for (NSUInteger i = 0; i < [excludedProvidersSwitchStates count]; i++)
        [(UISwitch *)([excludeProvidersView viewWithTag:(i + EXCLUDED_PROVIDER_SWITCH_OFFSET)]) setOn:NO animated:YES];
}

- (void)testConfigurationTableViewCell:(TestConfigurationTableViewCell*)cell switchDidChange:(UISwitch*)cellSwitch
{
    NSInteger cellIndex = cell.tag - CELL_TAG_OFFSET;

    if (cellIndex < [cellSwitchStates count])
        [cellSwitchStates replaceObjectAtIndex:(NSUInteger)cellIndex withObject:[NSNumber numberWithBool:cellSwitch.on]];

    if (cellIndex == CIGoStraightToProvider)
    {
        if (cellSwitch.on)
            [self turnOnDirectProviderSwitches];
        else
            [self turnOffDirectProviderSwitches];
    }
    else if (cellIndex == CIExcludeProviders)
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
    if (indexPath.row == CIGoStraightToProvider)
        return 65 + directProvidersView.frame.size.height;

    if (indexPath.row == CIExcludeProviders)
        return 65 + excludeProvidersView.frame.size.height;

    return 65;
}

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

        cell.cellBorder.hidden = YES;

        cell.delegate = self;
    }

    cell.cellTitle.text    = [cellTitles objectAtIndex:(indexPath.row * 3)];
    cell.cellSubtitle.text = [cellTitles objectAtIndex:((indexPath.row * 3) + 1)];

    if (indexPath.row == CIGoStraightToProvider)
    {
        [cell setPreviewStyle:TCTableViewCellPreviewStyleCustom];
        [cell.cellPreview setBackgroundColor:[UIColor clearColor]];
        [cell.cellPreview addSubview:directProvidersView];
    }
    else if (indexPath.row == CIExcludeProviders)
    {
        [cell setPreviewStyle:TCTableViewCellPreviewStyleCustom];
        [cell.cellPreview setBackgroundColor:[UIColor clearColor]];
        [cell.cellPreview addSubview:excludeProvidersView];
    }
    else
    {
        [cell.cellPreview setHidden:YES];
    }

    cell.tag = CELL_TAG_OFFSET + indexPath.row;

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
    [directProvidersView release];
    [directProvidersSwitchStates release];
    [super dealloc];
}


@end

