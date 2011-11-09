//
//  SharingActivityChangesViewController.m
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

#import <UIKit/UIKit.h>
#import "SharingActivityChangesViewController.h"

@interface NSString (EXPAND_IF_PAD)
- (NSString *)expandIfPad:(BOOL)isPad;
@end

@implementation NSString (EXPAND_IF_PAD)
- (NSString *)expandIfPad:(BOOL)isPad
{
    if (!isPad)
        return self;

    return [[[self stringByReplacingOccurrencesOfString:@"EMPT" withString:@"EMPTY"]
                       stringByReplacingOccurrencesOfString:@"LN" withString:@"LINE"]
                           stringByReplacingOccurrencesOfString:@"DESCR" withString:@"DESCRIPTION"];
}

@end


@interface PickerActivity : NSObject
{
    NSString *pickerTitle;
    NSString *activityTitle;
    NSString *activityDescription;
}
@property (readonly) NSString *pickerTitle;
@property (readonly) NSString *activityTitle;
@property (readonly) NSString *activityDescription;
- (id)initWithPickerTitle:(NSString*)newPickerTitle activityTitle:(NSString*)newActivityTitle
   andActivityDescription:(NSString*)newActivityDescription;
+ (id)pickerActivityWithPickerTitle:(NSString*)newPickerTitle activityTitle:(NSString*)newActivityTitle
             andActivityDescription:(NSString*)newActivityDescription;
@end

@implementation PickerActivity
@synthesize pickerTitle;
@synthesize activityTitle;
@synthesize activityDescription;

- (id)initWithPickerTitle:(NSString*)newPickerTitle activityTitle:(NSString*)newActivityTitle
   andActivityDescription:(NSString*)newActivityDescription
{
    if (newPickerTitle == nil)
    {
        [self release];
        return nil;
    }

    if ((self = [super init]))
    {
        pickerTitle         = [newPickerTitle copy];
        activityTitle       = [newActivityTitle copy];
        activityDescription = [newActivityDescription copy];
    }

    return self;
}

+ (id)pickerActivityWithPickerTitle:(NSString*)newPickerTitle activityTitle:(NSString*)newActivityTitle
             andActivityDescription:(NSString*)newActivityDescription
{
    return [[[PickerActivity alloc] initWithPickerTitle:newPickerTitle activityTitle:newActivityTitle
                                 andActivityDescription:newActivityDescription] autorelease];
}

- (void)dealloc
{
    [pickerTitle release];
    [activityTitle release];
    [activityDescription release];

    [super dealloc];
}
@end

@interface SharingActivityChangesViewController ()
- (void)buildActivityArray;
@end


@implementation SharingActivityChangesViewController
@synthesize picker;
@synthesize table;
@synthesize thinDivider;
@synthesize sliderDivider;
@synthesize sliderButton;
#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    config = [ConfigurationData sharedConfigurationData];

    [self buildActivityArray];

    cellTitles = [[NSArray alloc] initWithObjects:
                  @"Url", @"Add a url to the activity",
                  @"Image", @"Add an image to the activity",
                  @"Song",  @"Add a song to the activity",
                  @"Video", @"Add a video to the activity",
                  @"Action Link", @"Add an action link to the activity",
                  @"Properties Dictionary", @"Add a properties dictionary to the activity", nil];

    cellSwitchStates            = [[NSMutableArray alloc] initWithCapacity:([cellTitles count] / 2)];
    cellPreviewTextFieldNumbers = [[NSMutableArray alloc] initWithCapacity:([cellTitles count] / 2)];

    for (NSUInteger i = 0; i < ([cellTitles count] / 2); i++)
        [cellSwitchStates insertObject:[NSNumber numberWithBool:NO] atIndex:i];

    for (NSUInteger i = 0; i < ([cellTitles count] / 2); i++)
        [cellPreviewTextFieldNumbers insertObject:[NSNumber numberWithInt:1] atIndex:i];

    [table setSeparatorColor:[UIColor darkGrayColor]];
    [table setAllowsSelection:NO];

    if (config.iPad)
    {
        [self.view setFrame:CGRectMake(0, 0, 768, 1004)];
        [table setFrame:CGRectMake(0, 0, 768, 452)];
        [thinDivider setFrame:CGRectMake(0, 452, 768, 14)];
        [picker setFrame:CGRectMake(0, 466, 768, 216)];

        [sliderButton setHidden:YES];
        [sliderDivider setHidden:YES];
    }
    else
    {
        [picker setFrame:CGRectMake(0, 402, 320, 162)];
    }

    self.navigationItem.rightBarButtonItem =
            [[[UIBarButtonItem alloc] initWithTitle:@"Next"
                                              style:UIBarButtonItemStyleDone
                                             target:self
                                             action:@selector(next:)] autorelease];

//
//    [self setToolbarItems:
//     [NSArray arrayWithObjects:
//      [[[UIBarButtonItem alloc] initWithTitle:@"Reset" style:UIBarButtonItemStyleBordered
//                                       target:self action:@selector(reset:)] autorelease],
//      [[[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered
//                                       target:self action:@selector(next:)] autorelease],
//      [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
//                                                     target:nil action:nil] autorelease], nil]];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/

- (void)viewDidAppear:(BOOL)animated
{
    [self resignFirstResponder];
    [super viewDidAppear:animated];
}

typedef enum
{
    CIAddUrl = 0,
    CIAddImage,
    CIAddSong,
    CIAddVideo,
    CIAddActionLink,
    CIAddProperties,
} CellIndex;

#pragma mark -
#pragma mark Toolbar button selectors

//- (void)reset:(id)sender {}

- (void)next:(id)sender
{
    [config resetSignIn];
    [config resetActivity];
    [config resetCustomInterface];

    for (NSUInteger i = 0; i < [cellSwitchStates count]; i++)
    {
        BOOL      switchState   = [((NSNumber*)[cellSwitchStates objectAtIndex:i]) boolValue];
        NSInteger numberOfThose = [((NSNumber*)[cellPreviewTextFieldNumbers objectAtIndex:i]) integerValue];

        switch ((CellIndex)i)
        {
            case CIAddUrl:
                if (switchState == YES) [config setActivityAddDefaultUrl:YES];
                else [config setActivityAddDefaultUrl:NO];
                break;
            case CIAddImage:
                if (switchState == YES) [config setActivityAddDefaultImage:YES];
                else [config setActivityAddDefaultImage:NO];
                [config setNumberOfDefaultImages:numberOfThose];
                break;
            case CIAddSong:
                if (switchState == YES) [config setActivityAddDefaultSong:YES];
                else [config setActivityAddDefaultSong:NO];
                [config setNumberOfDefaultSongs:numberOfThose];
                break;
            case CIAddVideo:
                if (switchState == YES) [config setActivityAddDefaultVideo:YES];
                else [config setActivityAddDefaultVideo:NO];
                [config setNumberOfDefaultVideos:numberOfThose];
                break;
            case CIAddActionLink:
                if (switchState == YES) [config setActivityAddDefaultActionLinks:YES];
                else [config setActivityAddDefaultActionLinks:NO];
                [config setNumberOfDefaultActionLinks:numberOfThose];
                break;
            case CIAddProperties:
                if (switchState == YES) [config setActivityAddDefaultProperties:YES];
                else [config setActivityAddDefaultProperties:NO];
                break;
            default:
                break;
        }
    }

    if ([picker selectedRowInComponent:0] != -1)
    {
        PickerActivity *pickerActivity =
                [activityArray objectAtIndex:(NSUInteger)[picker selectedRowInComponent:0]];

        [config setActivityAction:pickerActivity.pickerTitle];
        [config setActivityTitle:pickerActivity.activityTitle];
        [config setActivityDescription:pickerActivity.activityDescription];
    }
    else
    {
        [config setActivityAction:@"Nothing was selected"];
    }

    StartTestViewController *startTestViewController =
            [[[StartTestViewController alloc] initWithNibName:@"StartTestViewController" bundle:nil] autorelease];
                [self.navigationController pushViewController:startTestViewController animated:YES];
}

#pragma mark -
#pragma mark Picker set-up methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView { return 1; }

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [activityArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [((PickerActivity*)[activityArray objectAtIndex:(NSUInteger)row]) pickerTitle];
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
    @"EMPT DESCR",
    @"1 LN DESCR",
    @"2 LN DESCR",
    @"3 LN DESCR",
    @"4 LN DESCR",
    @"5 LN DESCR",
    @"6 LN DESCR",
    nil };

- (void)buildActivityArray
{
    activityArray = [[NSMutableArray alloc] initWithCapacity:NUM_PICKER_ACTIVITIES];

    for (NSUInteger i = 0; i < NUM_PICKER_ACTIVITIES; i++)
    {
        NSUInteger titleIndex = i % NUM_TITLES;
        NSUInteger descrIndex = (i/NUM_DESCRIPTIONS - (NUM_DESCRIPTIONS * (i / NUM_PICKER_ACTIVITIES)));

//        NSString *activityTitle = [title_bits[titleIndex] expandIfPad:config.iPad];
//        NSString *activityDescr = [descr_bits[descrIndex] expandIfPad:config.iPad];

//        NSMutableString *pickerTitle =
//                [NSMutableString stringWithString:[title_bits[titleIndex] expandIfPad:config.iPad]];
//        [pickerTitle appendString:[descr_bits[descrIndex] expandIfPad:config.iPad]];

        NSString *pickerTitle = [NSString stringWithFormat:@"%@ %@",
                    [title_bits[titleIndex] expandIfPad:config.iPad],
                    [descr_bits[descrIndex] expandIfPad:config.iPad]];

        [activityArray addObject:
                    [PickerActivity pickerActivityWithPickerTitle:pickerTitle
                                                    activityTitle:[titles[titleIndex] expandIfPad:config.iPad]
                                           andActivityDescription:[descrs[descrIndex] expandIfPad:config.iPad]]];
    }
}

#pragma mark -
#pragma mark Slider control

- (void)slidePickerUp
{
    [UIView beginAnimations:@"slider_up" context:nil];
//  [UIView setAnimationDuration:2000];

    [table setFrame:CGRectMake(0, 0, 320, 196)];
    [thinDivider setFrame:CGRectMake(0, 196, 320, 14)];
    [sliderDivider setFrame:CGRectMake(0, 210, 320, 44)];
    [sliderButton setFrame:CGRectMake(0, 210, 320, 44)];
    [picker setFrame:CGRectMake(0, 254, 320, 162)];

    [UIView commitAnimations];

    [sliderButton setTitle:@"Click to Hide Selector" forState:UIControlStateNormal];
}

- (void)slidePickerDown
{
    [UIView beginAnimations:@"slider_up" context:nil];
//  [UIView setAnimationDuration:2000];

    [table setFrame:CGRectMake(0, 0, 320, 344)];
    [thinDivider setFrame:CGRectMake(0, 344, 320, 14)];
    [sliderDivider setFrame:CGRectMake(0, 358, 320, 44)];
    [sliderButton setFrame:CGRectMake(0, 358, 320, 44)];
    [picker setFrame:CGRectMake(0, 402, 320, 100)];

    [UIView commitAnimations];

    [sliderButton setTitle:@"Click for Title and Description Selector" forState:UIControlStateNormal];
}

- (IBAction)sliderButtonPressed:(id)sender
{
    if (sliderUp)
        [self slidePickerDown];
    else
        [self slidePickerUp];

    sliderUp = !sliderUp;
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
    return [cellTitles count] / 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

#define CELL_TAG_OFFSET 100

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    DLog(@"");

    TestConfigurationTableViewCell *cell =
            (TestConfigurationTableViewCell*)
                    [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell_%d", indexPath.row]];

    if (cell == nil)
    {
        cell = [[[TestConfigurationTableViewCell alloc]
                 initTestConfigurationTableViewCellWithStyle:TCTableViewCellStyleSwitch
                                             reuseIdentifier:[NSString stringWithFormat:@"cell_%d", indexPath.row]]
                autorelease];

        cell.previewStyle = TCTableViewCellPreviewStyleSquare;

        if (indexPath.row >= CIAddImage && indexPath.row <= CIAddActionLink)
        {
            UITextField *cellPreviewTextField = [[[UITextField alloc] initWithFrame:CGRectMake(0, 0, 27, 27)] autorelease];

            [cellPreviewTextField setBorderStyle:UITextBorderStyleBezel];
            [cellPreviewTextField setKeyboardType:UIKeyboardTypePhonePad];
            [cellPreviewTextField setReturnKeyType:UIReturnKeyDone];
            [cellPreviewTextField setClearsOnBeginEditing:YES];
            [cellPreviewTextField setFont:[UIFont systemFontOfSize:14.0]];

            [cellPreviewTextField addTarget:cell
                                     action:@selector(previewChanged:)
                           forControlEvents:UIControlEventEditingChanged | UIControlEventEditingDidEnd |
                                                    UIControlEventEditingDidEndOnExit];

            [cell.cellPreview addSubview:cellPreviewTextField];
        }

        cell.cellBorder.hidden = YES;
        cell.delegate          = self;
    }

    UITextField *cellPreviewTextField = ([[cell.cellPreview subviews] count]) ?
            [[cell.cellPreview subviews] objectAtIndex:0] : nil;

    cell.cellTitle.text       = [cellTitles objectAtIndex:(indexPath.row * 2)];
    cell.cellSubtitle.text    = [cellTitles objectAtIndex:((indexPath.row * 2) + 1)];
    cellPreviewTextField.text =
            [NSString stringWithFormat:@"%d",
                    [((NSNumber*)[cellPreviewTextFieldNumbers objectAtIndex:indexPath.row]) integerValue]];

    cell.tag = CELL_TAG_OFFSET + indexPath.row;

    return cell;
}

- (void)testConfigurationTableViewCell:(TestConfigurationTableViewCell*)cell switchDidChange:(UISwitch*)cellSwitch
{
    NSInteger cellIndex = cell.tag - CELL_TAG_OFFSET;

    if (cellIndex < [cellSwitchStates count])
        [cellSwitchStates replaceObjectAtIndex:(NSUInteger)cellIndex withObject:[NSNumber numberWithBool:cellSwitch.on]];
}

- (void)testConfigurationTableViewCell:(TestConfigurationTableViewCell*)cell previewDidChange:(UIView*)cellPreview
{
    NSInteger cellIndex = cell.tag - CELL_TAG_OFFSET;

    UITextField *cellPreviewTextField = ((UITextField *)[[cellPreview subviews] objectAtIndex:0]);

    [cellPreviewTextField removeTarget:cell
                             action:@selector(previewChanged:)
                   forControlEvents:UIControlEventEditingChanged];

    NSString *startText = cellPreviewTextField.text;

    if (!startText || [startText isEqualToString:@""])
        startText = @"1";

    NSString *lastCharacter = [startText substringFromIndex:([startText length] - 1)];

    if ([lastCharacter rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location == NSNotFound)
        lastCharacter = [startText substringToIndex:1];

    NSInteger number = [lastCharacter integerValue];

    if (cellIndex < [cellPreviewTextFieldNumbers count])
        [cellPreviewTextFieldNumbers replaceObjectAtIndex:(NSUInteger)cellIndex withObject:[NSNumber numberWithInteger:number]];

    cellPreviewTextField.text = lastCharacter;

    [cellPreviewTextField addTarget:cell
                             action:@selector(previewChanged:)
                   forControlEvents:UIControlEventEditingChanged];

//    DLog(@"text field text: %@", lastCharacter);
}

#pragma mark -
#pragma mark Memory management

- (void)viewWillDisappear:(BOOL)animated
{
    for (NSUInteger i = CIAddImage; i <= CIAddActionLink; i++)
        [[[((TestConfigurationTableViewCell*)
            [table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]])
                .cellPreview subviews] objectAtIndex:0] resignFirstResponder];

    [super viewWillDisappear:animated];
}

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
    [cellSwitchStates release];
    [activityArray release];

    [picker release];
    [table release];
    [thinDivider release];
    [sliderDivider release];
    [sliderButton release];

    [cellPreviewTextFieldNumbers release];
    [super dealloc];
}


@end

