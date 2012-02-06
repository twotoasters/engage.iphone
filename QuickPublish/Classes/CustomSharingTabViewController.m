//
//  CustomSharingTabViewController.m
//  QuickPublish
//
//  Created by Lilli Szafranski on 2/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomSharingTabViewController.h"

@implementation CustomSharingTabViewController
@synthesize myUserCommentTextView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) { }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSString *)getUserGeneratedContent
{
    return myUserCommentTextView.text;
}

- (void)setUserGeneratedContent:(NSString *)userGeneratedContent
{
    myUserCommentTextView.text = userGeneratedContent;
}

- (void)onTab_RENAME_ME
{

}

- (void)offTab_RENAME_ME
{

}

- (void)dealloc
{
    [myUserCommentTextView release];

    [super dealloc];
}


@end
