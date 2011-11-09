//
//  SharingCustomInterfaceViewController.m
//  ApiTester
//
//  Created by lilli on 9/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SharingCustomInterfaceViewController.h"
#import "TestConfigurationTableViewCell.h"
#import "StartTestViewController.h"
#import "ConfigurationData.h"


@implementation SharingCustomInterfaceViewController


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];

     config = [ConfigurationData sharedConfigurationData];

     cellTitles = [[NSArray alloc] initWithObjects:
                     @"Background Color", @"Use a custom background color", @"ss",
                     @"Background Image", @"Use a custom background image", @"ss",
                     @"Sharing UI Title View", @"Use a custom view for the title above the providers table",  @"sl",
                     @"Sharing UI Title String", @"Use a custom string for the title above the providers table", @"sl", nil];

     [self.tableView setSeparatorColor:[UIColor darkGrayColor]];
     [self.tableView setAllowsSelection:NO];

     cellSwitchStates = [[NSMutableArray alloc] initWithCapacity:([cellTitles count] / 3)];

     for (NSUInteger i = 0; i < ([cellTitles count] / 3); i++)
         [cellSwitchStates insertObject:[NSNumber numberWithBool:NO] atIndex:i];

     self.navigationItem.rightBarButtonItem =
             [[[UIBarButtonItem alloc] initWithTitle:@"Next"
                                               style:UIBarButtonItemStyleDone
                                              target:self
                                              action:@selector(next:)] autorelease];
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

typedef enum
{
    CISharingBackgroundColor = 0,
    CISharingBackgroundImageView,
    CISharingTitleView,
    CISharingTitleString,
} CellIndex;

#define CELL_TAG_OFFSET 100

- (void)next:(id)sender
{
    [config resetActivity];
    [config resetCustomInterface];

    config.activityAddDefaultAction      = YES;
    config.activityAddDefaultUrl         = YES;
    config.activityAddDefaultTitle       = YES;
    config.activityAddDefaultDescription = YES;
    config.activityAddDefaultImage       = YES;

    for (NSUInteger i = 0; i < [cellSwitchStates count]; i++)
    {
        BOOL switchState = [((NSNumber*)[cellSwitchStates objectAtIndex:i]) boolValue];

        switch ((CellIndex)i)
        {
            case CISharingBackgroundColor:
                if (switchState == YES) [config setSharingBackgroundColor:YES];
                else  [config setSharingBackgroundColor:NO];
                break;
            case CISharingBackgroundImageView:
                if (switchState == YES) [config setSharingBackgroundImageView:YES];
                else  [config setSharingBackgroundImageView:NO];
                break;
            case CISharingTitleView:
                if (switchState == YES) [config setSharingTitleView:YES];
                else  [config setSharingTitleView:NO];
                break;
            case CISharingTitleString:
                if (switchState == YES) [config setSharingTitleString:YES];
                else  [config setSharingTitleString:NO];
                break;
            default:
                break;
        }
    }

    StartTestViewController *startTestViewController =
            [[[StartTestViewController alloc] initWithNibName:@"StartTestViewController" bundle:nil] autorelease];

    [self.navigationController pushViewController:startTestViewController animated:YES];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return 1; }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cellTitles count] / 3;
}

- (void)setPreviewForCell:(TestConfigurationTableViewCell*)cell atIndex:(CellIndex)cellIndex
{
    UIButton *cellPreviewButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 24)] autorelease];

    [cellPreviewButton setBackgroundImage:[UIImage imageNamed:@"enabledLightGray"] forState:UIControlStateNormal];
    [cellPreviewButton setEnabled:NO];
    [cellPreviewButton.titleLabel setFont:[UIFont boldSystemFontOfSize:12.0]];
    [cellPreviewButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [cellPreviewButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];

    switch (cellIndex)
    {
        case CISharingBackgroundColor:
            [cellPreviewButton setImage:[UIImage imageNamed:@"enabledCyan"] forState:UIControlStateNormal];
            break;
        case CISharingBackgroundImageView:
            [cellPreviewButton setImage:[UIImage imageNamed:@"enabledWeave"] forState:UIControlStateNormal];
            break;
        case CISharingTitleView:
            [cellPreviewButton setTitle:@"Custom Title View" forState:UIControlStateNormal];
            [cellPreviewButton.titleLabel setBackgroundColor:[UIColor magentaColor]];
            [cellPreviewButton.titleLabel setFont:[UIFont fontWithName:@"MarkerFelt-Wide" size:12.0]];
            break;
        case CISharingTitleString:
            [cellPreviewButton setTitle:@"Custom Title String" forState:UIControlStateNormal];
            break;
        default:
            break;
    }

    [cell.cellPreview addSubview:cellPreviewButton];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (config.iPad)
        return 110;

    NSString *cellSize = [cellTitles objectAtIndex:((indexPath.row * 3) + 2)];

    if ([cellSize isEqualToString:@"ss"])
        return 110;
    else if ([cellSize isEqualToString:@"ls"])
        return 112;
    else if ([cellSize isEqualToString:@"sl"])
        return 128;
    else if ([cellSize isEqualToString:@"ll"])
        return 130;
    else /* Won't ever happen */
        return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 /* Every third string in our array tells us how big the titles and subtitles strings are (s = short, l = long) */
    NSString *cellSize = [cellTitles objectAtIndex:((indexPath.row * 3) + 2)];
    TCTableViewCellStyle style;

    if (config.iPad)
        style = TCTableViewCellStyleSwitch;
    else if ([cellSize isEqualToString:@"ss"])
        style = TCTableViewCellStyleSwitch;
    else if ([cellSize isEqualToString:@"ls"])
        style = TCTableViewCellStyleSwitchWithLongTitle;
    else if ([cellSize isEqualToString:@"sl"])
        style = TCTableViewCellStyleSwitchWithLongSubtitle;
    else if ([cellSize isEqualToString:@"ll"])
        style = TCTableViewCellStyleSwitchWithLongTitleAndSubtitle;
    else /* Won't ever happen */
        style = TCTableViewCellStyleSwitch;

    TestConfigurationTableViewCell *cell =
        (TestConfigurationTableViewCell*)
                [tableView dequeueReusableCellWithIdentifier:
                        [NSString stringWithFormat:@"cell_%d", indexPath.row]];

    if (cell == nil)
    {
        cell = [[[TestConfigurationTableViewCell alloc]
                 initTestConfigurationTableViewCellWithStyle:style
                                             reuseIdentifier:[NSString stringWithFormat:@"cell_%d", indexPath.row]]
                autorelease];

        cell.delegate = self;
    }

    cell.cellTitle.text    = [cellTitles objectAtIndex:(indexPath.row * 3)];
    cell.cellSubtitle.text = [cellTitles objectAtIndex:((indexPath.row * 3) + 1)];

    [self setPreviewForCell:cell atIndex:(CellIndex)indexPath.row];

    cell.tag = CELL_TAG_OFFSET + indexPath.row;

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
    [cellSwitchStates release];
    [super dealloc];
}

@end

