//
//  SharingActivityWithBadParamsViewController.m
//  ApiTester
//
//  Created by lilli on 10/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DLog(...)
#endif

#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#import "SharingActivityWithBadParamsViewController.h"

@implementation SharingActivityWithBadParamsViewController
@synthesize scrollView;
@synthesize contentView;
@synthesize keyboardToolbar;

#pragma mark -
#pragma mark View lifecycle


typedef enum
{
    TFIActivityAction = 100,
    TFIActivityUrl,
    TFIActivityTitle,
    TFIActivityDescription,
    TFIActivityImageSrc,
    TFIActivityImageHref,
    TFIActivitySongSrc,
    TFIActivitySongTitle,
    TFIActivitySongArtist,
    TFIActivitySongAlbum,
    TFIActivityVideoSwfsrc,
    TFIActivityVideoImgsrc,
    TFIActivityVideoWidth,
    TFIActivityVideoHeight,
    TFIActivityVideoExpandedWidth,
    TFIActivityVideoExpandedHeight,
} TextFieldIndex;

#define NUM_TEXT_FIELDS 16

- (void)viewDidLoad
{
    [super viewDidLoad];

    config = [ConfigurationData sharedConfigurationData];

    [scrollView addSubview:contentView];
    [scrollView setContentSize:CGSizeMake(320, contentView.frame.size.height)];

    for (int i = 100; i < NUM_TEXT_FIELDS + 100; i++)
    {
        UITextField *textField = ((UITextField*)[contentView viewWithTag:i]);
        textField.delegate = self;
        textField.inputAccessoryView = keyboardToolbar;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }

    [self setToolbarItems:
     [NSArray arrayWithObjects:
      [[[UIBarButtonItem alloc] initWithTitle:@"Reset" style:UIBarButtonItemStyleBordered target:self action:@selector(reset:)] autorelease],
      [[[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(next:)] autorelease],
      [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease], nil]];
}

- (void)reset:(id)sender {}

- (void)next:(id)sender
{
    [config resetSignIn];
    [config resetActivity];
    [config resetCustomInterface];

    BOOL hasAnyImageFields = NO;
    BOOL hasAnySongFields = NO;
    BOOL hasAnyVideoFields = NO;

    for (int i = 100; i < NUM_TEXT_FIELDS + 100; i++)
    {
        UITextField *textField = ((UITextField*)[contentView viewWithTag:i]);

        switch ((TextFieldIndex)i)
        {
            case TFIActivityAction:
                if (textField.text && ![textField.text isEqualToString:@""])
                    [config setActivityAction:textField.text];
            	break;

            case TFIActivityUrl:
                if (textField.text && ![textField.text isEqualToString:@""])
                    [config setActivityUrl:textField.text];
            	break;

            case TFIActivityTitle:
                if (textField.text && ![textField.text isEqualToString:@""])
                    [config setActivityTitle:textField.text];
            	break;

            case TFIActivityDescription:
                if (textField.text && ![textField.text isEqualToString:@""])
                    [config setActivityDescription:textField.text];
            	break;

            case TFIActivityImageSrc:
            case TFIActivityImageHref:
                if (textField.text && ![textField.text isEqualToString:@""])
                    hasAnyImageFields = YES;
            	break;

            case TFIActivitySongSrc:
            case TFIActivitySongTitle:
            case TFIActivitySongArtist:
            case TFIActivitySongAlbum:
                if (textField.text && ![textField.text isEqualToString:@""])
                    hasAnySongFields = YES;
            	break;

            case TFIActivityVideoSwfsrc:
            case TFIActivityVideoImgsrc:
            case TFIActivityVideoWidth:
            case TFIActivityVideoHeight:
            case TFIActivityVideoExpandedWidth:
            case TFIActivityVideoExpandedHeight:
                if (textField.text && ![textField.text isEqualToString:@""])
                    hasAnyVideoFields = YES;
            	break;
            default:
                break;
        }
    }

    if (hasAnyImageFields)
    {
        [config addActivityImageWithSrc:((UITextField*)[contentView viewWithTag:TFIActivityImageSrc]).text
                                andHref:((UITextField*)[contentView viewWithTag:TFIActivityImageHref]).text];
    }

    if (hasAnySongFields)
    {
        [config addActivitySongWithSrc:((UITextField*)[contentView viewWithTag:TFIActivitySongSrc]).text
                                 title:((UITextField*)[contentView viewWithTag:TFIActivitySongTitle]).text
                                artist:((UITextField*)[contentView viewWithTag:TFIActivitySongArtist]).text
                              andAlbum:((UITextField*)[contentView viewWithTag:TFIActivitySongTitle]).text];
    }

    if (hasAnyVideoFields)
    {
        [config addActivityVideoWithSwfsrc:((UITextField*)[contentView viewWithTag:TFIActivityImageSrc]).text
                                    imgsrc:((UITextField*)[contentView viewWithTag:TFIActivityImageSrc]).text
                                     width:[[NSNumber numberWithInteger:[((UITextField*)[contentView viewWithTag:TFIActivityImageSrc]).text integerValue]] unsignedIntValue]
                                    height:[[NSNumber numberWithInteger:[((UITextField*)[contentView viewWithTag:TFIActivityImageSrc]).text integerValue]] unsignedIntValue]
                             expandedWidth:[[NSNumber numberWithInteger:[((UITextField*)[contentView viewWithTag:TFIActivityImageSrc]).text integerValue]] unsignedIntValue]
                         andExpandedHeight:[[NSNumber numberWithInteger:[((UITextField*)[contentView viewWithTag:TFIActivityImageSrc]).text integerValue]] unsignedIntValue]];
    }

    StartTestViewController *startTestViewController =
            [[[StartTestViewController alloc] initWithNibName:@"StartTestViewController" bundle:nil] autorelease];
                [self.navigationController pushViewController:startTestViewController animated:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (!currentResponder)
    {
        [scrollView setFrame:CGRectMake(0, 0, 320, 156)];
        [contentView setFrame:CGRectMake(0, 0, 320, 1420)];
        [scrollView setContentSize:contentView.frame.size];
    }

    currentResponder = textField;

    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    CGRect visibleRect = CGRectMake(0, textField.frame.origin.y - 30,
//                                    scrollView.frame.size.width, scrollView.frame.size.height);
//
//    [scrollView scrollRectToVisible:visibleRect animated:YES];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (currentResponder == textField)
    {
        currentResponder = nil;

        [scrollView setFrame:CGRectMake(0, 0, 320, 372)];
        [contentView setFrame:CGRectMake(0, 0, 320, 1120)];
        [scrollView setContentSize:contentView.frame.size];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    textField.text = nil;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    UIResponder* nextResponder = [contentView viewWithTag:(textField.tag + 1)];

    if (nextResponder)
        [nextResponder becomeFirstResponder];
    else
        [textField resignFirstResponder];

    return YES;
}

- (void)goToPrevResponder
{
    UIResponder* nextResponder = [contentView viewWithTag:(currentResponder.tag - 1)];
    if (nextResponder)
        [nextResponder becomeFirstResponder];
    else
        [currentResponder resignFirstResponder];
}

- (void)goToNextResponder
{
    UIResponder* nextResponder = [contentView viewWithTag:(currentResponder.tag + 1)];

    if (nextResponder)
        [nextResponder becomeFirstResponder];
    else
        [currentResponder resignFirstResponder];
}

- (IBAction)prevNextSegButtonPressed:(id)sender
{
    UISegmentedControl *seg = (UISegmentedControl*)sender;

    if (seg.selectedSegmentIndex == 0)
        [self goToPrevResponder];
    else if (seg.selectedSegmentIndex == 1)
        [self goToNextResponder];
}

- (void)doneButtonPressed:(UIBarButtonItem*)doneButton
{
    [currentResponder resignFirstResponder];
}

- (IBAction)infoButtonPressed:(id)sender {}

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
    [scrollView release];
    [contentView release];
    [keyboardToolbar release];

    [super dealloc];
}


@end

