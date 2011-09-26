//
//  ConfigurationData+CustomViewBuilder.h
//  ApiTester
//
//  Created by lilli on 9/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomViewBuilder.h"

@interface CustomViewBuilder : NSObject { }
+ (UIColor*)authenticationBackgroundColor;
+ (UIImageView*)authenticationBackgroundImageView;
+ (UIView*)providerTableTitleView;
+ (NSString*)providerTableTitleString;
+ (UIView*)providerTableHeaderView;
+ (UIView*)providerTableFooterView;
+ (UIView*)providerTableSectionHeaderView;
+ (UIView*)providerTableSectionFooterView;
+ (NSString*)providerTableSectionHeaderTitleString;
+ (NSString*)providerTableSectionFooterTitleString;
@end
