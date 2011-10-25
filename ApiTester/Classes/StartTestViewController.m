//
//  StartTest.m
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

#import "StartTestViewController.h"

@implementation StartTestViewController
@synthesize startButton;
@synthesize navigationLabel;
@synthesize padDisplayLabel;
@synthesize navigationRadio;
@synthesize padDisplayRadio;
@synthesize padDisplayToast;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) { }

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

    config.delegate = self;

    if (config.iPad)
    {

        [padDisplayLabel setHidden:NO];
        [padDisplayRadio setHidden:NO];

        [padDisplayToast setOuterFillColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0]];
        [padDisplayToast setOuterStrokeColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0]];
        [padDisplayToast setDrawInnerRect:NO];
        [padDisplayToast setOuterCornerRadius:5.0];
        [padDisplayToast setNeedsDisplay];

        padDisplayTouchIndicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"touch_spot.png"]];
        padDisplayListener = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        padDisplayBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Click Me, Too!"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(barButtonPressed:)];

        [padDisplayTouchIndicator setFrame:CGRectMake(-30, -30, 30, 30)];

        [padDisplayListener setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [padDisplayListener setBackgroundColor:[UIColor clearColor]];//blackColor]];//clearColor]];
        //[padDisplayListener setAlpha:0.0];
        //[padDisplayListener setShowsTouchWhenHighlighted:YES];

        [padDisplayListener addTarget:self
                               action:@selector(popoverDisplayListenerPressed:forEvent:)
                     forControlEvents:UIControlEventTouchUpInside];

        [padDisplayListener setHidden:YES];

        [self.view addSubview:padDisplayListener];
        [self.view addSubview:padDisplayTouchIndicator];

        [navigationLabel setFrame:CGRectMake(navigationLabel.frame.origin.x - 40, navigationLabel.frame.origin.y,
                navigationLabel.frame.size.width + 80, navigationLabel.frame.size.height + 40)];
        [padDisplayLabel setFrame:CGRectMake(padDisplayLabel.frame.origin.x - 40, padDisplayLabel.frame.origin.y,
                padDisplayLabel.frame.size.width + 80, padDisplayLabel.frame.size.height + 40)];
        [navigationRadio setFrame:CGRectMake(navigationRadio.frame.origin.x - 20, navigationRadio.frame.origin.y,
                navigationRadio.frame.size.width + 40, navigationRadio.frame.size.height)];

        [navigationLabel setFont:[UIFont boldSystemFontOfSize:20.0]];
        [padDisplayLabel setFont:[UIFont boldSystemFontOfSize:20.0]];

        [navigationLabel setNumberOfLines:4];
        [padDisplayLabel setNumberOfLines:4];
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

- (void)libraryDialogClosed
{
    [self.navigationItem setRightBarButtonItem:nil animated:YES];

    [UIView beginAnimations:@"listener_disappear" context:nil];
    [padDisplayListener setAlpha:0.0];
    [padDisplayToast setAlpha:0.0];
    [padDisplayTouchIndicator setAlpha:0.0];
    [UIView commitAnimations];
}

- (void)fadeOutToast
{
    DLog(@"");

    [UIView beginAnimations:@"toast_disappear" context:nil];
    //[UIView setAnimationDuration:1000];
    [padDisplayToast setAlpha:0.0];
    [UIView commitAnimations];
}

- (void)fadeOutListener
{
    DLog(@"");

    [UIView beginAnimations:@"listener_disappear" context:nil];
    [padDisplayListener setAlpha:0.0];
    [UIView commitAnimations];
}

- (void)startPopoverPressListener
{
    DLog(@"");

    padDisplayLocation.x = 0;
    padDisplayLocation.y = 0;

    arrowDirection = UIPopoverArrowDirectionAny;
    [arrowDirectionPopover release], arrowDirectionPopover = nil;

    [padDisplayListener setHidden:NO];
    [padDisplayToast setHidden:NO];

    [self.navigationItem setRightBarButtonItem:padDisplayBarButtonItem animated:YES];

    [UIView beginAnimations:@"toast_appear" context:nil];
    [padDisplayToast setAlpha:1.0];
    [padDisplayListener setAlpha:0.3];
    [UIView commitAnimations];

    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(fadeOutToast) userInfo:nil repeats:NO];
}

- (IBAction)startButtonPressed:(id)sender
{
    DLog(@"");

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

- (void)barButtonPressed:(id)sender
{
    [config setPopoverBarButtonItem:padDisplayBarButtonItem andArrowDirection:arrowDirection];
    [config startTestWithNavigationController:CDNavigationControllerTypeLibrary];
}


- (void)popoverDisplayListenerPressed:(id)sender forEvent:(UIEvent*)event
{
    DLog(@"");

    UIView  *button   = (UIView *)sender;
    UITouch *touch    = [[event touchesForView:button] anyObject];
    CGPoint  location = [touch locationInView:button];

 /* We have to subtract 64 from our point, because the library uses coordinates relative to the screen, and
    the location is relative to our view controller's view, which is 64 pixels down from the top of the
    screen (in portrait mode), as the nav bar is 44 pixels, and the status bar is 20. */
    padDisplayLocation.x = location.x;
    padDisplayLocation.y = location.y + 64;

    [padDisplayTouchIndicator setFrame:CGRectMake(location.x - 15, location.y - 15, 30, 30)];
    [padDisplayTouchIndicator setHidden:NO];
//    [padDisplayTouchIndicator setBackgroundColor:[UIColor redColor]];

    [self fadeOutListener];

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

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    DLog(@"");

    [config setPopoverRect:padDisplayLocation andArrowDirection:arrowDirection];
    [config startTestWithNavigationController:CDNavigationControllerTypeLibrary];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"");

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

    [config setPopoverRect:padDisplayLocation andArrowDirection:arrowDirection];
    [config startTestWithNavigationController:CDNavigationControllerTypeLibrary];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView                         { return 1; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  { return 5; }

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Choose an arrow direction for the library's popover dialog";
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
    [startButton              release];
    [navigationLabel          release];
    [padDisplayLabel          release];
    [navigationRadio          release];
    [padDisplayRadio          release];
    [padDisplayToast          release];
    [padDisplayListener       release];
    [padDisplayTouchIndicator release];
    [padDisplayBarButtonItem  release];
    [arrowDirectionPopover    release];

    [super dealloc];
}

@end
