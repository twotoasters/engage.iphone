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

@synthesize activityAddImage;
@synthesize activityAddSong;
@synthesize activityAddVideo;
@synthesize activityAddUrl;

@synthesize activityAction;
@synthesize activityTitle;
@synthesize activityDescription;

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

#define VALID_CONTENT
#ifdef  VALID_CONTENT
static NSString * const activityUrl = @"http://www.google.com";
static NSString * const activityImageSrc = @"http://www.janrain.com/sites/default/themes/janrain/logo.png";
static NSString * const activityImageHref = @"http://www.janrain.com";
static NSString * const activitySongSrc = @"http://www.myspace.com/music/song-embed?songid=25313324&getSwf=true";
static NSString * const activityVideoSwfsrc = @"http://vimeo.com/23496497";
static NSString * const activityVideoImgsrc = @"http://b.vimeocdn.com/ts/153/117/153117150_100.jpg";
#else
#endif


- (void)startTestWithNavigationController:(NavigationControllerType)navigationControllerType
{
    if (signInOrSharing == CDSignIn) 
    {
        if (signInTestType == CDSignInTestTypeCustomInterface)
        {
            [self buildAuthenticationCustomInterface];
            [jrEngage showAuthenticationDialogWithCustomInterfaceOverrides:customInterface];
        }
    }
    else if (signInOrSharing == CDSharing)
    {
        JRActivityObject *activity;
        
        if (activityAddUrl)
            activity = [JRActivityObject activityObjectWithAction:activityAction andUrl:activityUrl];
        else
            activity = [JRActivityObject activityObjectWithAction:activityAction];
        
        if (activityAddImage || activityAddSong || activityAddVideo)
        {
            NSMutableArray *media = [NSMutableArray arrayWithCapacity:3];
        
            if (activityAddImage)
                [media addObject:[JRImageMediaObject imageMediaObjectWithSrc:activityImageSrc andHref:activityImageHref]];

            if (activityAddSong)
                [media addObject:[JRMp3MediaObject mp3MediaObjectWithSrc:activitySongSrc]];

            if (activityAddVideo)
                [media addObject:[JRFlashMediaObject flashMediaObjectWithSwfsrc:activityVideoSwfsrc andImgsrc:activityVideoImgsrc]];
        
            activity.media = media;
        }
        
        if (activityTitle)
            activity.title = activityTitle; 
        
        if (activityDescription)    
            activity.description = activityDescription;
        
        [jrEngage showSocialPublishingDialogWithActivity:activity];        
    }
}

@end
