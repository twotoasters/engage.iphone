//
//  ConfigurationData.m
//  ApiTester
//
//  Created by lilli on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DLog(...)
#endif

#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#define WLog(fmt, ...) NSLog((@"***  WARNING  *** %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define ELog(fmt, ...) NSLog((@"***   ERROR   *** %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#import <Foundation/Foundation.h>
#import "ConfigurationData.h"

@implementation ConfigurationData
@synthesize delegate;
@synthesize iPad;
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

@synthesize signinAddNativeLogin;
@synthesize signinAlwaysForceReauth;
@synthesize signinSkipUserLanding;
@synthesize signinExcludeProviders;

@synthesize excludeProvidersArray;

@synthesize activityAddDefaultAction;
@synthesize activityAddDefaultUrl;
@synthesize activityAddDefaultTitle;
@synthesize activityAddDefaultDescription;
@synthesize activityAddDefaultImage;
@synthesize activityAddDefaultSong;
@synthesize activityAddDefaultVideo;
@synthesize activityAddDefaultActionLinks;
@synthesize activityAddDefaultProperties;
@synthesize activityAddDefaultEmailObject;
@synthesize activityAddDefaultSmsObject;

@synthesize activityAction;
@synthesize activityUrl;
@synthesize activityTitle;
@synthesize activityDescription;

@synthesize applicationNavigationController;

#pragma mark singleton_methods
static NSString * const appId = @"appcfamhnpkagijaeinl";
static NSString * const tokenUrl = @"http://jrauthenticate.appspot.com/login";
//static NSString * const appId = @"fccdmobdiafiebjhbghn";
//static NSString * const tokenUrl = nil;

static ConfigurationData *sharedConfigurationData = nil;

#define VALID_DEFAULTS
#ifdef  VALID_DEFAULTS
static NSString * const defaultAction       = @"is sharing an activity";
static NSString * const defaultUrl          = @"http://www.google.com";
static NSString * const defaultTitle        = @"This is the default title";
static NSString * const defaultDescription  = @"This is the default description";
static NSString * const defaultImageSrc     = @"http://www.janrain.com/sites/default/themes/janrain/logo.png";
static NSString * const defaultImageHref    = @"http://www.janrain.com";
static NSString * const defaultSongSrc      = @"http://www.myspace.com/music/song-embed?songid=25313324&getSwf=true";
static NSString * const defaultVideoSwfsrc  = @"http://vimeo.com/23496497";
static NSString * const defaultVideoImgsrc  = @"http://b.vimeocdn.com/ts/153/117/153117150_100.jpg";
static NSString * const defaultEmailSubject = @"I am sending you an email and this is the subject";
static NSString * const defaultEmailBody    = @"I am sending you an email and this is the body";
static NSString * const defaultSmsMessage   = @"I am sending you text and this is the message";
static NSString * const defaultActionLinkText = @"Action Link Text";
static NSString * const defaultActionLinkHref = @"http://janrain.com";
#else
#endif



- (id)init
{
    if ((self = [super init]))
    {
        sharedConfigurationData = self;

        jrEngage = [JREngage jrEngageWithAppId:appId andTokenUrl:tokenUrl delegate:self];

        defaultActivityAction      = defaultAction;
        defaultActivityUrl         = defaultUrl;
        defaultActivityTitle       = defaultTitle;
        defaultActivityDescription = defaultDescription;

        defaultActivityImage      = [[JRImageMediaObject alloc] initWithSrc:defaultImageSrc andHref:defaultImageHref];

        defaultActivitySong       = [[JRMp3MediaObject alloc] initWithSrc:defaultSongSrc];

        defaultActivityVideo      = [[JRFlashMediaObject alloc] initWithSwfsrc:defaultVideoSwfsrc
                                                                     andImgsrc:defaultVideoImgsrc];

        defaultActivityEmail      = [[JREmailObject alloc] initWithSubject:defaultEmailSubject
                                                            andMessageBody:defaultEmailBody
                                                                    isHtml:NO
                                                      andUrlsToBeShortened:nil];

        defaultActivitySms        = [[JRSmsObject alloc] initWithMessage:defaultSmsMessage
                                                    andUrlsToBeShortened:nil];

        defaultActivityActionLink = [[JRActionLink alloc] initWithText:defaultActionLinkText
                                                               andHref:defaultActionLinkHref];

        defaultActivityProperties =
                [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                        [NSDictionary dictionaryWithObjectsAndKeys:
                                @"Portland", @"text",
                                @"http://en.wikipedia.org/wiki/Portland,_Oregon", @"href", nil], @"Location",
                        @"5:00", @"Time", nil];

        customNavigationController = [[UINavigationController alloc] init];
        customNavigationController.navigationBar.tintColor = JANRAIN_BLUE_80;

        embeddedTable = [[EmbeddedTableViewController alloc] init];

        [self resetActivity];
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

- (void)resetSignIn
{
    [excludeProvidersArray release], excludeProvidersArray = nil;

    [jrEngage alwaysForceReauthentication:NO];

    signinAddNativeLogin    = NO;
    signinAlwaysForceReauth = NO;
    signinSkipUserLanding   = NO;
    signinExcludeProviders  = NO;
}

- (void)resetCustomInterface
{
    [customInterface release], customInterface = nil;

    authenticationBackgroundColor         = NO;
    authenticationBackgroundImageView     = NO;
    providerTableTitleView                = NO;
    providerTableTitleString              = NO;
    providerTableHeaderView               = NO;
    providerTableFooterView               = NO;
    providerTableSectionHeaderView        = NO;
    providerTableSectionFooterView        = NO;
    providerTableSectionHeaderTitleString = NO;
    providerTableSectionFooterTitleString = NO;

    usingPopoverFromRect          = NO;
    usingPopoverFromBarButtonItem = NO;
}

- (void)resetActivity
{
    [activity release],                     activity = nil;
    [activityMediaArray release],           activityMediaArray = nil;
    [activityActionLinksArray release],     activityActionLinksArray = nil;
    [activityPropertiesDictionary release], activityPropertiesDictionary = nil;

    [activityAction release],      activityAction = nil;
    [activityUrl release],         activityUrl    = nil;
    [activityTitle release],       activityTitle  = nil;
    [activityDescription release], activityDescription = nil;

    [activityEmailObject release], activityEmailObject = nil;
    [activitySmsObject release],   activitySmsObject   = nil;

    activityAddDefaultAction      = NO;
    activityAddDefaultUrl         = NO;
    activityAddDefaultTitle       = NO;
    activityAddDefaultDescription = NO;
    activityAddDefaultImage       = NO;
    activityAddDefaultSong        = NO;
    activityAddDefaultVideo       = NO;
    activityAddDefaultActionLinks = NO;
    activityAddDefaultProperties  = NO;
    activityAddDefaultEmailObject = NO;
    activityAddDefaultSmsObject   = NO;
}

- (void)addActivityImageWithSrc:(NSString *)src andHref:(NSString *)href
{
    if (!activityMediaArray)
        activityMediaArray = [[NSMutableArray alloc] initWithCapacity:5];

    JRImageMediaObject *image = [JRImageMediaObject imageMediaObjectWithSrc:src andHref:href];

    if (!image)
        WLog(@"You tried to create a JRImageMediaObject, but result was nil.  No image was added to the media array.");
    else
        [activityMediaArray addObject:image];
}

- (void)addActivitySongWithSrc:(NSString *)src title:(NSString *)title artist:(NSString *)artist andAlbum:(NSString *)album
{
    if (!activityMediaArray)
        activityMediaArray = [[NSMutableArray alloc] initWithCapacity:5];

    JRMp3MediaObject *song = [JRMp3MediaObject mp3MediaObjectWithSrc:src];

    [song setTitle:title];
    [song setArtist:artist];
    [song setAlbum:album];

    if (!song)
        WLog(@"You tried to create a JRMp3MediaObject, but result was nil.  No song was added to the media array.");
    else
        [activityMediaArray addObject:song];
}

- (void)addActivityVideoWithSwfsrc:(NSString *)swfsrc imgsrc:(NSString *)imgsrc width:(NSUInteger)width height:(NSUInteger)height
                     expandedWidth:(NSUInteger)expandedWidth andExpandedHeight:(NSUInteger)expandedHeight
{
    if (!activityMediaArray)
        activityMediaArray = [[NSMutableArray alloc] initWithCapacity:5];

    JRFlashMediaObject *video = [JRFlashMediaObject flashMediaObjectWithSwfsrc:swfsrc andImgsrc:imgsrc];

    [video setWidth:width];
    [video setHeight:height];
    [video setExpanded_width:expandedWidth];
    [video setExpanded_height:expandedHeight];

    if (!video)
        WLog(@"You tried to create a JRFlashMediaObject, but result was nil.  No video was added to the media array.");
    else
        [activityMediaArray addObject:video];
}

- (void)addActivityPropertiesWithDictionary:(NSDictionary *)properties
{
    if (!activityPropertiesDictionary)
        activityPropertiesDictionary = [[NSMutableDictionary alloc] initWithDictionary:properties];
    else
        [activityPropertiesDictionary addEntriesFromDictionary:properties];
}

- (void)addActivityEmailWithSubject:(NSString *)subject body:(NSString *)body isHtml:(BOOL)isHtml andUrls:(NSArray *)urls
{
    if (activityEmailObject)
        [activityEmailObject release];

    activityEmailObject = [[JREmailObject alloc] initWithSubject:subject
                                                  andMessageBody:body
                                                          isHtml:isHtml
                                            andUrlsToBeShortened:urls];

    if (!activityEmailObject)
        WLog(@"You tried to create a JREmailObject, but result was nil. This may or may not have been your intention.");
}

- (void)addActivitySmsWithMessage:(NSString *)message andUrls:(NSArray *)urls
{
    if (activitySmsObject)
        [activitySmsObject release];

    activitySmsObject = [[JRSmsObject alloc] initWithMessage:message andUrlsToBeShortened:urls];

    if (!activitySmsObject)
        WLog(@"You tried to create a JRSmsObject, but result was nil. This may or may not have been your intention.");
}

- (void)setPopoverRect:(CGPoint)rect andArrowDirection:(UIPopoverArrowDirection)arrowDirection
{
    popoverRect           = CGRectMake(rect.x - 5, rect.y - 5, 10, 10);
    popoverArrowDirection = arrowDirection;
    usingPopoverFromRect  = YES;
}

- (void)setPopoverBarButtonItem:(UIBarButtonItem *)barButton andArrowDirection:(UIPopoverArrowDirection)arrowDirection
{
    popoverBarButton              = barButton;
    popoverArrowDirection         = arrowDirection;
    usingPopoverFromBarButtonItem = YES;
}

- (void)buildAuthenticationCustomInterface
{
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

- (void)buildActivity
{
    if (!activity)
    {
        if (activityAction)
            activity = [[JRActivityObject alloc] initWithAction:activityAction];
        else if (activityAddDefaultAction)
            activity = [[JRActivityObject alloc] initWithAction:defaultActivityAction];
        else
            activity = [[JRActivityObject alloc] initWithAction:nil];

        if (!activity)
            WLog(@"You tried to create a JRActivityObject, but result was nil.  Without an activity, sharing will not work. This may or may not have been your intention.");
    }

    if (activityUrl)
        [activity setUrl:activityUrl];
    else if (activityAddDefaultUrl)
        [activity setUrl:defaultActivityUrl];
    else ; // Do nothing

    if (activityTitle)
        activity.title = activityTitle;
    else if (activityAddDefaultTitle)
        activity.title = defaultActivityTitle;
    else ; // Do nothing

    if (activityDescription)
        activity.description = activityDescription;
    if (activityAddDefaultDescription)
        activity.description = defaultActivityDescription;
    else ; // Do nothing

    if (activityAddDefaultImage || activityAddDefaultSong || activityAddDefaultVideo)
    {
        if (!activityMediaArray)
            activityMediaArray = [[NSMutableArray alloc] initWithCapacity:5];

        if (activityAddDefaultImage)
            [activityMediaArray addObject:defaultActivityImage];

        if (activityAddDefaultSong)
            [activityMediaArray addObject:defaultActivitySong];

        if (activityAddDefaultVideo)
            [activityMediaArray addObject:defaultActivityVideo];
    }

    if (activityAddDefaultActionLinks)
    {
        if (!activityActionLinksArray)
            activityActionLinksArray = [[NSMutableArray alloc] initWithCapacity:1];

        [activityActionLinksArray addObject:defaultActivityActionLink];
    }

    if (activityAddDefaultProperties)
    {
        if (!activityPropertiesDictionary)
            activityPropertiesDictionary = [[NSMutableDictionary alloc] initWithCapacity:1];

        [activityPropertiesDictionary addEntriesFromDictionary:defaultActivityProperties];
    }

    if (activityEmailObject)
       activity.email = activityEmailObject;
    else if (activityAddDefaultEmailObject)
        activity.email = defaultActivityEmail;
    else ; // Do nothing

    if (activitySmsObject)
        activity.sms = activitySmsObject;
    else if (activityAddDefaultSmsObject)
        activity.sms = defaultActivitySms;
    else ; // Do nothing

    if (activityMediaArray)
        activity.media = activityMediaArray;
    else ; // Do nothing

    if (activityActionLinksArray)
        activity.action_links = activityActionLinksArray;
    else ; // Do nothing

    if (activityPropertiesDictionary)
        activity.properties = activityPropertiesDictionary;
    else ; // Do nothing
}

- (void)startTestWithNavigationController:(NavigationControllerType)navigationControllerType
{
    [customInterface release], customInterface = nil;
    customInterface = [[NSMutableDictionary alloc] initWithCapacity:10];

    if (navigationControllerType == CDNavigationControllerTypeApplication)
        [customInterface setObject:applicationNavigationController forKey:kJRApplicationNavigationController];
    else if (navigationControllerType == CDNavigationControllerTypeCustom)
        [customInterface setObject:customNavigationController forKey:kJRCustomModalNavigationController];

    if (usingPopoverFromRect)
    {
        [customInterface setObject:[NSValue valueWithCGRect:popoverRect]
                            forKey:kJRPopoverPresentationFrameValue];
        [customInterface setObject:[NSNumber numberWithInt:popoverArrowDirection]
                            forKey:kJRPopoverPresentationArrowDirection];

     /* Now reset the flag for next time */
        usingPopoverFromRect = NO;
    }

    if (usingPopoverFromBarButtonItem)
    {
        [customInterface setObject:popoverBarButton
                            forKey:kJRPopoverPresentationBarButtonItem];
        [customInterface setObject:[NSNumber numberWithInt:popoverArrowDirection]
                            forKey:kJRPopoverPresentationArrowDirection];

     /* Now reset the flag for next time */
        usingPopoverFromBarButtonItem = NO;
    }

    if (signInOrSharing == CDSignIn)
    {
        if (signInTestType == CDSignInTestTypeCustomInterface)
        {
            [self buildAuthenticationCustomInterface];
        }
        else if (signInTestType == CDSignInTestTypeProviderConfiguration)
        {
            if (signinAddNativeLogin)
            {
                if (navigationControllerType == CDNavigationControllerTypeLibrary)
                    [customInterface setObject:applicationNavigationController
                                        forKey:kJRApplicationNavigationController];

                [embeddedTable setUsingNavigationController:
                        (navigationControllerType == CDNavigationControllerTypeCustom) ?
                                customNavigationController : applicationNavigationController];

                [customInterface setObject:embeddedTable.view
                                    forKey:kJRProviderTableHeaderView];
                [customInterface setObject:@"Sign in with a social provider"
                                    forKey:kJRProviderTableSectionHeaderTitleString];
            }

            if (signinAlwaysForceReauth)
                [jrEngage alwaysForceReauthentication:YES];
            else
                [jrEngage alwaysForceReauthentication:NO];

            if (signinExcludeProviders)
            {
                DLog(@"excluded providers: %@", [excludeProvidersArray description]);
                [customInterface setObject:excludeProvidersArray forKey:kJRRemoveProvidersFromAuthentication];
            }
        }

        [jrEngage showAuthenticationDialogWithCustomInterfaceOverrides:customInterface];
    }
    else if (signInOrSharing == CDSharing)
    {
        [self buildActivity];
        [jrEngage showSocialPublishingDialogWithActivity:activity andCustomInterfaceOverrides:customInterface];
    }
}

- (void)triggerAuthenticationDidCancel:(id)sender
{
    [jrEngage authenticationDidCancel];
}

- (void)jrEngageDialogDidFailToShowWithError:(NSError*)error { }

- (void)jrAuthenticationDidNotComplete
{
    if ([delegate respondsToSelector:@selector(libraryDialogClosed)])
        [delegate libraryDialogClosed];
}

- (void)jrAuthenticationDidSucceedForUser:(NSDictionary*)auth_info
                              forProvider:(NSString*)provider
{
    if ([delegate respondsToSelector:@selector(libraryDialogClosed)])
        [delegate libraryDialogClosed];
}

- (void)jrAuthenticationDidFailWithError:(NSError*)error
                             forProvider:(NSString*)provider
{
    if ([delegate respondsToSelector:@selector(libraryDialogClosed)])
        [delegate libraryDialogClosed];
}

- (void)jrAuthenticationDidReachTokenUrl:(NSString*)tokenUrl
                            withResponse:(NSURLResponse*)response
                              andPayload:(NSData*)tokenUrlPayload
                             forProvider:(NSString*)provider { }

- (void)jrAuthenticationCallToTokenUrl:(NSString*)tokenUrl
                      didFailWithError:(NSError*)error
                           forProvider:(NSString*)provider { }

- (void)jrSocialDidNotCompletePublishing
{
    if ([delegate respondsToSelector:@selector(libraryDialogClosed)])
        [delegate libraryDialogClosed];
}

- (void)jrSocialDidCompletePublishing
{
    if ([delegate respondsToSelector:@selector(libraryDialogClosed)])
        [delegate libraryDialogClosed];
}

- (void)jrSocialDidPublishActivity:(JRActivityObject*)activity
                       forProvider:(NSString*)provider { }

- (void)jrSocialPublishingActivity:(JRActivityObject*)activity
                  didFailWithError:(NSError*)error
                       forProvider:(NSString*)provider { }

@end

