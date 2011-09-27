//
//  SharingActivityChangesViewController.m
//  ApiTester
//
//  Created by lilli on 9/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SharingActivityChangesViewController.h"

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);


@interface PickerActivity : NSObject
{
    NSString *pickerTitle;
    JRActivityObject *activity;
}
@property (retain) NSString *pickerTitle;
@property (retain) JRActivityObject *activity;
- (id)initWithPickerTitle:(NSString*)newPickerTitle andActivity:(JRActivityObject*)newActivity;
+ (id)pickerActivityWithPickerTitle:(NSString*)newPickerTitle andActivity:(JRActivityObject*)newActivity;
@end

@implementation PickerActivity
@synthesize pickerTitle;
@synthesize activity;

- (id)initWithPickerTitle:(NSString*)newPickerTitle andActivity:(JRActivityObject*)newActivity
{
    if (newPickerTitle == nil || newActivity == nil)
    {
        [self release];
        return nil;
    }
    
    if (self = [super init]) 
    {
        pickerTitle = [newPickerTitle retain];
        activity = [newActivity retain];
    }
    return self;    
}

+ (id)pickerActivityWithPickerTitle:(NSString*)newPickerTitle andActivity:(JRActivityObject*)newActivity
{
    return [[[PickerActivity alloc] initWithPickerTitle:newPickerTitle andActivity:newActivity] autorelease];
}

- (void)dealloc
{
    [pickerTitle release];
    [activity release];
    
    [super dealloc];
}
@end

@interface SharingActivityChangesViewController ()
- (void)buildActivityArray;
@end


@implementation SharingActivityChangesViewController
@synthesize picker;
@synthesize table;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    cellTitles = [[NSArray alloc] initWithObjects:
                  @"Url", @"Add a url to the activity",
                  @"Image", @"Add an image url to the activity",
                  @"Song",  @"Add a song url to the activity",
                  @"Video", @"Add a video url to the activity", nil];
    
    [table setSeparatorColor:[UIColor darkGrayColor]];
    [table setAllowsSelection:NO];    

    [self buildActivityArray];
    
    [self setToolbarItems:
     [NSArray arrayWithObjects:
      [[[UIBarButtonItem alloc] initWithTitle:@"Reset" style:UIBarButtonItemStyleBordered target:self action:@selector(reset:)] autorelease],
      [[[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(next:)] autorelease],
      [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease], nil]];
}

typedef enum
{
    CIAddImage = 0,
    CIAddSong,
    CIAddVideo,
} CellIndex;


- (void)reset:(id)sender {}

- (void)next:(id)sender 
{
    for (int i = 0; i < [cellTitles count]/2; i++)
    {
        TestConfigurationTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        
        if (cell.cellSwitch.on == YES)
        {
            switch ((CellIndex)i)
            {
                case CIAddImage:
                    if (cell.cellSwitch.on) [config setAuthenticationBackgroundColor:YES];
                    else  [config setAuthenticationBackgroundColor:YES];
                    break;
                case CIAddSong:
                    if (cell.cellSwitch.on) [config setAuthenticationBackgroundImageView:YES];
                    else  [config setAuthenticationBackgroundImageView:YES];
                    break;
                case CIAddFlash:
                    if (cell.cellSwitch.on) [config setProviderTableTitleView:YES];
                    else  [config setProviderTableTitleView:YES];
                    break;
                case CIProviderTableTitleString:
                    if (cell.cellSwitch.on) [config setProviderTableTitleString:YES];
                    else  [config setProviderTableTitleString:YES];
                    break;
                case CIProviderTableHeaderView:
                    if (cell.cellSwitch.on) [config setProviderTableHeaderView:YES];
                    else  [config setProviderTableHeaderView:YES];
                    break;
                case CIProviderTableFooterView:
                    if (cell.cellSwitch.on) [config setProviderTableFooterView:YES];
                    else  [config setProviderTableFooterView:YES];
                    break;
                case CIProviderTableSectionHeaderView:
                    if (cell.cellSwitch.on) [config setProviderTableSectionHeaderView:YES];
                    else  [config setProviderTableSectionHeaderView:YES];
                    break;
                case CIProviderTableSectionFooterView:
                    if (cell.cellSwitch.on) [config setProviderTableSectionFooterView:YES];
                    else  [config setProviderTableSectionFooterView:YES];
                    break;
                case CIProviderTableSectionHeaderTitleString:
                    if (cell.cellSwitch.on) [config setProviderTableSectionHeaderTitleString:YES];
                    else  [config setProviderTableSectionHeaderTitleString:YES];
                    break;
                case CIProviderTableSectionFooterTitleString:
                    if (cell.cellSwitch.on) [config setProviderTableSectionFooterTitleString:YES];
                    else  [config setProviderTableSectionFooterTitleString:YES];
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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [activityArray count];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    selectedActivity = row;
//    [jrEngage showSocialPublishingDialogWithActivity:[((PickerActivity*)[activityArray objectAtIndex:row]) activity]];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [((PickerActivity*)[activityArray objectAtIndex:row]) pickerTitle];
}

#define NUM_PICKER_ACTIVITIES 49//98
#define NUM_TITLES 7
#define NUM_DESCRIPTIONS 7

static NSString * const titles[NUM_TITLES + 1] = { 
    @"",
    @"one line one line",
    @"two lines two lines two lines two lines two lines two lines",
    @"three lines three lines three lines three lines three lines three lines three lines three lines three lines",
    @"four lines four lines four lines four lines four lines four lines four lines four lines four lines four lines four lines four lines four lines four lines",
    @"five lines five lines five lines five lines five lines five lines five lines five lines five lines five lines five lines five lines five lines five lines five lines five lines five lines five lines five lines five lines",
    @"six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines",
    nil };

static NSString * const descrs[NUM_DESCRIPTIONS + 1] = { 
    @"",
    @"one line one line",
    @"two lines two lines two lines two lines two lines two lines two lines",
    @"three lines three lines three lines three lines three lines three lines three lines three lines three lines three lines",
    @"four lines four lines four lines four lines four lines four lines four lines four lines four lines four lines four lines four lines four lines four lines four lines four lines",
    @"five lines five lines five lines five lines five lines five lines five lines five lines five lines five lines five lines five lines five lines five lines five lines five lines five lines five lines five lines five lines five lines",
    @"six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines six lines",
    nil };

static NSString * const title_bits[NUM_TITLES + 1] = {
    @"EMPT TITLE",
    @"1 LN TITLE",
    @"2 LN TITLE",
    @"3 LN TITLE",
    @"4 LN TITLE",
    @"5 LN TITLE",
    @"6 LN TITLE",
    nil };

static NSString * const descr_bits[NUM_DESCRIPTIONS + 1] = {
    @" EMPT DESCR",
    @" 1 LN DESCR",
    @" 2 LN DESCR",
    @" 3 LN DESCR",
    @" 4 LN DESCR",
    @" 5 LN DESCR",
    @" 6 LN DESCR",
    nil };

- (void)buildActivityArray
{
    activityArray = [[NSMutableArray alloc] initWithCapacity:42];
    JRImageMediaObject *image = [[JRImageMediaObject alloc] initWithSrc:@"http://media.npr.org/assets/news/2010/09/28/somalia16_wide.jpg?t=1285704766&s=4"
                                                                andHref:@"http://www.npr.org/templates/story/story.php?storyId=130273801&sc=17&f=1001"];
    
    for (int i = 0; i < NUM_PICKER_ACTIVITIES; i++)
    {
        NSMutableString *pickerTitle = [NSMutableString stringWithString:title_bits[i%NUM_TITLES]];
        [pickerTitle appendString:descr_bits[(i/NUM_DESCRIPTIONS - (NUM_DESCRIPTIONS * (i / (NUM_PICKER_ACTIVITIES/2))))]];
        
        if (i >= NUM_PICKER_ACTIVITIES/2)
            [pickerTitle appendString:@" W MEDIA"];
        
        JRActivityObject *activity = [[JRActivityObject alloc] 
                                      initWithAction:pickerTitle];
        //andUrl:@"http://www.google.com"];
        
        activity.title = titles[i%NUM_TITLES];
        activity.description = descrs[(i/NUM_DESCRIPTIONS - (NUM_DESCRIPTIONS * (i / (NUM_PICKER_ACTIVITIES/2))))];
        
        if (i >= NUM_PICKER_ACTIVITIES/2)
            activity.media = [NSArray arrayWithObjects:image, nil];
        
        [activityArray addObject:[PickerActivity pickerActivityWithPickerTitle:pickerTitle andActivity:activity]];
    }
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    DLog(@"");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    DLog(@"");
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    DLog(@"");
    
    TestConfigurationTableViewCell *cell = 
    (TestConfigurationTableViewCell*)[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"TestConfigurationTableViewCell_%d", indexPath.row]];
    
    if (cell == nil) 
    {
        cell = [[[TestConfigurationTableViewCell alloc] 
                 initTestConfigurationTableViewCellWithStyle:TCTableViewCellStyleSwitch 
                 reuseIdentifier:[NSString stringWithFormat:@"TestConfigurationTableViewCell_%d", indexPath.row]]
                autorelease];
    }
    
    cell.cellTitle.text = [cellTitles objectAtIndex:(indexPath.row * 2)];
    cell.cellSubtitle.text = [cellTitles objectAtIndex:((indexPath.row * 2) + 1)];
        
    cell.previewStyle = TCTableViewCellPreviewStyleSquare;
//    [self setPreviewForCell:cell atIndex:(CellIndex)indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
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
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"Nib name" bundle:nil];
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

