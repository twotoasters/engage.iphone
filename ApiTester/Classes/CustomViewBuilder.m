//
//  ConfigurationData+CustomViewBuilder.m
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

	return (UIView*)label;
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

	return (UIView*)label;
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

	return (UIView*)label;
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

	return (UIView*)label;
}

+ (UIView*)providerTableSectionFooterView
{
    DLog(@"");
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 36)] autorelease];
    label.backgroundColor = [UIColor blueColor];
    label.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:16.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentLeft;
    label.textColor = [UIColor whiteColor];
    label.text = @"Custom Section Footer View";

	return (UIView*)label;
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

@end
