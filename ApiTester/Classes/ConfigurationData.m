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

//#define WLog(fmt, ...) NSLog((@"***  WARNING  *** %s %s" fmt), "", "", ##__VA_ARGS__)
//#define ELog(fmt, ...) NSLog((@"***   ERROR   *** %s %s" fmt), "", "", ##__VA_ARGS__)
//#define ILog(fmt, ...) NSLog((@"***    FYI    *** %s %s" fmt), "", "", ##__VA_ARGS__)

#define WLog(fmt, ...) NSLog((@"\n\n***  WARNING  *** " fmt), ##__VA_ARGS__)
#define ELog(fmt, ...) NSLog((@"\n\n***   ERROR   *** " fmt), ##__VA_ARGS__)
#define ILog(fmt, ...) NSLog((@"\n\n***    FYI    *** " fmt), ##__VA_ARGS__)


#import <Foundation/Foundation.h>
#import "ConfigurationData.h"
#import "JRActivityObject.h"

@implementation ResultObject
@synthesize timestamp;
@synthesize summary;
@synthesize detail;
@synthesize resultStat;

- (NSString *)getCurrentTime
{
 /* Get the approximate timestamp of the user's log in */
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setTimeStyle:NSDateFormatterLongStyle];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];

    return [dateFormatter stringFromDate:today];
}

- (id)initWithTimestamp:(NSString *)newTimestamp summary:(NSString *)newSummary
                 detail:(NSString *)newDetail andResultStat:(ResultStat)newResultStat
{
    if (newSummary == nil)
    {
        [self release];
        return nil;
    }

    if ((self = [super init]))
    {
        if (newTimestamp == nil)
            timestamp = [self getCurrentTime];
        else
            timestamp = [newTimestamp copy];

        summary = [newSummary copy];
        detail  = [newDetail copy];

        resultStat = newResultStat;
    }

    return self;
}

+ (id)resultObjectWithTimestamp:(NSString *)newTimestamp summary:(NSString *)newSummary
                         detail:(NSString *)newDetail andResultStat:(ResultStat)newResultStat
{
    return [[[ResultObject alloc] initWithTimestamp:newTimestamp summary:newSummary
                                             detail:newDetail andResultStat:newResultStat] autorelease];
}

- (void)dealloc
{
    [timestamp release];
    [summary release];
    [detail release];

    [super dealloc];
}


@end

@interface ConfigurationData ()
- (void)logWhatWeAreAboutToDo:(NavigationControllerType)navigationControllerType;
@end

@implementation ConfigurationData
@synthesize resultsArray;
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

@synthesize numberOfDefaultImages;
@synthesize numberOfDefaultSongs;
@synthesize numberOfDefaultVideos;
@synthesize numberOfDefaultActionLinks;

@synthesize activityAction;
@synthesize activityUrl;
@synthesize activityTitle;
@synthesize activityDescription;

@synthesize applicationNavigationController;
@synthesize emailObjectToHtml;
@synthesize emailObjectToShortenAllUrls;
@synthesize emailObjectToShortenBadUrls;
@synthesize emailObjectToShortenNonexistentUrls;
@synthesize emailObjectToShortenSomeUrls;
@synthesize smsObjectToShortenBadUrls;
@synthesize smsObjectToShortenNonexistentUrls;
@synthesize smsObjectToShortenUrl;


#pragma mark singleton_methods
//static NSString * const appId = @"appcfamhnpkagijaeinl";
//static NSString * const tokenUrl = @"http://jrauthenticate.appspot.com/login";
static NSString * const appId = @"gifpkeongnkpdhdlejno";
static NSString * const tokenUrl = @"mulciber.janrain.com/token.php";
//static NSString * const appId = @"fccdmobdiafiebjhbghn";
//static NSString * const tokenUrl = nil;

static ConfigurationData *sharedConfigurationData = nil;

//#define DANIEL_1
//#define DANIEL_2
#define VALID_DEFAULTS
#ifdef  VALID_DEFAULTS
static NSString * const defaultAction         = @"is sharing an activity";
static NSString * const defaultUrl            = @"http://www.google.com";
static NSString * const defaultTitle          = @"This is the default title";
static NSString * const defaultDescription    = @"This is the default description";
static NSString * const defaultImageSrc       = @"http://www.janrain.com/sites/default/themes/janrain/logo.png";
static NSString * const defaultImageHref      = @"http://www.janrain.com";
static NSString * const defaultSongSrc        = @"http://www.myspace.com/music/song-embed?songid=25313324&getSwf=true";
static NSString * const defaultVideoSwfsrc    = @"http://vimeo.com/23496497";
static NSString * const defaultVideoImgsrc    = @"http://b.vimeocdn.com/ts/153/117/153117150_100.jpg";
static NSString * const defaultActionLinkText = @"Action Link Text";
static NSString * const defaultActionLinkHref = @"http://janrain.com";
static NSString * const defaultSmsMessage     = @"I am sending you text and this is the message. Here is a url: http://facebook.com";
static NSString * const defaultEmailSubject   = @"I am sending you an email and this is the subject";
static NSString * const defaultEmailBody      =
@"I am sending you an email and this is the body.\nHere are some urls:\n\
http://google.com (google)\n\
https://rpxnow.com (rpxnow)\n\
http://www.janrain.com (janrain)\n\
www.facebook.com (facebook)";
static NSString * const defaultEmailHtmlBody  =
@"<p>I am sending you an email and this is the body <b>in HTML</b>.</p><p>Here are some urls:</p><ul>\
<li><a href=\"http://google.com\">http://google.com</a> (google)</li>\
<li><a href=\"https://rpxnow.com\">(rpxnow)</a></li>\
<li><a href=\"http://www.janrain.com (janrain)\">this link probably won't work...</a></li>\
<li>www.facebook.com (facebook)</li>";
#else
#ifdef DANIEL_1
static NSString * const defaultAction         = @"is sharing an activity";
static NSString * const defaultUrl            = @"http://www.google.com";
static NSString * const defaultTitle          = @"This is the default title";
static NSString * const defaultDescription    = @"This is the default description";
static NSString * const defaultImageSrc       = @"http://www.janrain.com/sites/default/themes/janrain/logo.png";
static NSString * const defaultImageHref      = @"http://www.janrain.com";
static NSString * const defaultSongSrc        = @"http://www.myspace.com/music/song-embed?songid=25313324&getSwf=true";
static NSString * const defaultVideoSwfsrc    = @"http://vimeo.com/23496497";
static NSString * const defaultVideoImgsrc    = @"http://b.vimeocdn.com/ts/153/117/153117150_100.jpg";
static NSString * const defaultActionLinkText = @"Action Link Text";
static NSString * const defaultActionLinkHref = @"http://janrain.com";
static NSString * const defaultSmsMessage     = @"I am sending you text and this is the message. Here is a url: http://facebook.com";
static NSString * const defaultEmailSubject   = @"I am sending you an email and this is the subject";
static NSString * const defaultEmailBody      =
@"I am sending you an email and this is the body.\nHere are some urls:\n\
http://google.com (google)\n\
https://rpxnow.com (rpxnow)\n\
http://www.janrain.com (janrain)\n\
www.facebook.com (facebook)";
static NSString * const defaultEmailHtmlBody  =
@"<p>I am sending you an email and this is the body <b>in HTML</b>.</p><p>Here are some urls:</p><ul>\
<li><a href=\"http://google.com\">http://google.com</a> (google)</li>\
<li><a href=\"https://rpxnow.com\">(rpxnow)</a></li>\
<li><a href=\"http://www.janrain.com (janrain)\">this link probably won't work...</a></li>\
<li>www.facebook.com (facebook)</li>";
#else
#ifdef DANIEL_2
static NSString * const defaultAction         = @"something different";
static NSString * const defaultUrl            = @"http://www.google.com";
static NSString * const defaultTitle          = @"This is the default title";
static NSString * const defaultDescription    = @"This is the default description";
static NSString * const defaultImageSrc       = @"http://www.janrain.com/sites/default/themes/janrain/logo.png";
static NSString * const defaultImageHref      = @"http://www.janrain.com";
static NSString * const defaultSongSrc        = @"http://www.myspace.com/music/song-embed?songid=25313324&getSwf=true";
static NSString * const defaultVideoSwfsrc    = @"http://vimeo.com/23496497";
static NSString * const defaultVideoImgsrc    = @"http://b.vimeocdn.com/ts/153/117/153117150_100.jpg";
static NSString * const defaultActionLinkText = @"Action Link Text";
static NSString * const defaultActionLinkHref = @"http://janrain.com";
static NSString * const defaultSmsMessage     = @"I am sending you text and this is the message. Here is a url: http://facebook.com";
static NSString * const defaultEmailSubject   = @"I am sending you an email and this is the subject";
static NSString * const defaultEmailBody      =
@"I am sending you an email and this is the body.\nHere are some urls:\n\
http://google.com (google)\n\
https://rpxnow.com (rpxnow)\n\
http://www.janrain.com (janrain)\n\
www.facebook.com (facebook)";
static NSString * const defaultEmailHtmlBody  =
@"<p>I am sending you an email and this is the body <b>in HTML</b>.</p><p>Here are some urls:</p><ul>\
<li><a href=\"http://google.com\">http://google.com</a> (google)</li>\
<li><a href=\"https://rpxnow.com\">(rpxnow)</a></li>\
<li><a href=\"http://www.janrain.com (janrain)\">this link probably won't work...</a></li>\
<li>www.facebook.com (facebook)</li>";
#endif
#endif
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

        defaultActivityEmailHtml  = [[JREmailObject alloc] initWithSubject:defaultEmailSubject
                                                            andMessageBody:defaultEmailHtmlBody
                                                                    isHtml:YES
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

    return [[((ConfigurationData*)[super allocWithZone:nil]) init] autorelease];
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

- (void)clearResultsArray
{
    [resultsArray removeAllObjects];
}

- (NSString *)getCurrentTime
{
 /* Get the approximate timestamp of the user's log in */
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setTimeStyle:NSDateFormatterLongStyle];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];

    return [dateFormatter stringFromDate:today];
}

- (void)addResultObjectToResultsArray:(ResultObject *)resultObject
                        andLogMessage:(NSString *)logMessage ofType:(LogMessageType)logMessageType
{
    if (!resultsArray)
        resultsArray = [[NSMutableArray alloc] initWithCapacity:10];

    [resultsArray addObject:resultObject];

    switch (logMessageType)
    {
        case LMDebug: DLog(@"%@\n\n", logMessage);
            break;
        case LMWarn:  WLog(@"%@\n\n", logMessage);
            break;
        case LMError: ELog(@"%@\n\n", logMessage);
            break;
        case LMInfo:  ILog(@"%@\n\n", logMessage);
            break;
        case LMAll:   ALog(@"%@\n\n", logMessage);
            break;
        case LMNone:  // Fall through ...
        default:
            break;
    }
}

- (void)addActivityImageWithSrc:(NSString *)src andHref:(NSString *)href
{
    if (!activityMediaArray)
        activityMediaArray = [[NSMutableArray alloc] initWithCapacity:5];

    JRImageMediaObject *image = [JRImageMediaObject imageMediaObjectWithSrc:src andHref:href];

    if (!image)
        [self addResultObjectToResultsArray:[ResultObject resultObjectWithTimestamp:[self getCurrentTime]
                                                                            summary:@"Attempt to add image failed"
                                                                             detail:[NSString stringWithFormat:
@"You tried to create a JRImageMediaObject, but result was nil.  \n\
No image was added to the media array. \n\
This may or may not have been your intention.\n\
src : %@ \n href: %@\n", src, href]
                                                                      andResultStat:RSBadParametersRecoverableFailure]
                              andLogMessage:@"You tried to create a JRImageMediaObject, but result was nil.  No image was added to the media array."
                                     ofType:LMWarn];
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
        [self addResultObjectToResultsArray:[ResultObject resultObjectWithTimestamp:[self getCurrentTime]
                                                                            summary:@"Attempt to add song failed"
                                                                             detail:[NSString stringWithFormat:
@"You tried to create a JRMp3MediaObject, but result was nil.  \n\
No song was added to the media array. \n\
This may or may not have been your intention.\n\
src   : %@ \n title : %@ \n artist: %@ \n album : %@\n", src, title, artist, album]
                                                                      andResultStat:RSBadParametersRecoverableFailure]
                              andLogMessage:@"You tried to create a JRMp3MediaObject, but result was nil.  No song was added to the media array."
                                     ofType:LMWarn];
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
        [self addResultObjectToResultsArray:[ResultObject resultObjectWithTimestamp:[self getCurrentTime]
                                                                            summary:@"Attempt to add video failed"
                                                                             detail:[NSString stringWithFormat:
@"You tried to create a JRFlashMediaObject, but result was nil.  \n\
No video was added to the media array. \n\
This may or may not have been your intention.\n\
swfsrc        : %@ \n imgsrc        : %@ \n width         : %u \n height        : %u \n expandedWidth : %u \n expandedHeight: %u\n",
swfsrc, imgsrc, width, height, expandedWidth, expandedHeight]
                                                                      andResultStat:RSBadParametersRecoverableFailure]
                              andLogMessage:@"You tried to create a JRFlashMediaObject, but result was nil.  No video was added to the media array."
                                     ofType:LMWarn];
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
        [self addResultObjectToResultsArray:[ResultObject resultObjectWithTimestamp:[self getCurrentTime]
                                                                            summary:@"Attempt to add email failed"
                                                                             detail:[NSString stringWithFormat:
@"You tried to create a JREmailObject, but result was nil.  \n\
No email was added to the activity. \n\
This may or may not have been your intention.\n\
subject: %@ \n body:    %@\n", subject, body]
                                                                      andResultStat:RSBadParametersRecoverableFailure]
                              andLogMessage:@"You tried to create a JREmailObject, but result was nil. This may or may not have been your intention."
                                     ofType:LMWarn];
}

- (void)addActivitySmsWithMessage:(NSString *)message andUrls:(NSArray *)urls
{
    if (activitySmsObject)
        [activitySmsObject release];

    activitySmsObject = [[JRSmsObject alloc] initWithMessage:message andUrlsToBeShortened:urls];

    if (!activitySmsObject)
        [self addResultObjectToResultsArray:[ResultObject resultObjectWithTimestamp:[self getCurrentTime]
                                                                            summary:@"Attempt to add sms failed"
                                                                             detail:[NSString stringWithFormat:
@"You tried to create a JRSmsObject, but result was nil.  \n\
No sms was added to the activity. \n\
This may or may not have been your intention.\n\
message: %@\n",message]
                                                                      andResultStat:RSBadParametersRecoverableFailure]
                              andLogMessage:@"You tried to create a JRSmsObject, but result was nil. This may or may not have been your intention."
                                     ofType:LMWarn];

}

- (void)checkActivityMediaArray:(NSMutableArray *)array
{
    int numImages = 0;
    int numSongs  = 0;
    int numVideos = 0;

    for (NSObject *object in array)
    {
        if ([object isKindOfClass:[JRImageMediaObject class]])
            numImages++;
        else if ([object isKindOfClass:[JRMp3MediaObject class]])
            numSongs++;
        else if ([object isKindOfClass:[JRFlashMediaObject class]])
            numVideos++;
    }

    if (numImages && numSongs && numVideos)
        [self addResultObjectToResultsArray:[ResultObject resultObjectWithTimestamp:[self getCurrentTime]
                                                                            summary:@"Images, songs, and video added to activity"
                                                                             detail:
@"You have added images, songs, and video to the activity. \n\
Only the images will be used.  The songs and video will be ignored. \n\
This is a property off the providers."
                                                                      andResultStat:RSWarn]
                              andLogMessage:@"Images, songs, and video added to activity. Only the images will be used; the songs and video will be ignored."
                                     ofType:LMWarn];

    else if (numImages && numSongs)
        [self addResultObjectToResultsArray:[ResultObject resultObjectWithTimestamp:[self getCurrentTime]
                                                                            summary:@"Images and songs added to activity"
                                                                             detail:
@"You have added images and songs to the activity. \n\
Only the images will be used.  The songs will be ignored. \n\
This is a property off the providers."
                                                                      andResultStat:RSWarn]
                              andLogMessage:@"Images and songs added to activity. Only the images will be used; the songs will be ignored."
                                     ofType:LMWarn];

    else if (numImages && numVideos)
        [self addResultObjectToResultsArray:[ResultObject resultObjectWithTimestamp:[self getCurrentTime]
                                                                            summary:@"Images and video added to activity"
                                                                             detail:
@"You have added images and video to the activity. \n\
Only the images will be used.  The video will be ignored. \n\
This is a property off the providers."
                                                                      andResultStat:RSWarn]
                              andLogMessage:@"Images and video added to activity. Only the images will be used; the video will be ignored."
                                     ofType:LMWarn];

    else if (numSongs && numVideos)
        [self addResultObjectToResultsArray:[ResultObject resultObjectWithTimestamp:[self getCurrentTime]
                                                                            summary:@"Songs and video added to activity"
                                                                             detail:
@"You have added songs and video to the activity. \n\
Only the songs will be used.  The video will be ignored. \n\
This is a property off the providers."
                                                                      andResultStat:RSWarn]
                              andLogMessage:@"Songs and video added to activity. Only the songs will be used; the video will be ignored."
                                     ofType:LMWarn];


    if (numImages)
    {
        if (numImages > 5)
            [self addResultObjectToResultsArray:[ResultObject resultObjectWithTimestamp:[self getCurrentTime]
                                                                                summary:@"Max number of images exceded"
                                                                                 detail:
@"You have added more than 5 images to the activity. \n\
Facebook only uses 5, and other providers may use less. \n\
This is a property off the providers."
                                                                      andResultStat:RSWarn]
                              andLogMessage:@"Max number of images exceded.  Facebook only allows 5."
                                     ofType:LMWarn];
    }
    else if (numSongs)
    {
        if (numSongs > 1)
            [self addResultObjectToResultsArray:[ResultObject resultObjectWithTimestamp:[self getCurrentTime]
                                                                                summary:@"Max number of songs exceded"
                                                                                 detail:
@"You have added more than 1 song to the activity. \n\
Facebook only uses 1, and other providers may not use any. \n\
This is a property off the providers."
                                                                      andResultStat:RSWarn]
                              andLogMessage:@"Max number of songs exceded.  Facebook only allows 1."
                                     ofType:LMWarn];
    }
    else if (numVideos)
    {
        if (numVideos > 1)
            [self addResultObjectToResultsArray:[ResultObject resultObjectWithTimestamp:[self getCurrentTime]
                                                                                summary:@"Max number of videos exceded"
                                                                                 detail:
@"You have added more than 1 video to the activity. \n\
Facebook only uses 1, and other providers may not use any. \n\
This is a property off the providers."
                                                                      andResultStat:RSWarn]
                              andLogMessage:@"Max number of videos exceded.  Facebook only allows 1."
                                     ofType:LMWarn];
    }
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



- (void)add:(NSInteger)number objects:(NSObject *)object toArray:(NSMutableArray *)array
{
    for (NSInteger i = 0; i < number; i++)
    {
        if (i == 0)
           [array addObject:object];

        else
        {
            if ([object isKindOfClass:[JRImageMediaObject class]])
            {
                JRImageMediaObject *imageMediaObject =
                                           [JRImageMediaObject imageMediaObjectWithSrc:defaultImageSrc
                                                                               andHref:
                                   [NSString stringWithFormat:@"http://www.google.com/search?q=%d&ie=UTF-8&hl=en", i]];

                if (imageMediaObject)
                    [array addObject:imageMediaObject];
            }
            else if ([object isKindOfClass:[JRMp3MediaObject class]])
            {
                ((JRMp3MediaObject *)object).title = [NSString stringWithFormat:@"Song Number %d", i];
                [array addObject:object];
            }
            else if ([object isKindOfClass:[JRFlashMediaObject class]])
            {
                [array addObject:[JRFlashMediaObject flashMediaObjectWithSwfsrc:
                                 [defaultVideoSwfsrc stringByReplacingOccurrencesOfString:@"25313324"
                                                                               withString:[NSString stringWithFormat:@"2531332%d", i]]
                                                                      andImgsrc:defaultVideoImgsrc]];

            }
            else if ([object isKindOfClass:[JRActionLink class]])
            {
                ((JRActionLink *)object).text = [NSString stringWithFormat:@"%@ %d", defaultActionLinkText, i];
                [array addObject:object];
            }
        }
    }
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
            [self addResultObjectToResultsArray:[ResultObject resultObjectWithTimestamp:[self getCurrentTime]
                                                                                summary:@"Attempt to add activity failed"
                                                                                 detail:[NSString stringWithFormat:
@"You tried to create a JRActivityObject, but result was nil.  \n\
Without an activity, sharing will not work. \n\
This may or may not have been your intention.\n"]
                                                                          andResultStat:RSBadParametersPermanentFailure]
                                  andLogMessage:@"You tried to create a JRActivityObject, but result was nil.  Without an activity, sharing will not work. This may or may not have been your intention."
                                         ofType:LMWarn];


    }

    if (activityUrl)
        [activity setUrl:activityUrl];
    else if (activityAddDefaultUrl)
        [activity setUrl:defaultActivityUrl];
    else ; // Do nothing

    if (!activity.url)
        [self addResultObjectToResultsArray:[ResultObject resultObjectWithTimestamp:[self getCurrentTime]
                                                                            summary:@"Sharing an activity with no url"
                                                                             detail:
@"The activity you are sharing does not have a url. \n\
If you share an activity without a url, some providers will thunk to set_status, \
and not share any of the rich data (e.g., images, the title and description, etc.). \n\
This may have been intentional or this may have been caused by passing an invalid url."
                                                                      andResultStat:RSInfo]
                              andLogMessage:@"Sharing an activity with no url. This may have been intentional or this may have been caused by passing an invalid url."
                                     ofType:LMInfo];

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
            [self add:numberOfDefaultImages objects:defaultActivityImage toArray:activityMediaArray];//[activityMediaArray addObject:defaultActivityImage];

        if (activityAddDefaultSong)
            [self add:numberOfDefaultSongs objects:defaultActivitySong toArray:activityMediaArray];//[activityMediaArray addObject:defaultActivitySong];

        if (activityAddDefaultVideo)
            [self add:numberOfDefaultVideos objects:defaultActivityVideo toArray:activityMediaArray];//[activityMediaArray addObject:defaultActivityVideo];
    }

    [self checkActivityMediaArray:activityMediaArray];

    if (activityAddDefaultActionLinks)
    {
        if (!activityActionLinksArray)
            activityActionLinksArray = [[NSMutableArray alloc] initWithCapacity:1];

        [self add:numberOfDefaultActionLinks objects:defaultActivityActionLink toArray:activityActionLinksArray];//[activityActionLinksArray addObject:defaultActivityActionLink];

        if (numberOfDefaultActionLinks > 1)
            [self addResultObjectToResultsArray:[ResultObject resultObjectWithTimestamp:[self getCurrentTime]
                                                                                summary:@"Max number of action links exceded"
                                                                                 detail:
@"You have added more than 1 action link to the activity. \n\
Facebook only uses 1, and other providers may not use any. \n\
This is a property off the providers."
                                                                          andResultStat:RSWarn]
                                  andLogMessage:@"Max number of songs exceded.  Facebook only allows 1."
                                         ofType:LMWarn];

    }

    if (activityAddDefaultProperties)
    {
        if (!activityPropertiesDictionary)
            activityPropertiesDictionary = [[NSMutableDictionary alloc] initWithCapacity:1];

        [activityPropertiesDictionary addEntriesFromDictionary:defaultActivityProperties];
    }

    if (activityEmailObject)
       activity.email = activityEmailObject;
    else if (activityAddDefaultEmailObject && emailObjectToHtml)
        activity.email = defaultActivityEmailHtml;
    else if (activityAddDefaultEmailObject && !emailObjectToHtml)
        activity.email = defaultActivityEmail;
    else ; // Do nothing

    if (activityAddDefaultEmailObject && (emailObjectToShortenAllUrls || emailObjectToShortenSomeUrls ||
        emailObjectToShortenBadUrls || emailObjectToShortenNonexistentUrls))
    {
        NSArray *urls = nil;
        if (emailObjectToShortenAllUrls)
            urls = [NSArray arrayWithObjects:
                 @"http://google.com", @"https://rpxnow.com", @"http://www.janrain.com", @"www.facebook.com", nil];

        else if (emailObjectToShortenSomeUrls)
            urls = [NSArray arrayWithObjects:
                 @" http://google.com   ", @"http://www.janrain.com", nil];

        else if (emailObjectToShortenNonexistentUrls)
            urls = [NSArray arrayWithObjects:
                 @"http://linkedin.com", @"https://ebay.com", @"http://www.uiuc.edu", nil];

        else if (emailObjectToShortenBadUrls)
            urls = [NSArray arrayWithObjects:
                 @"this is not a valid url", @"$#@!$@))@()!$*(*!)", @"http://fkdjklafjdklajkfldas.com", nil];

        activity.email.urls = urls;
    }

    if (activitySmsObject)
        activity.sms = activitySmsObject;
    else if (activityAddDefaultSmsObject)
        activity.sms = defaultActivitySms;
    else ; // Do nothing

    if (activityAddDefaultSmsObject && (smsObjectToShortenUrl ||
        smsObjectToShortenNonexistentUrls || smsObjectToShortenBadUrls))
    {
        NSArray *urls = nil;
        if (smsObjectToShortenUrl)
            urls = [NSArray arrayWithObjects:
                 @"http://facebook.com", nil];

        else if (smsObjectToShortenNonexistentUrls)
            urls = [NSArray arrayWithObjects:
                 @"http://linkedin.com", @"https://ebay.com", @"http://www.uiuc.edu", nil];

        else if (smsObjectToShortenBadUrls)
            urls = [NSArray arrayWithObjects:
                 @"this is not a valid url", @"$#@!$@))@()!$*(*!)", @"http://fkdjklafjdklajkfldas.com", nil];

        activity.email.urls = urls;
    }

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
    [self logWhatWeAreAboutToDo:navigationControllerType];

    DLog(@"navigationControllerType: %u", (int)navigationControllerType);

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
                UINavigationController *navigationController;

                if (navigationControllerType == CDNavigationControllerTypeLibrary ||
                    navigationControllerType == CDNavigationControllerTypeApplication)
                {
                    if (iPad) navigationController = customNavigationController;
                    else navigationController = applicationNavigationController;
                }
                else
                {
                    navigationController = customNavigationController;
                }

                if (navigationController == applicationNavigationController)
                    [customInterface setObject:applicationNavigationController
                                        forKey:kJRApplicationNavigationController];
                else
                    [customInterface setObject:customNavigationController
                                        forKey:kJRCustomModalNavigationController];

                [embeddedTable setUsingNavigationController:navigationController];

                [customInterface setObject:embeddedTable.view
                                    forKey:kJRProviderTableHeaderView];
                [customInterface setObject:@"Sign in with a social provider"
                                    forKey:kJRProviderTableSectionHeaderTitleString];
            }

            if (signinAlwaysForceReauth)
                [jrEngage alwaysForceReauthentication:YES];
            else
                [jrEngage alwaysForceReauthentication:NO];

            if (signinExcludeProviders && excludeProvidersArray)
            {
                [customInterface setObject:excludeProvidersArray forKey:kJRRemoveProvidersFromAuthentication];
            }
        }

        [jrEngage showAuthenticationDialogWithCustomInterfaceOverrides:customInterface];
    }
    else if (signInOrSharing == CDSharing)
    {
        [self buildActivity];
        [jrEngage showSocialPublishingDialogWithActivity:activity andCustomInterfaceOverrides:customInterface];
        [activity release], activity = nil;
    }
}

- (void)triggerAuthenticationDidCancel:(id)sender
{
    [jrEngage authenticationDidCancel];
}

- (void)jrEngageDialogDidFailToShowWithError:(NSError*)error
{
    NSString *message = [NSString stringWithFormat:
@"Library dialog failed to show. \n\
                 error     : %@ \n\
                 error code: %u", [error localizedDescription], [error code]];

    [self addResultObjectToResultsArray:
            [ResultObject resultObjectWithTimestamp:[self getCurrentTime]
                                            summary:@"Library dialog failed to show"
                                             detail:message
                                      andResultStat:RSErrorStarting]
                          andLogMessage:message
                                 ofType:LMError];
}

- (void)jrAuthenticationDidNotComplete
{
    NSString *message = @"Authentication did not complete. This is most likely due to the user canceling.";

    [self addResultObjectToResultsArray:
            [ResultObject resultObjectWithTimestamp:[self getCurrentTime]
                                            summary:@"Authentication did not complete"
                                             detail:message
                                      andResultStat:RSUserCanceled]
                          andLogMessage:message
                                 ofType:LMInfo];

    if ([delegate respondsToSelector:@selector(libraryDialogClosed)])
        [delegate libraryDialogClosed];
}

- (void)jrAuthenticationDidSucceedForUser:(NSDictionary*)auth_info forProvider:(NSString*)provider
{
    NSString *message = [NSString stringWithFormat:
@"Authentication completed for user. \n\
user: \n %@ \n provider: %@", [auth_info description], provider];

    [self addResultObjectToResultsArray:
            [ResultObject resultObjectWithTimestamp:[self getCurrentTime]
                                            summary:@"Authentication completed for user"
                                             detail:message
                                      andResultStat:RSAuthSucceeded]
                          andLogMessage:@"Authentication completed for user"
                                 ofType:LMInfo];

    if ([delegate respondsToSelector:@selector(libraryDialogClosed)])
        [delegate libraryDialogClosed];
}

- (void)jrAuthenticationDidFailWithError:(NSError*)error forProvider:(NSString*)provider
{
    NSString *message = [NSString stringWithFormat:
@"Authentication failed for provider: %@. \n\
                  error:      %@ \n\
                  error code: %u", provider, [error localizedDescription], [error code]];

    [self addResultObjectToResultsArray:
            [ResultObject resultObjectWithTimestamp:[self getCurrentTime]
                                            summary:[NSString stringWithFormat:@"Authentication failed for provider: %@", provider]
                                             detail:message
                                      andResultStat:RSPermanentAuthFailure]
                          andLogMessage:[NSString stringWithFormat:@"Authentication failed for provider: %@", provider]
                                 ofType:LMError];

    if ([delegate respondsToSelector:@selector(libraryDialogClosed)])
        [delegate libraryDialogClosed];
}

- (void)jrAuthenticationDidReachTokenUrl:(NSString*)tokenUrl withResponse:(NSURLResponse*)response
                              andPayload:(NSData*)tokenUrlPayload forProvider:(NSString*)provider
{
    NSString *message = [NSString stringWithFormat:
@"Successfully reached token url: %@. \n\
token url response: \n %@ \n provider: %@",
tokenUrl,  [[[NSString alloc] initWithData:tokenUrlPayload encoding:NSASCIIStringEncoding] autorelease], provider];

    [self addResultObjectToResultsArray:
            [ResultObject resultObjectWithTimestamp:[self getCurrentTime]
                                            summary:@"Successfully reached token url"
                                             detail:message
                                      andResultStat:RSTokenUrlSucceeded]
                          andLogMessage:@"Successfully reached token url"
                                 ofType:LMInfo];
}

- (void)jrAuthenticationCallToTokenUrl:(NSString*)tokenUrl didFailWithError:(NSError*)error
                           forProvider:(NSString*)provider
{
    NSString *message = [NSString stringWithFormat:
@"Token url failed for provider: %@. \n\
                  token url:  %@ \n\
                  error:      %@ \n\
                  error code: %u", provider, tokenUrl, [error localizedDescription], [error code]];

    [self addResultObjectToResultsArray:
            [ResultObject resultObjectWithTimestamp:[self getCurrentTime]
                                            summary:[NSString stringWithFormat:@"Token url failed for provider: %@", provider]
                                             detail:message
                                      andResultStat:RSTokenUrlFailure]
                          andLogMessage:[NSString stringWithFormat:@"Token url failed for provider: %@", provider]
                                 ofType:LMError];
}

- (void)jrSocialDidNotCompletePublishing
{
    NSString *message = @"Publishing did not complete. This is most likely due to the user canceling.";

    [self addResultObjectToResultsArray:
            [ResultObject resultObjectWithTimestamp:[self getCurrentTime]
                                            summary:@"Publishing did not complete"
                                             detail:message
                                      andResultStat:RSUserCanceled]
                          andLogMessage:message
                                 ofType:LMInfo];


    if ([delegate respondsToSelector:@selector(libraryDialogClosed)])
        [delegate libraryDialogClosed];
}

- (void)jrSocialDidCompletePublishing
{
    NSString *message = @"Publishing complete.  The user has shared the activity on one or more providers.";

    [self addResultObjectToResultsArray:
            [ResultObject resultObjectWithTimestamp:[self getCurrentTime]
                                            summary:@"Publishing complete"
                                             detail:message
                                      andResultStat:RSPublishCompleted]
                          andLogMessage:message
                                 ofType:LMInfo];

    if ([delegate respondsToSelector:@selector(libraryDialogClosed)])
        [delegate libraryDialogClosed];
}

- (void)jrSocialDidPublishActivity:(JRActivityObject*)theActivity forProvider:(NSString*)provider
{
    NSString *message = [NSString stringWithFormat:
@"User has successfully shared the activity for provider: %@ \n\
activity: \n %@", provider, [[theActivity dictionaryForObject] description]];

    [self addResultObjectToResultsArray:
            [ResultObject resultObjectWithTimestamp:[self getCurrentTime]
                                            summary:@"User has successfully shared the activity"
                                             detail:message
                                      andResultStat:RSPublishSucceeded]
                          andLogMessage:[NSString stringWithFormat:
                          @"User has successfully shared the activity for provider: %@", provider]
                                 ofType:LMInfo];
}

- (void)jrSocialPublishingActivity:(JRActivityObject*)theActivity didFailWithError:(NSError*)error
                       forProvider:(NSString*)provider
{
    NSString *message = [NSString stringWithFormat:
@"The activity failed to share for provider: %@. \n\
activity: \n %@ \n error:      %@ \n error code: %u",
provider, [[theActivity dictionaryForObject] description], [error localizedDescription], [error code]];

    [self addResultObjectToResultsArray:
            [ResultObject resultObjectWithTimestamp:[self getCurrentTime]
                                            summary:[NSString stringWithFormat:@"Activity failed to share for provider: %@", provider]
                                             detail:message
                                      andResultStat:RSRecoverableShareFailure]
                          andLogMessage:[NSString stringWithFormat:@"Activity failed to share for provider: %@", provider]
                                 ofType:LMError];
}

- (void)logWhatWeAreAboutToDo:(NavigationControllerType)navigationControllerType
{
    NSString *navType        = nil;
    NSString *padDisplay     = nil;
    NSString *testType       = nil;
    NSMutableString *testing = nil;

    if (navigationControllerType == CDNavigationControllerTypeApplication)
    {
        if (iPad)
        {
            navType = @"We are using the library's navigation controller";

            [self addResultObjectToResultsArray:[ResultObject resultObjectWithTimestamp:[self getCurrentTime]
                                                                                summary:@"Can't use the application's nav controller on the iPad"
                                                                                 detail:
@"You are trying to use the application's navigation controller on the iPad. \n\
This is not allowed.  The library will default to using its own navigation controller or the custom navigation controller."
                                                                          andResultStat:RSWarn]
                                  andLogMessage:@"You are trying to use the application's navigation controller on the iPad. This is not allowed. The library will default to using its own navigation controller or the custom navigation controller."
                                         ofType:LMWarn];
        }
        else
        {
            navType = @"We are using the applications's navigation controller";
        }
    }
    else if (navigationControllerType == CDNavigationControllerTypeCustom)
    {
        navType = @"We are using a custom navigation controller";
    }
    else
    {
        navType = @"We are using the library's navigation controller";
    }

    if (iPad)
    {
        if (usingPopoverFromRect)
            padDisplay = @", and displaying the dialog in a popover from some point on the screen";
        else if (usingPopoverFromBarButtonItem)
            padDisplay = @", and displaying the dialog in a popover from the navigation controller's button";
        else
            padDisplay = @", and displaying the dialog modally";
    }

    if (signInOrSharing == CDSignIn)
    {
        testType = @"Sign-in test started";

        if (signInTestType == CDSignInTestTypeCustomInterface)
            testing = [NSMutableString stringWithString:@"Testing sign-in with different UI customizations. "];

        else if (signInTestType == CDSignInTestTypeProviderConfiguration)
        {
            testing = [NSMutableString stringWithString:@"Testing sign-in with different provider configurations"];
            if (signinAddNativeLogin)
            {
                [testing appendString:@", including adding a native provider"];

                NSString *usingNavController = nil;

                if (navigationControllerType == CDNavigationControllerTypeLibrary ||
                    navigationControllerType == CDNavigationControllerTypeApplication)
                {
                    if (iPad) usingNavController = @"custom";
                    else usingNavController = @"application's";
                }

                if (usingNavController)
                {
                    NSString *message = [NSString stringWithFormat:
@"You can't add the native provider to sign-in and use %@ navigation controller. \
Using the %@ navigation controller instead.", (iPad ? @" application or library's " : @"library's"), usingNavController];

                    [self addResultObjectToResultsArray:[ResultObject resultObjectWithTimestamp:[self getCurrentTime]
                                                                                        summary:@"Wrong navigation controller used with the native provider"
                                                                                         detail:message
                                                                                  andResultStat:RSWarn]
                                          andLogMessage:message
                                                 ofType:LMWarn];

                    navType = [NSString stringWithFormat:@"We are using the %@ navigation controller", usingNavController];
                }
            }

            if (signinAlwaysForceReauth)
                [testing appendString:@", and we are always forced to reauthenticate"];

            if (signinExcludeProviders)
                [testing appendString:[NSString stringWithFormat:@", and we are excluding the providers: %@", [excludeProvidersArray description]]];

            [testing appendString:@". "];
        }
        else
        {
            testing = [NSMutableString stringWithString:@"Testing basic sign-in. "];
        }
    }
    else if (signInOrSharing == CDSharing)
    {
        testType = @"Sign-in test started";

        if (sharingTestType == CDSharingTestTypeActivityChanges)
            testing = [NSMutableString stringWithString:@"Testing sharing by adding different default objects to the activity. "];

        else if (sharingTestType == CDSharingTestTypeBadActivityParams)
            testing = [NSMutableString stringWithString:@"Testing sharing by adding different, custom values for the objects added to the activity. "];

        else if (sharingTestType == CDSharingTestTypeCustomInterface)
            testing = [NSMutableString stringWithString:@"Testing sharing with different UI customizations. "];

        else if (sharingTestType == CDSharingTestTypeEmailSms)
            testing = [NSMutableString stringWithString:@"Testing sharing with different email and sms objects added. "];

        else
            testing = [NSMutableString stringWithString:@"Testing sharing with a basic activity. "];
    }

    if (testing && navType)
    {
        [testing appendString:navType];

        if (padDisplay)
            [testing appendString:padDisplay];

        [testing appendString:@"."];

        [self addResultObjectToResultsArray:[ResultObject resultObjectWithTimestamp:[self getCurrentTime]
                                                                            summary:testType
                                                                             detail:testing
                                                                      andResultStat:RSGood]
                              andLogMessage:testing
                                     ofType:LMInfo];
    }
}

/* Never gets called; just here to stop AppCode from giving me a million warnings */
-(void)dealloc
{
    [customInterface release];
    [activity release];
    [activityPropertiesDictionary release];
    [activityActionLinksArray release];
    [activityMediaArray release];
    [activitySmsObject release];
    [activityEmailObject release];
    [resultsArray release];
    [embeddedTable release];
    [customNavigationController release];
    [defaultActivityProperties release];
    [defaultActivityActionLink release];
    [defaultActivitySms release];
    [defaultActivityEmail release];
    [defaultActivityVideo release];
    [defaultActivitySong release];
    [defaultActivityImage release];
    [delegate release];
    [excludeProvidersArray release];
    [activityAction release];
    [activityUrl release];
    [activityTitle release];
    [activityDescription release];
    [applicationNavigationController release];
    [defaultActivityEmailHtml release];

    [super dealloc];
}

@end
