//
//  CustomSharingTabViewController.h
//  QuickPublish
//
//  Created by Lilli Szafranski on 2/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JREngage+CustomInterface.h"

#define JRR_OUTER_STROKE_COLOR    [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0]
#define JRR_INNER_STROKE_COLOR    JANRAIN_BLUE
#define JRR_OUTER_FILL_COLOR      [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0]
#define JRR_INNER_FILL_COLOR      [UIColor clearColor]
#define JRR_OUTER_STROKE_WIDTH    0.1
#define JRR_INNER_STROKE_WIDTH    0.5
#define JRR_OUTER_CORNER_RADIUS   10.0
#define JRR_INNER_CORNER_RADIUS   9.0
#define JRR_INNER_RECT_INSET      6

@interface QPRoundedRect : UIView
{
    UIColor *outerStrokeColor;
    UIColor *innerStrokeColor;
    UIColor *outerFillColor;
    UIColor *innerFillColor;
    CGFloat  outerStrokeWidth;
    CGFloat  innerStrokeWidth;
    CGFloat  outerCornerRadius;
    CGFloat  innerCornerRadius;
    BOOL     drawInnerRect;
}
@property (nonatomic, retain) UIColor *outerStrokeColor;
@property (nonatomic, retain) UIColor *innerStrokeColor;
@property (nonatomic, retain) UIColor *outerFillColor;
@property (nonatomic, retain) UIColor *innerFillColor;
@property CGFloat outerStrokeWidth;
@property CGFloat innerStrokeWidth;
@property CGFloat outerCornerRadius;
@property CGFloat innerCornerRadius;
@property BOOL    drawInnerRect;
@end

@interface CustomSharingTabViewController : UIViewController <JRCustomSharingTabDelegate>
@property (nonatomic, retain) IBOutlet UITextView              *myUserCommentTextView;
@property (nonatomic, retain) IBOutlet QPRoundedRect           *myUserCommentBoundingBox;
@property (nonatomic, retain) IBOutlet UIButton                *myJustShareButton;
@property (nonatomic, retain) IBOutlet UIButton                *myProfilePic;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *myProfilePicActivityIndicator;
@property (nonatomic, retain) IBOutlet UILabel                 *myUserName;
@property (nonatomic, retain) IBOutlet UIButton                *mySignOutButton;
@property (nonatomic, retain) IBOutlet UIImageView             *mySharedCheckMark;
@property (nonatomic, retain) IBOutlet UILabel                 *mySharedLabel;
@property (nonatomic, retain) IBOutlet UIToolbar               *myKeyboardToolbar;
- (IBAction)keyboardDoneButtonPressed:(id)sender;
@end
