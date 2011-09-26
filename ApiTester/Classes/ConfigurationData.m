//
//  ConfigurationData.m
//  ApiTester
//
//  Created by lilli on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ConfigurationData.h"


@implementation ConfigurationData
@synthesize signInOrSharing;
@synthesize signInTestType;
@synthesize sharingTestType;

@synthesize authenticationBackgroundColor;
@synthesize authenticationBackgroundImageView;
@synthesize providerTableTitleView;
@synthesize providerTableTitleString;
@synthesize providerTableHeaderView;
@synthesize providerTableFooterView;
@synthesize providerTableSectionHeaderView;
@synthesize providerTableSectionFooterView;
@synthesize providerTableSectionHeaderTitleString;
@synthesize providerTableSectionFooterTitleString;

#pragma mark singleton_methods
static NSString * const appId = @"appcfamhnpkagijaeinl";
static NSString * const tokenUrl = @"http://jrauthenticate.appspot.com/login";

static ConfigurationData *sharedConfigurationData = nil;

- (id)init
{    
    if ((self = [super init]))
    {
        sharedConfigurationData = self;
        
        jrEngage = [JREngage jrEngageWithAppId:appId andTokenUrl:tokenUrl delegate:self];
    }
    
    return self;
}

+ (ConfigurationData*)sharedConfigurationData
{
    if (sharedConfigurationData)
        return sharedConfigurationData;
    
    return [((ConfigurationData*)[super allocWithZone:nil]) init];
}

+ (id)allocWithZone:(NSZone*)zone
{
    return [[self sharedConfigurationData] retain];
}

- (id)copyWithZone:(NSZone*)zone
{
    return self;
}

- (id)retain                { return self; }
- (NSUInteger)retainCount   { return NSUIntegerMax; }
- (void)release             { /* Do nothing... */ }
- (id)autorelease           { return self; }

- (void)buildAuthenticationCustomInterface
{
    if (!customInterface)
        customInterface = [[NSMutableDictionary alloc] initWithCapacity:10];
    
    if (authenticationBackgroundColor)
        [customInterface setObject:[CustomViewBuilder authenticationBackgroundColor] forKey:kJRAuthenticationBackgroundColor];
    
    if (authenticationBackgroundImageView)
        [customInterface setObject:[CustomViewBuilder authenticationBackgroundImageView] forKey:kJRAuthenticationBackgroundImageView];
    
    if (providerTableTitleView)
        [customInterface setObject:[CustomViewBuilder providerTableTitleView] forKey:kJRProviderTableTitleView];
    
    if (providerTableTitleString)
        [customInterface setObject:[CustomViewBuilder providerTableTitleString] forKey:kJRProviderTableTitleString];
    
    if (providerTableHeaderView)        
        [customInterface setObject:[CustomViewBuilder providerTableHeaderView] forKey:kJRProviderTableHeaderView];
    
    if (providerTableFooterView)
        [customInterface setObject:[CustomViewBuilder providerTableFooterView] forKey:kJRProviderTableFooterView];
    
    if (providerTableSectionHeaderView)
        [customInterface setObject:[CustomViewBuilder providerTableSectionHeaderView] forKey:kJRProviderTableSectionHeaderView];
    
    if (providerTableSectionFooterView)
        [customInterface setObject:[CustomViewBuilder providerTableSectionFooterView] forKey:kJRProviderTableSectionFooterView];        
    
    if (providerTableSectionHeaderTitleString)
        [customInterface setObject:[CustomViewBuilder providerTableSectionHeaderTitleString] forKey:kJRProviderTableSectionHeaderTitleString];
    
    if (providerTableSectionFooterTitleString)
        [customInterface setObject:[CustomViewBuilder providerTableSectionFooterTitleString] forKey:kJRProviderTableSectionFooterTitleString];
    
}

- (void)startTestWithNavigationController:(NavigationControllerType)navigationControllerType
{
    if (signInOrSharing == kCDSignInTests) 
    {
        if (signInTestType == kCDCustomInterfaceSignInTest)
        {
            [self buildAuthenticationCustomInterface];
            [jrEngage showAuthenticationDialogWithCustomInterfaceOverrides:customInterface];
        }
    }
    else if (signInOrSharing == kCDSharingTests)
    {
        
    }
}

@end
