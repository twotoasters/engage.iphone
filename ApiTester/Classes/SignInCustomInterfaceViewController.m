//
//  SignInCustomInterfaceViewController.m
//  ApiTester
//
//  Created by lilli on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SignInCustomInterfaceViewController.h"


@implementation SignInCustomInterfaceViewController


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];

    config = [ConfigurationData sharedConfigurationData];

    cellTitles = [[NSArray alloc] initWithObjects:
                    @"Background Color", @"Use a custom background color", @"ss",
                    @"Background Image", @"Use a custom background image", @"ss",
                    @"Providers Table Title View", @"Use a custom view for the title above the providers table",  @"sl",
                    @"Providers Table Title String", @"Use a custom string for the title above the providers table", @"sl",
                    @"Providers Table Header View", @"Use a custom view over the providers table", @"ss",
                    @"Providers Table Footer View", @"Use a custom view below the providers table", @"ss",
                    @"Providers Table Section Header View", @"Use a custom view over the list of providers section of the table", @"ll",
                    @"Providers Table Section Footer View", @"Use a custom view over the list of providers section of the table", @"ll",
                    @"Providers Table Section Header Title String", @"Use a custom view over the list of providers section of the table", @"ll",
                    @"Providers Table Section Footer Title String", @"Use a custom view over the list of providers section of the table", @"ll",nil];

    [self.tableView setSeparatorColor:[UIColor darkGrayColor]];
    [self.tableView setAllowsSelection:NO];

//    [self.view setAllowsSelection:NO];

    [self setToolbarItems:
        [NSArray arrayWithObjects:
         [[[UIBarButtonItem alloc] initWithTitle:@"Reset" style:UIBarButtonItemStyleBordered target:self action:@selector(reset:)] autorelease],
         [[[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(next:)] autorelease],
         [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease], nil]];
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

typedef enum
{
    CIAuthenticationBackgroundColor = 0,
    CIAuthenticationBackgroundImageView,
    CIProviderTableTitleView,
    CIProviderTableTitleString,
    CIProviderTableHeaderView,
    CIProviderTableFooterView,
    CIProviderTableSectionHeaderView,
    CIProviderTableSectionFooterView,
    CIProviderTableSectionHeaderTitleString,
    CIProviderTableSectionFooterTitleString,
} CellIndex;

#define CELL_TAG_OFFSET 100

- (void)setPreviewForCell:(TestConfigurationTableViewCell*)cell atIndex:(CellIndex)cellIndex
{
    switch (cellIndex)
    {
        case CIAuthenticationBackgroundColor:
            [cell.cellPreview setImage:[UIImage imageNamed:@"enabledCyan"] forState:UIControlStateNormal];
            break;
        case CIAuthenticationBackgroundImageView:
            [cell.cellPreview setImage:[UIImage imageNamed:@"enabledWeave"] forState:UIControlStateNormal];
            break;
        case CIProviderTableTitleView:
            [cell.cellPreview setTitle:@"Custom Title View" forState:UIControlStateNormal];
            [cell.cellPreview.titleLabel setBackgroundColor:[UIColor magentaColor]];
            [cell.cellPreview.titleLabel setFont:[UIFont fontWithName:@"MarkerFelt-Wide" size:12.0]];
            break;
        case CIProviderTableTitleString:
            [cell.cellPreview setTitle:@"Custom Title String" forState:UIControlStateNormal];
            break;
        case CIProviderTableHeaderView:
            [cell.cellPreview setTitle:@"Custom Table Header View" forState:UIControlStateNormal];
            [cell.cellPreview.titleLabel setBackgroundColor:[UIColor yellowColor]];
            [cell.cellPreview.titleLabel setFont:[UIFont fontWithName:@"MarkerFelt-Wide" size:12.0]];
            [cell.cellPreview setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            break;
        case CIProviderTableFooterView:
            [cell.cellPreview setTitle:@"Custom Table Footer View" forState:UIControlStateNormal];
            [cell.cellPreview.titleLabel setBackgroundColor:[UIColor greenColor]];
            [cell.cellPreview.titleLabel setFont:[UIFont fontWithName:@"MarkerFelt-Wide" size:12.0]];
            [cell.cellPreview setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
            break;
        case CIProviderTableSectionHeaderView:
            [cell.cellPreview setTitle:@"Custom Section Header View" forState:UIControlStateNormal];
            [cell.cellPreview.titleLabel setBackgroundColor:[UIColor purpleColor]];
            [cell.cellPreview.titleLabel setFont:[UIFont fontWithName:@"MarkerFelt-Wide" size:12.0]];
            break;
        case CIProviderTableSectionFooterView:
            [cell.cellPreview setTitle:@"Custom Section Footer View" forState:UIControlStateNormal];
            [cell.cellPreview.titleLabel setBackgroundColor:[UIColor blueColor]];
            [cell.cellPreview.titleLabel setFont:[UIFont fontWithName:@"MarkerFelt-Wide" size:12.0]];
            break;
        case CIProviderTableSectionHeaderTitleString:
            [cell.cellPreview setTitle:@"Custom Section Header String" forState:UIControlStateNormal];
            break;
        case CIProviderTableSectionFooterTitleString:
            [cell.cellPreview setTitle:@"Custom Section Footer String" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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

    if ([cellSize isEqualToString:@"ss"])
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
    }

    cell.cellTitle.text = [cellTitles objectAtIndex:(indexPath.row * 3)];
    cell.cellSubtitle.text = [cellTitles objectAtIndex:((indexPath.row * 3) + 1)];

    cell.tag = CELL_TAG_OFFSET + indexPath.row;

    [self setPreviewForCell:cell atIndex:(CellIndex)indexPath.row];

    return cell;
}

- (void)reset:(id)sender {}

- (void)next:(id)sender
{
    [config resetCustomInterface];

    for (int i = 0; i < [cellTitles count]/2; i++)
    {
        TestConfigurationTableViewCell *cell =
            (TestConfigurationTableViewCell*)
                    [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];

        switch ((CellIndex)i)
        {
            case CIAuthenticationBackgroundColor:
                if (cell.cellSwitch.on) [config setAuthenticationBackgroundColor:YES];
                else  [config setAuthenticationBackgroundColor:NO];
                break;
            case CIAuthenticationBackgroundImageView:
                if (cell.cellSwitch.on) [config setAuthenticationBackgroundImageView:YES];
                else  [config setAuthenticationBackgroundImageView:NO];
                break;
            case CIProviderTableTitleView:
                if (cell.cellSwitch.on) [config setProviderTableTitleView:YES];
                else  [config setProviderTableTitleView:NO];
                break;
            case CIProviderTableTitleString:
                if (cell.cellSwitch.on) [config setProviderTableTitleString:YES];
                else  [config setProviderTableTitleString:NO];
                break;
            case CIProviderTableHeaderView:
                if (cell.cellSwitch.on) [config setProviderTableHeaderView:YES];
                else  [config setProviderTableHeaderView:NO];
                break;
            case CIProviderTableFooterView:
                if (cell.cellSwitch.on) [config setProviderTableFooterView:YES];
                else  [config setProviderTableFooterView:NO];
                break;
            case CIProviderTableSectionHeaderView:
                if (cell.cellSwitch.on) [config setProviderTableSectionHeaderView:YES];
                else  [config setProviderTableSectionHeaderView:NO];
                break;
            case CIProviderTableSectionFooterView:
                if (cell.cellSwitch.on) [config setProviderTableSectionFooterView:YES];
                else  [config setProviderTableSectionFooterView:NO];
                break;
            case CIProviderTableSectionHeaderTitleString:
                if (cell.cellSwitch.on) [config setProviderTableSectionHeaderTitleString:YES];
                else  [config setProviderTableSectionHeaderTitleString:NO];
                break;
            case CIProviderTableSectionFooterTitleString:
                if (cell.cellSwitch.on) [config setProviderTableSectionFooterTitleString:YES];
                else  [config setProviderTableSectionFooterTitleString:NO];
                break;
            default:
                break;
        }
    }

    StartTestViewController *startTestViewController =
        [[[StartTestViewController alloc] initWithNibName:@"StartTestViewController" bundle:nil] autorelease];
    [self.navigationController pushViewController:startTestViewController animated:YES];
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
    [super dealloc];
}


@end

