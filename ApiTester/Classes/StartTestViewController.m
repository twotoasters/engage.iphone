//
//  StartTest.m
//  ApiTester
//
//  Created by lilli on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StartTestViewController.h"

@implementation StartTestViewController
@synthesize startButton;
@synthesize navigationRadio;
@synthesize padDisplayRadio;
@synthesize padDisplayLabel;
@synthesize padDisplayToast;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.frame = CGRectMake(0, 0, 768, 1004);
    config = [ConfigurationData sharedConfigurationData];
//    startButton.titleLabel.numberOfLines = 2;

    titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 44)] autorelease];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
    titleLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];

    self.navigationItem.titleView = titleLabel;
    self.title = @"Test";

    if (config.iPad)
    {
        [padDisplayLabel setHidden:NO];
        [padDisplayRadio setHidden:NO];

        [padDisplayToast setOuterFillColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0]];
        [padDisplayToast setOuterStrokeColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0]];
        [padDisplayToast setDrawInnerRect:NO];
        [padDisplayToast setOuterCornerRadius:5.0];
        [padDisplayToast setNeedsDisplay];

        padDisplayListener = [[UIButton buttonWithType:UIButtonTypeCustom] retain];

        [padDisplayListener setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [padDisplayListener setBackgroundColor:[UIColor redColor]];//clearColor]];
        [padDisplayListener setShowsTouchWhenHighlighted:YES];

        [padDisplayListener addTarget:self
                               action:@selector(popoverDisplayListenerPressed:forEvent:)
                     forControlEvents:UIControlEventTouchUpInside];

        [padDisplayListener setHidden:YES];

        [self.view addSubview:padDisplayListener];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (config.signInOrSharing == CDSignIn)
    {
        titleLabel.text = @"Test Sign-In";
        [startButton setTitle:@"Start the Sign-In Test" forState:UIControlStateNormal];
    }
    else if (config.signInOrSharing == CDSharing)
    {
        titleLabel.text = @"Test Sharing";
        [startButton setTitle:@"Start the Sharing Test" forState:UIControlStateNormal];
    }
}

- (void)popoverDisplayListenerPressed:(id)sender forEvent:(UIEvent*)event
{
    UIView *button = (UIView *)sender;
    UITouch *touch = [[event touchesForView:button] anyObject];
    CGPoint location = [touch locationInView:button];
    NSLog(@"Location in button: %f, %f", location.x, location.y);

    padDisplayLocation.x = location.x;
    padDisplayLocation.y = location.y;

    [padDisplayListener setHidden:YES];

    UIViewController *vc = [[[UIViewController alloc] init] autorelease];
    UITableView      *tv = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 260)
                                                         style:UITableViewStylePlain] autorelease];
    tv.dataSource = self;
    tv.delegate   = self;

    vc.view = tv;

    arrowDirectionPopover = [[UIPopoverController alloc] initWithContentViewController:vc];

    arrowDirectionPopover.delegate = self;
    arrowDirectionPopover.popoverContentSize = CGSizeMake(320, 260);

    [arrowDirectionPopover presentPopoverFromRect:CGRectMake(location.x - 1, location.y - 1, 2, 2)
                                           inView:self.view
                         permittedArrowDirections:UIPopoverArrowDirectionAny
                                         animated:YES];

}

- (void)startPopoverPressListener
{
    padDisplayLocation.x = 0;
    padDisplayLocation.y = 0;

    arrowDirection = UIPopoverArrowDirectionAny;
    [arrowDirectionPopover release], arrowDirectionPopover = nil;

    [padDisplayListener setHidden:NO];
    [padDisplayToast setHidden:NO];

    [UIView beginAnimations:@"toast_appear" context:nil];
    [padDisplayToast setAlpha:1.0];
    [UIView commitAnimations];

    [UIView beginAnimations:@"toast_disappear" context:nil];
    [UIView setAnimationDelay:2000];
    [padDisplayToast setAlpha:0.0];
    [UIView commitAnimations];
}

- (IBAction)startButtonPressed:(id)sender
{
    if (config.iPad)
    {
        if (padDisplayRadio.selectedSegmentIndex == 0)
            [config startTestWithNavigationController:CDNavigationControllerTypeLibrary];
        else
            [self startPopoverPressListener];
    }
    else
    {
        if (navigationRadio.selectedSegmentIndex == 0)
            [config startTestWithNavigationController:CDNavigationControllerTypeLibrary];
        else if (navigationRadio.selectedSegmentIndex == 1)
            [config startTestWithNavigationController:CDNavigationControllerTypeApplication];
        else
            [config startTestWithNavigationController:CDNavigationControllerTypeCustom];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView                         { return 1; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  { return 5; }

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Please choose an arrow direction for the library's popover dialog";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"* The default arrow direction";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if (cell == nil)
         cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                        reuseIdentifier:@"cell"] autorelease];

    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text = @"Arrow Direction Up";
            break;
        case 1:
            cell.textLabel.text = @"Arrow Direction Down";
            break;
        case 2:
            cell.textLabel.text = @"Arrow Direction Left";
            break;
        case 3:
            cell.textLabel.text = @"Arrow Direction Right";
            break;
        case 4:
            cell.textLabel.text = @"Arrow Direction Any*";
            break;
        case 5:
            cell.textLabel.text = @"Arrow Direction Unknown";
            break;
        default:
            break;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
            arrowDirection = UIPopoverArrowDirectionUp;
            break;
        case 1:
            arrowDirection = UIPopoverArrowDirectionDown;
            break;
        case 2:
            arrowDirection = UIPopoverArrowDirectionLeft;
            break;
        case 3:
            arrowDirection = UIPopoverArrowDirectionRight;
            break;
        case 4:
            arrowDirection = UIPopoverArrowDirectionAny;
            break;
        case 5:
            arrowDirection = UIPopoverArrowDirectionUnknown;
            break;
        default:
            break;
    }

    [arrowDirectionPopover dismissPopoverAnimated:YES];
}
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{

}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)viewWillDisappear:(BOOL)animated
{
    [padDisplayListener setHidden:YES];

    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    [startButton           release];
    [navigationRadio       release];
    [padDisplayRadio       release];
    [padDisplayLabel       release];
    [padDisplayToast       release];
    [padDisplayListener    release];
    [arrowDirectionPopover release];

    [super dealloc];
}

@end
