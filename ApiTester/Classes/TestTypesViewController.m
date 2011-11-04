//
//  TestOptionsLevel1.m
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

#import <UIKit/UIKit.h>
#import "TestTypesViewController.h"
#import "SharingActivityWithBadParamsViewController.h"
#import "ConfigurationData.h"

@implementation TestTypesViewController
@synthesize delegate;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    config = [ConfigurationData sharedConfigurationData];

    if (config.iPad)
    {
        signInTestTypes = [[NSArray alloc] initWithObjects:
                             @"Test Basic Sign-In", @"The default sign-in process", @"ss",
                             @"Test Various UI Customizations", @"Add background a background image, custom titles, different colors, etc.", @"sl",
                             @"Test Different Provider Configurations", @"Add a native provider, exclude certain providers, always force reauthentication, skip the user landing page", @"sl",
                             nil];

        sharingTestTypes = [[NSArray alloc] initWithObjects:
                              @"Test Basic Sharing", @"Share a basic activity", @"ss",
                              @"Test Email/SMS", @"Sharing activities with email/sms", @"ss",
                              @"Test Various UI Customizations", @"Custom titles, different colors, etc.", @"ss",
                              @"Test Different Activities", @"Activities with varying titles and descriptions, media, etc.", @"ss",
                              @"Test Activities With Bad Input", @"Add whatever gobbledegook you can think of", @"ss",
                              nil];
    }
    else
    {
        signInTestTypes = [[NSArray alloc] initWithObjects:
                             @"Test Basic Sign-In", @"The default sign-in process", @"ss",
                             @"Test Various UI Customizations", @"Add background a background image, custom titles, different colors, etc.", @"sl",
                             @"Test Different Provider Configurations", @"Add a native provider, exclude certain providers, always force reauthentication, skip the user landing page", @"ll",
                             nil];

        sharingTestTypes = [[NSArray alloc] initWithObjects:
                              @"Test Basic Sharing", @"Share a basic activity", @"ss",
                              @"Test Email/SMS", @"Sharing activities with email/sms", @"ss",
                              @"Test Various UI Customizations", @"Custom titles, different colors, etc.", @"ss",
                              @"Test Different Activities", @"Activities with varying titles and descriptions, media, etc.", @"sl",
                              @"Test Activities With Bad Input", @"Add whatever gobbledegook you can think of", @"ss",
                              nil];
    }

    titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 44)] autorelease];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
    titleLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];

    self.navigationItem.titleView = titleLabel;
    self.title = @"Types";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (config.signInOrSharing == CDSignIn)
    {
        titleLabel.text = @"Sign-In Test Types";
    }
    else if (config.signInOrSharing == CDSharing)
    {
        titleLabel.text = @"Sharing Test Types";
    }
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView                         { return 1; }
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section { return 70; }
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section  { return nil; }

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (config.signInOrSharing == CDSignIn)
        return @"Sign-In Tests";
    else if (config.signInOrSharing == CDSharing)
        return @"Sharing Tests";
    else
        return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (config.signInOrSharing == CDSignIn)
        return [signInTestTypes count] / 3;
    else if (config.signInOrSharing == CDSharing)
        return [sharingTestTypes count] / 3;
    else
        return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (config.iPad)
//        return 52;

    NSString *cellSize;

    /* Every third string in our array tells us how big the titles and subtitles strings are (s = short, l = long) */
    if (config.signInOrSharing == CDSignIn)
        cellSize = [signInTestTypes objectAtIndex:((indexPath.row * 3) + 2)];
    else if (config.signInOrSharing == CDSharing)
        cellSize = [sharingTestTypes objectAtIndex:((indexPath.row * 3) + 2)];
    else
        cellSize = @"ss";

    if ([cellSize isEqualToString:@"ss"])
        return 52;//44;
    else if ([cellSize isEqualToString:@"sl"])
        return 70;//62;
    else if ([cellSize isEqualToString:@"ls"])
        return 74;//66;
    else if ([cellSize isEqualToString:@"ll"])
        return 92;//84;
    else
        return 52;//44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array;

 /* Get the array of cell titles, subtitles, and label sizes */
    if (config.signInOrSharing == CDSignIn)
        array = signInTestTypes;
    else if (config.signInOrSharing == CDSharing)
        array = sharingTestTypes;
    else /* Won't ever happen */
        array = nil;

 /* Every third string in our array tells us how big the titles and subtitles strings are (s = short, l = long) */
    NSString *cellSize = [array objectAtIndex:((indexPath.row * 3) + 2)];

    NSString        *cellIdentifier = [NSString stringWithFormat:@"cell_%@", cellSize];
    UITableViewCell *cell           = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (cell == nil)
    {
         cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                        reuseIdentifier:cellIdentifier] autorelease];

        if ([cellSize isEqualToString:@"sl"])
        {
            cell.detailTextLabel.numberOfLines = 2;
        }
        else if ([cellSize isEqualToString:@"ls"])
        {
            cell.textLabel.numberOfLines = 2;
        }
        else if ([cellSize isEqualToString:@"ll"])
        {
            cell.textLabel.numberOfLines = 2;
            cell.detailTextLabel.numberOfLines = 2;
        }
    }

    cell.textLabel.text       = [array objectAtIndex:(indexPath.row * 3)];
    cell.detailTextLabel.text = [array objectAtIndex:((indexPath.row * 3) + 1)];


//    NSInteger cleverIndex = ((config.signInOrSharing - 1) * 3) + indexPath.row;
//
//    if (cleverIndex == 2 || cleverIndex == 4 || cleverIndex == 5)
//    {
//        [cell setBackgroundColor:[UIColor lightGrayColor]];
//        [cell.textLabel setBackgroundColor:[UIColor darkGrayColor]];
//        [cell.detailTextLabel setBackgroundColor:[UIColor darkGrayColor]];
//    }

    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *level2ViewController = nil;

    if (config.signInOrSharing == CDSignIn)
        switch (indexPath.row)
        {
            case 0:
                [config resetSignIn];
                [config resetCustomInterface];

                config.signInTestType = CDSignInTestTypeBasic;
                level2ViewController =
                    [[StartTestViewController alloc] initWithNibName:@"StartTestViewController"
                                                              bundle:nil];
                break;
            case 1:
                config.signInTestType = CDSignInTestTypeCustomInterface;
                level2ViewController =
                    [[SignInCustomInterfaceViewController alloc] initWithNibName:@"SignInCustomInterfaceViewController"
                                                                          bundle:nil];
                break;
            case 2:
                config.signInTestType = CDSignInTestTypeProviderConfiguration;
                level2ViewController =
                    [[SignInProviderConfigViewController alloc] initWithNibName:@"SignInProviderConfigViewController"
                                                                         bundle:nil];
                break;
            default:
                break;
        }
    else if (config.signInOrSharing == CDSharing)
        switch (indexPath.row)
        {
            case 0:
                [config resetSignIn];
                [config resetCustomInterface];
                [config resetActivity];

                config.activityAddDefaultAction      = YES;
                config.activityAddDefaultUrl         = YES;
                config.activityAddDefaultTitle       = YES;
                config.activityAddDefaultDescription = YES;
                config.activityAddDefaultImage       = YES;

                config.sharingTestType = CDSharingTestTypeBasic;
                level2ViewController =
                    [[StartTestViewController alloc] initWithNibName:@"StartTestViewController"
                                                              bundle:nil];
                break;
            case 1:
                config.sharingTestType = CDSharingTestTypeEmailSms;
                level2ViewController =
                    [[SharingEmailSmsViewController alloc] initWithNibName:@"SharingEmailSmsViewController"
                                                                    bundle:nil];
                break;
            case 2:
                config.sharingTestType = CDSharingTestTypeCustomInterface;
                level2ViewController =
                    [[SharingCustomInterfaceViewController alloc] initWithNibName:@"SharingCustomInterfaceViewController"
                                                                           bundle:nil];
                break;
            case 3:
                config.sharingTestType = CDSharingTestTypeActivityChanges;
                level2ViewController =
                    [[SharingActivityChangesViewController alloc] initWithNibName:@"SharingActivityChangesViewController"
                                                                           bundle:nil];
                break;
            case 4:
                config.sharingTestType = CDSharingTestTypeBadActivityParams;
                level2ViewController =
                    [[SharingActivityWithBadParamsViewController alloc] initWithNibName:@"SharingActivityWithBadParamsViewController"
                                                                                 bundle:nil];
                break;
            default:
                break;
        }

    if (config.iPad)
    {
        if ([delegate respondsToSelector:@selector(testTypesViewController:tableView:didSelectViewController:)])
            [delegate testTypesViewController:self tableView:tableView didSelectViewController:level2ViewController];
    }
    else
    {
        [self.navigationController pushViewController:level2ViewController animated:YES];
    }

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [level2ViewController release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (config.iPad)
        return YES;

    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

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
    [delegate release];

    [signInTestTypes release];
    [sharingTestTypes release];

    [super dealloc];
}

@end

