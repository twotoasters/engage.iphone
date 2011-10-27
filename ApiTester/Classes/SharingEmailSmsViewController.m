//
//  SharingEmailSmsViewController.m
//  ApiTester
//
//  Created by lilli on 9/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SharingEmailSmsViewController.h"
#import "ConfigurationData.h"


@implementation SharingEmailSmsViewController


#pragma mark -
#pragma mark View lifecycle

#define SMS_LABEL_OFFSET    100
#define SMS_SWITCH_OFFSET   200
#define EMAIL_LABEL_OFFSET  300
#define EMAIL_SWITCH_OFFSET 400
#define CELL_TAG_OFFSET     500

- (void)viewDidLoad
{
    [super viewDidLoad];

    config = [ConfigurationData sharedConfigurationData];

    cellTitles = [[NSArray alloc] initWithObjects:
                                @"Add Sms", @"Add an sms message to the activity", @"ss",
                                @"Add Email", @"Add an email to the activity", @"ss", nil];

    allSmsChoices =  [[NSArray alloc] initWithObjects:
                                @"Shorten the url in the sms",
                                @"Try and shorten urls that aren't in the sms",
                                @"Try and shorten badly formed urls", nil];

    allEmailChoices = [[NSArray alloc] initWithObjects:
                                @"Make the email html (currently plain text)",
                                @"Shorten all of the urls in the email",
                                @"Shorten only some of the urls",
                                @"Try and shorten urls that aren't in the email",
                                @"Try and shorten badly formed urls", nil];


    cellSwitchStates = [[NSMutableArray alloc] initWithCapacity:([cellTitles count] / 3)];

    for (NSUInteger i = 0; i < ([cellTitles count] / 3); i++)
        [cellSwitchStates insertObject:[NSNumber numberWithBool:NO] atIndex:i];

    CGFloat width;
    if (config.iPad)
        width = 768.0;
    else
        width = 320;

    smsCustomizationsView   = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, ([allSmsChoices count] * 35) + 25)];
    emailCustomizationsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, ([allEmailChoices count] * 35) + 25)];

    for (NSUInteger i = 0; i < [allSmsChoices count]; i++)
    {
        UILabel *smsLabel = [[[UILabel alloc] initWithFrame:CGRectMake(15, (i * 35), width - 152, 35)] autorelease];

        smsLabel.backgroundColor = [UIColor clearColor];
        smsLabel.font            = [UIFont systemFontOfSize:12.0];
        smsLabel.text            = [allSmsChoices objectAtIndex:i];
        smsLabel.textColor       = [UIColor grayColor];
        smsLabel.numberOfLines   = 2;

        UISwitch *smsSwitch = [[[UISwitch alloc] initWithFrame:CGRectMake(width - 132, (i * 35) + 4, 97, 27)] autorelease];

        [smsSwitch addTarget:self
                      action:@selector(smsSwitchChanged:)
            forControlEvents:UIControlEventValueChanged];

        smsLabel.tag  = SMS_LABEL_OFFSET + i;
        smsSwitch.tag = SMS_SWITCH_OFFSET + i;

        [smsCustomizationsView addSubview:smsLabel];
        [smsCustomizationsView addSubview:smsSwitch];
    }

    for (NSUInteger i = 0; i < [allEmailChoices count]; i++)
    {
        UILabel *emailLabel = [[[UILabel alloc] initWithFrame:CGRectMake(15, (i * 35), width - 152, 35)] autorelease];

        emailLabel.backgroundColor = [UIColor clearColor];
        emailLabel.font            = [UIFont systemFontOfSize:12.0];
        emailLabel.text            = [allEmailChoices objectAtIndex:i];
        emailLabel.textColor       = [UIColor grayColor];
        emailLabel.numberOfLines   = 2;


        UISwitch *emailSwitch = [[[UISwitch alloc] initWithFrame:CGRectMake(width - 132, (i * 35) + 4, 97, 27)] autorelease];

        [emailSwitch addTarget:self
                           action:@selector(emailSwitchChanged:)
                 forControlEvents:UIControlEventValueChanged];

        emailLabel.tag  = EMAIL_LABEL_OFFSET + i;
        emailSwitch.tag = EMAIL_SWITCH_OFFSET + i;

        [emailCustomizationsView addSubview:emailLabel];
        [emailCustomizationsView addSubview:emailSwitch];
    }

    [self.tableView setSeparatorColor:[UIColor darkGrayColor]];
    [self.tableView setAllowsSelection:NO];

    self.navigationItem.rightBarButtonItem =
            [[[UIBarButtonItem alloc] initWithTitle:@"Next"
                                              style:UIBarButtonItemStyleDone
                                             target:self
                                             action:@selector(next:)] autorelease];
}

- (void)smsSwitchChanged:(id)sender
{
    UISwitch *sw = (UISwitch*)sender;

    UILabel *smsLabel = (UILabel*)[emailCustomizationsView viewWithTag:sw.tag - SMS_SWITCH_OFFSET + SMS_LABEL_OFFSET];
    if (sw.on == YES)
    {
        smsLabel.textColor = [UIColor darkGrayColor];
    }
    else
    {
        smsLabel.textColor = [UIColor lightGrayColor];
    }
}

- (void)emailSwitchChanged:(id)sender
{
    UISwitch *sw = (UISwitch*)sender;

    UILabel *emailLabel = (UILabel*)[emailCustomizationsView viewWithTag:sw.tag - EMAIL_SWITCH_OFFSET + EMAIL_LABEL_OFFSET];
    if (sw.on == YES)
    {
        emailLabel.textColor = [UIColor darkGrayColor];
        if ([emailLabel.text isEqualToString:@"Make the email html (currently plain text)"])
            emailLabel.text = @"Make the email html";
    }
    else
    {
        emailLabel.textColor = [UIColor lightGrayColor];
        if ([emailLabel.text isEqualToString:@"Make the email html"])
            emailLabel.text = @"Make the email html (currently plain text)";
    }
}

typedef enum
{
    CISms = 0,
    CIEmail,
} CellIndex;


// TODO: This will stop working if too many cells; do what sign in custom ui does
- (void)next:(id)sender
{
    [config resetSignIn];
    [config resetActivity];
    [config resetCustomInterface];

    for (NSUInteger i = 0; i < [cellSwitchStates count]; i++)
    {
        BOOL switchState = [((NSNumber*)[cellSwitchStates objectAtIndex:i]) boolValue];

        switch ((CellIndex)i)
        {
            case CISms:
                if (switchState == YES) [config setActivityAddDefaultSmsObject:YES];
                else  [config setActivityAddDefaultSmsObject:NO];
                break;
            case CIEmail:
                if (switchState == YES) [config setActivityAddDefaultEmailObject:YES];
                else  [config setActivityAddDefaultEmailObject:NO];
                break;
            default:
                break;
        }
    }

    [config setActivityAddDefaultAction:YES];
    [config setActivityAddDefaultUrl:YES];
    [config setActivityAddDefaultImage:YES];
    [config setActivityAddDefaultTitle:YES];
    [config setActivityAddDefaultDescription:YES];

    if (config.activityAddDefaultSmsObject)
    {
        for (NSInteger i = 0; i < [allSmsChoices count]; i++)
        {
            UISwitch *sw = (UISwitch*)[smsCustomizationsView viewWithTag:i + SMS_SWITCH_OFFSET];

            switch (i)
            {
                case 0:
                    if (sw.on == YES) [config setSmsObjectToShortenUrl:YES];
                    else [config setSmsObjectToShortenUrl:NO];
                    break;
                case 1:
                    if (sw.on == YES) [config setSmsObjectToShortenNonexistentUrls:YES];
                    else [config setSmsObjectToShortenNonexistentUrls:YES];
                    break;
                case 2:
                    if (sw.on == YES) [config setSmsObjectToShortenBadUrls:YES];
                    else [config setSmsObjectToShortenBadUrls:NO];
                    break;
                default:
                    break;
            }
        }
    }

    if (config.activityAddDefaultEmailObject)
    {
        for (NSInteger i = 0; i < [allEmailChoices count]; i++)
        {
            UISwitch *sw = (UISwitch*)[emailCustomizationsView viewWithTag:i + EMAIL_SWITCH_OFFSET];

            switch (i)
            {
                case 0:
                    if (sw.on == YES) [config setEmailObjectToHtml:YES];
                    else [config setEmailObjectToHtml:NO];
                    break;
                case 1:
                    if (sw.on == YES) [config setEmailObjectToShortenAllUrls:YES];
                    else [config setEmailObjectToShortenAllUrls:NO];
                    break;
                case 2:
                    if (sw.on == YES) [config setEmailObjectToShortenSomeUrls:YES];
                    else [config setEmailObjectToShortenSomeUrls:NO];
                    break;
                case 3:
                    if (sw.on == YES) [config setEmailObjectToShortenNonexistentUrls:YES];
                    else [config setEmailObjectToShortenNonexistentUrls:YES];
                    break;
                case 4:
                    if (sw.on == YES) [config setEmailObjectToShortenBadUrls:YES];
                    else [config setEmailObjectToShortenBadUrls:NO];
                    break;
                default:
                    break;
            }
        }
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cellTitles count] / 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == CISms)
        return 65 + smsCustomizationsView.frame.size.height;
    else if (indexPath.row == CIEmail)
        return 65 + emailCustomizationsView.frame.size.height;

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

    cell.previewStyle = TCTableViewCellPreviewStyleCustom;
    [cell.cellPreview setBackgroundImage:nil forState:UIControlStateNormal];

    if (indexPath.row == CISms)
        [cell.cellPreview addSubview:smsCustomizationsView];
    else if (indexPath.row == CIEmail)
        [cell.cellPreview addSubview:emailCustomizationsView];

    [cell.cellBorder setHidden:YES];

    cell.tag = CELL_TAG_OFFSET + indexPath.row;
    cell.delegate = self;

    return cell;
}

- (void)testConfigurationTableViewCell:(TestConfigurationTableViewCell*)cell switchDidChange:(UISwitch*)cellSwitch
{
    NSInteger cellIndex = cell.tag - CELL_TAG_OFFSET;

    if (cellIndex < [cellSwitchStates count])
        [cellSwitchStates replaceObjectAtIndex:(NSUInteger)cellIndex withObject:[NSNumber numberWithBool:cellSwitch.on]];
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
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
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
    [cellTitles release];
    [allEmailChoices release];
    [allSmsChoices release];
    [emailCustomizationsView release];
    [smsCustomizationsView release];
    [cellSwitchStates release];
    [super dealloc];
}


@end

