//
//  ConfigurationData.h
//  ApiTester
//
//  Created by lilli on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomViewBuilder.h"
#import "JREngage.h"
#import "JREngage+CustomInterface.h"

typedef enum
{
    CDNone,
    CDSignIn,
    CDSharing,
} SignInOrSharing;

typedef enum
{
    CDSignInTestTypeNone,
    CDSignInTestTypeBasic,
    CDSignInTestTypeCustomInterface,
    CDSignInTestTypeProviderConfiguration,
} SignInTestType;

typedef enum
{
    CDSharingTestTypeNone,
    CDSharingTestTypeBasic,
    CDSharingTestTypeEmailSms,
    CDSharingTestTypeCustomInterface,
    CDSharingTestTypeActivityChanges,
} SharingTestType;

typedef enum
{
    CDNavigationControllerTypeLibrary,
    CDNavigationControllerTypeApplication,
    CDNavigationControllerTypeCustom,
} NavigationControllerType;

@interface ConfigurationData : NSObject <JREngageDelegate>
{
    JREngage *jrEngage;
    
    SignInOrSharing signInOrSharing;
    SignInTestType  signInTestType;
    SharingTestType sharingTestType;
    
    BOOL authenticationBackgroundColor;
    BOOL authenticationBackgroundImageView;
    BOOL providerTableTitleView;
    BOOL providerTableTitleString;
    BOOL providerTableHeaderView;
    BOOL providerTableFooterView;
    BOOL providerTableSectionHeaderView;
    BOOL providerTableSectionFooterView;
    BOOL providerTableSectionHeaderTitleString;
    BOOL providerTableSectionFooterTitleString;
    
    NSMutableDictionary *customInterface;
    
}
+ (ConfigurationData*)sharedConfigurationData;

@property SignInOrSharing signInOrSharing;
@property SignInTestType  signInTestType;
@property SharingTestType sharingTestType;

@property BOOL authenticationBackgroundColor;
@property BOOL authenticationBackgroundImageView;
@property BOOL providerTableTitleView;
@property BOOL providerTableTitleString;
@property BOOL providerTableHeaderView;
@property BOOL providerTableFooterView;
@property BOOL providerTableSectionHeaderView;
@property BOOL providerTableSectionFooterView;
@property BOOL providerTableSectionHeaderTitleString;
@property BOOL providerTableSectionFooterTitleString;

- (void)startTestWithNavigationController:(NavigationControllerType)navigationControllerType;
@end
