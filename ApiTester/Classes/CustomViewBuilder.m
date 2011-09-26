//
//  ConfigurationData+CustomViewBuilder.m
//  ApiTester
//
//  Created by lilli on 9/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomViewBuilder.h"


@implementation CustomViewBuilder
+ (UIColor*)authenticationBackgroundColor
{
    return [UIColor cyanColor];
}

+ (UIImageView*)authenticationBackgroundImageView
{
    return [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundWeave"]] autorelease];
}

+ (UIView*)providerTableTitleView
{
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
	return @"Custom Title String";
}

+ (UIView*)providerTableHeaderView
{
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
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(40, 0, 280, 60)] autorelease];
    label.backgroundColor = [UIColor greenColor];
    label.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:24.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentLeft;
    label.textColor = [UIColor whiteColor];
    label.text = @"Custom Table Header View";    
    
	return (UIView*)label;
}

+ (UIView*)providerTableSectionHeaderView
{
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
	return @"Custom Section Header String";
}

+ (NSString*)providerTableSectionFooterTitleString
{
	return @"Custom Section Footer String";
}

@end
