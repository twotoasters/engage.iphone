/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 Copyright (c) 2011, Janrain, Inc.

 All rights reserved.

 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this
     list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice,
     this list of conditions and the following disclaimer in the documentation and/or
     other materials provided with the distribution.
 * Neither the name of the Janrain, Inc. nor the names of its
     contributors may be used to endorse or promote products derived from this
     software without specific prior written permission.


 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
 ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */


#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DLog(...)
#endif

#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#import "CustomViewBuilder.h"

@implementation CustomViewBuilder
+ (UIColor*)authenticationBackgroundColor
{
    DLog(@"");
    return [UIColor cyanColor];
}

+ (UIImageView*)authenticationBackgroundImageView
{
    DLog(@"");
    return [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundWeave"]] autorelease];
}

+ (UIView*)providerTableTitleView
{
    DLog(@"");
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 44)] autorelease];
    label.backgroundColor = [UIColor magentaColor];
    label.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"Custom Title View";

	return label;
}

+ (NSString*)providerTableTitleString
{
    DLog(@"");
	return @"Custom Title String";
}

+ (UIView*)providerTableHeaderView
{
    DLog(@"");
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 60)] autorelease];
    label.backgroundColor = [UIColor yellowColor];
    label.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:24.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentRight;
    label.textColor = [UIColor whiteColor];
    label.text = @"Custom Table Header View";

	return label;
}

+ (UIView*)providerTableFooterView
{
    DLog(@"");
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(40, 0, 280, 60)] autorelease];
    label.backgroundColor = [UIColor greenColor];
    label.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:24.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentLeft;
    label.textColor = [UIColor whiteColor];
    label.text = @"Custom Table Footer View";

	return label;
}

+ (UIView*)providerTableSectionHeaderView
{
    DLog(@"");
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 36)] autorelease];
    label.backgroundColor = [UIColor purpleColor];
    label.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:16.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentLeft;
    label.textColor = [UIColor whiteColor];
    label.text = @"Custom Section Header View";

	return label;
}

+ (UIView*)providerTableSectionFooterView
{
    DLog(@"");
    UIView  *view  = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 36)] autorelease];
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 36)] autorelease];
    label.backgroundColor = [UIColor blueColor];
    label.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:16.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentLeft;
    label.textColor = [UIColor whiteColor];
    label.text = @"Custom Section Footer View";
    label.autoresizingMask = UIViewAutoresizingNone;

    [view addSubview:label];

    return view;
}

+ (NSString*)providerTableSectionHeaderTitleString
{
    DLog(@"");
	return @"Custom Section Header String";
}

+ (NSString*)providerTableSectionFooterTitleString
{
    DLog(@"");
	return @"Custom Section Footer String";
}

+ (UIColor*)sharingBackgroundColor
{
    DLog(@"");
    return [UIColor cyanColor];
}

+ (UIImageView*)sharingBackgroundImageView
{
    DLog(@"");
    return [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundWeave"]] autorelease];
}

+ (UIView*)sharingTitleView
{
    DLog(@"");
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 44)] autorelease];
    label.backgroundColor = [UIColor magentaColor];
    label.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"Custom Title View";

	return label;
}

+ (NSString*)sharingTitleString
{
    DLog(@"");
	return @"Custom Title String";
}

@end
