//
//  CustomSharingTabViewController.h
//  QuickPublish
//
//  Created by Lilli Szafranski on 2/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JREngage+CustomInterface.h"

@interface CustomSharingTabViewController : UIViewController <JRCustomSharingTabDelegate>
@property (nonatomic, retain) IBOutlet UITextView *myUserCommentTextView;
@end
