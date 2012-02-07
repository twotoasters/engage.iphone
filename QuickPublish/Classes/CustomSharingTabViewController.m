//
//  CustomSharingTabViewController.m
//  QuickPublish
//
//  Created by Lilli Szafranski on 2/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DLog(...)
#endif

#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#import "CustomSharingTabViewController.h"

@implementation QPRoundedRect
@synthesize outerStrokeColor;
@synthesize innerStrokeColor;
@synthesize outerFillColor;
@synthesize innerFillColor;
@synthesize outerStrokeWidth;
@synthesize innerStrokeWidth;
@synthesize outerCornerRadius;
@synthesize innerCornerRadius;
@synthesize drawInnerRect;

- (id)initWithCoder:(NSCoder *)decoder
{
    DLog(@"");
    if ((self = [super initWithCoder:decoder]))
    {
        self.outerStrokeColor  = JRR_OUTER_STROKE_COLOR;
        self.innerStrokeColor  = JRR_INNER_STROKE_COLOR;
        self.outerFillColor    = JRR_OUTER_FILL_COLOR;
        self.innerFillColor    = JRR_INNER_FILL_COLOR;
        self.outerStrokeWidth  = JRR_OUTER_STROKE_WIDTH;
        self.innerStrokeWidth  = JRR_INNER_STROKE_WIDTH;
        self.outerCornerRadius = JRR_OUTER_CORNER_RADIUS;
        self.innerCornerRadius = JRR_INNER_CORNER_RADIUS;
        self.backgroundColor   = [UIColor clearColor];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    DLog(@"");
    if ((self = [super initWithFrame:frame]))
    {
        self.opaque            = NO;
        self.outerStrokeColor  = JRR_OUTER_STROKE_COLOR;
        self.innerStrokeColor  = JRR_INNER_STROKE_COLOR;
        self.outerFillColor    = JRR_OUTER_FILL_COLOR;
        self.innerFillColor    = JRR_INNER_FILL_COLOR;
        self.outerStrokeWidth  = JRR_OUTER_STROKE_WIDTH;
        self.innerStrokeWidth  = JRR_INNER_STROKE_WIDTH;
        self.outerCornerRadius = JRR_OUTER_CORNER_RADIUS;
        self.innerCornerRadius = JRR_INNER_CORNER_RADIUS;
        self.backgroundColor   = [UIColor clearColor];
    }
    return self;
}

/* Functions are necessary for Interface Builder, but we want to ignore any attempt at changing the background color
or opacity of our rounded rectangle. */
- (void)setBackgroundColor:(UIColor *)newBackgroundColor { }
- (void)setOpaque:(BOOL)newIsOpaque                      { }

- (void)drawRoundedRect:(CGRect)roundedRect withRadius:(CGFloat)radius strokeWidth:(CGFloat)strokeWidth
            strokeColor:(UIColor*)strokeColor andFillColor:(UIColor*)fillColor
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, strokeWidth);
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    CGContextSetFillColorWithColor(context, fillColor.CGColor);

    CGFloat width  = CGRectGetWidth(roundedRect);
    CGFloat height = CGRectGetHeight(roundedRect);

 /* We need to make sure corner radius isn't larger than half of the shorter side, or else we need to
    set that as the corner radius*/
    if (radius > width / 2.0)
        radius = width / 2.0;
    if (radius > height / 2.0)
        radius = height / 2.0;

    CGFloat minx = CGRectGetMinX(roundedRect);
    CGFloat midx = CGRectGetMidX(roundedRect);
    CGFloat maxx = CGRectGetMaxX(roundedRect);
    CGFloat miny = CGRectGetMinY(roundedRect);
    CGFloat midy = CGRectGetMidY(roundedRect);
    CGFloat maxy = CGRectGetMaxY(roundedRect);

    CGContextMoveToPoint(context, minx, midy);
    CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
}

- (void)drawRect:(CGRect)rect
{
    DLog(@"");

    [self drawRoundedRect:self.bounds
               withRadius:outerCornerRadius strokeWidth:outerStrokeWidth
              strokeColor:outerStrokeColor andFillColor:outerFillColor];

    if (drawInnerRect)
        [self drawRoundedRect:CGRectMake(JRR_INNER_RECT_INSET, JRR_INNER_RECT_INSET,
                                         self.bounds.size.width - (2 * JRR_INNER_RECT_INSET),
                                         self.bounds.size.height - (2 * JRR_INNER_RECT_INSET))
                   withRadius:innerCornerRadius strokeWidth:innerStrokeWidth
                  strokeColor:innerStrokeColor andFillColor:innerFillColor];
}

- (void)dealloc {
    [outerStrokeColor release];
    [innerStrokeColor release];
    [outerFillColor release];
    [innerFillColor release];
    [super dealloc];
}
@end

@implementation CustomSharingTabViewController
@synthesize myUserCommentTextView;
@synthesize myUserCommentBoundingBox;
@synthesize myJustShareButton;
@synthesize myProfilePic;
@synthesize myProfilePicActivityIndicator;
@synthesize myUserName;
@synthesize mySignOutButton;
@synthesize mySharedCheckMark;
@synthesize mySharedLabel;

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

    myUserName.text = @"MML USER NAME";

    [myProfilePic setImage:[UIImage imageNamed:@"profilepic_placeholder.png"] forState:UIControlStateNormal];
    [myProfilePic setBackgroundColor:[UIColor clearColor]];

    [myUserCommentBoundingBox setOuterStrokeColor:[UIColor darkGrayColor]];
    [myUserCommentBoundingBox setOuterFillColor:[UIColor whiteColor]];
    [myUserCommentBoundingBox setOuterStrokeWidth:1.5];
    [myUserCommentBoundingBox setAlpha:0.5];
    [myUserCommentBoundingBox setNeedsDisplay];
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
- (void)showActivityAsShared:(BOOL)shared
{
    DLog(@"");
    [mySharedLabel setHidden:!shared];
    [mySharedCheckMark setHidden:!shared];

    [myJustShareButton setHidden:shared];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)dealloc
{
    [myUserCommentTextView release];

    [myUserCommentBoundingBox release];
    [myJustShareButton release];
    [myProfilePic release];
    [myProfilePicActivityIndicator release];
    [myUserName release];
    [mySignOutButton release];
    [mySharedCheckMark release];
    [mySharedLabel release];
    [super dealloc];
}
@end
