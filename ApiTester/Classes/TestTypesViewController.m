//
//  TestOptionsLevel1.m
//  ApiTester
//
//  Created by lilli on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TestTypesViewController.h"

@implementation TestTypesViewController
                
#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad 
{
    [super viewDidLoad];

    config = [ConfigurationData sharedConfigurationData];
    
    
    signInTestTypes = [[NSArray alloc] initWithObjects:
                         @"Test Basic Sign-In", @"the default sign-in process",
                         @"Test Various UI Customizations", @"add a native provider, custom titles, different colors, etc.",
                         @"Test Different Provider Configurations", @"exclude certain providers, always force reauthentication, skip the user landing page",
                         nil];
    
    sharingTestTypes = [[NSArray alloc] initWithObjects:
                          @"Test Basic Sharing", @"share a basic activity",
                          @"Test Email/SMS", @"sharing activities with email/sms",
                          @"Test Various UI Customizations", @"custom titles, different colors, etc.",
                          @"Test Different Activities", @"activities with varying titles and descriptions, media, etc.",
                          nil];
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    if (config.signInOrSharing == CDSignIn)
        return [signInTestTypes count]/2;
    else if (config.signInOrSharing == CDSharing)
        return [sharingTestTypes count]/2;
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSArray *array;
    
    if (config.signInOrSharing == CDSignIn)
        array = signInTestTypes;
    else if (config.signInOrSharing == CDSharing)
        array = sharingTestTypes;
    
    cell.textLabel.text = [array objectAtIndex:(indexPath.row * 2)];
    cell.detailTextLabel.text = [array objectAtIndex:((indexPath.row * 2) + 1)];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *level2ViewController;
    
    if (config.signInOrSharing == CDSignIn)
        switch (indexPath.row)
        {
            case 0:
                config.signInTestType = CDSignInTestTypeBasic;
                level2ViewController = [[StartTestViewController alloc] initWithNibName:@"StartTestViewController" bundle:nil];
                break;
            case 1:
                config.signInTestType = CDSignInTestTypeCustomInterface;
                level2ViewController = [[SignInCustomInterfaceViewController alloc] initWithNibName:@"SignInCustomInterfaceViewController" bundle:nil];
                break;
            case 2:
                config.signInTestType = CDSignInTestTypeProviderConfiguration;
                level2ViewController = [[SignInProviderConfigViewController alloc] initWithNibName:@"SignInProviderConfigViewController" bundle:nil];
                break;
            default:
                break;
        }
    else if (config.signInOrSharing == CDSharing)
        switch (indexPath.row)
        {
            case 0:
                config.sharingTestType = CDSharingTestTypeBasic;
                level2ViewController = [[StartTestViewController alloc] initWithNibName:@"StartTestViewController" bundle:nil];
                break;
            case 1:
                config.sharingTestType = CDSharingTestTypeEmailSms;
                level2ViewController = [[SharingEmailSmsViewController alloc] initWithNibName:@"SharingEmailSmsViewController" bundle:nil];
                break;
            case 2:
                config.sharingTestType = CDSharingTestTypeCustomInterface;
                level2ViewController = [[SharingCustomInterfaceViewController alloc] initWithNibName:@"SharingCustomInterfaceViewController" bundle:nil];
                break;
            case 3:
                config.sharingTestType = CDSharingTestTypeActivityChanges;
                level2ViewController = [[SharingActivityChangesViewController alloc] initWithNibName:@"SharingActivityChangesViewController" bundle:nil];
                break;
            default:
                break;
        }
    
    [self.navigationController pushViewController:level2ViewController animated:YES];
    [level2ViewController release];    
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


- (void)dealloc {
    [super dealloc];
}


@end

