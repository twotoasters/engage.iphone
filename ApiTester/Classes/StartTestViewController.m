//
//  StartTest.m
//  ApiTester
//
//  Created by lilli on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StartTestViewController.h"


@implementation StartTestViewController
@synthesize startButton;
@synthesize navigationRadio;
@synthesize padDisplayRadio;

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

- (IBAction)startButtonPressed:(id)sender
{
    if (navigationRadio.selectedSegmentIndex == 0)
    {
        [config startTestWithNavigationController:CDNavigationControllerTypeLibrary];
    }
    else if (navigationRadio.selectedSegmentIndex == 1)
    {
        [config startTestWithNavigationController:CDNavigationControllerTypeApplication];
    }
    else
    {
        [config startTestWithNavigationController:CDNavigationControllerTypeCustom];
    }
}

//- (IBAction)navigationRadioChanged:(id)sender
//{
//
//}
//
//- (IBAction)padDisplayRadioChanged:(id)sender
//{
//
//}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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

- (void)dealloc {
    [super dealloc];
}

@end
