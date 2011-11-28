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


#import <Foundation/Foundation.h>
#import "CustomViewBuilder.h"
#import "ApiTesterAppDelegate.h"
#import "SignInEmbeddedNativeLoginViewController.h"
#import "JREngage.h"
#import "JREngage+CustomInterface.h"

#define JANRAIN_BLUE_100 [UIColor colorWithRed:0.102 green:0.33 blue:0.48 alpha:1.0]
#define JANRAIN_BLUE_20  [UIColor colorWithRed:0.102 green:0.33 blue:0.48 alpha:0.2]
#define JANRAIN_BLUE_80  [UIColor colorWithRed:0.102 green:0.33 blue:0.48 alpha:0.8]

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
    CDSharingTestTypeBadActivityParams,
} SharingTestType;

typedef enum
{
    CDNavigationControllerTypeLibrary,
    CDNavigationControllerTypeApplication,
    CDNavigationControllerTypeCustom,
} NavigationControllerType;

typedef enum
{
    LMDebug,
    LMWarn,
    LMError,
    LMInfo,
    LMAll,
    LMNone,
} LogMessageType;

typedef enum
{
    RSNone,
    RSInfo,
    RSGood,
    RSError,
    RSWarn,
    RSErrorStarting,
    RSAuthSucceeded,
    RSPermanentAuthFailure,
    RSRecoverableAuthFailure,
    RSPublishSucceeded,
    RSPermanentShareFailure,
    RSRecoverableShareFailure,
    RSPublishCompleted,
    RSTokenUrlSucceeded,
    RSTokenUrlFailure,
    RSUserCanceled,
    RSBadParametersRecoverableFailure,
    RSBadParametersPermanentFailure,
    RSDone,
} ResultStat;

@interface ResultObject : NSObject
{
    NSString   *timestamp;
    NSString   *summary;
    NSString   *detail;
    ResultStat  resultStat;
}
@property (nonatomic, readonly) NSString   *timestamp;
@property (nonatomic, readonly) NSString   *summary;
@property (nonatomic, readonly) NSString   *detail;
@property (nonatomic, readonly) ResultStat  resultStat;
- (id)initWithTimestamp:(NSString *)newTimestamp summary:(NSString *)newSummary detail:(NSString *)newDetail andResultStat:(ResultStat)newResultStat;
+ (id)resultObjectWithTimestamp:(NSString *)newTimestamp summary:(NSString *)newSummary detail:(NSString *)newDetail andResultStat:(ResultStat)newResultStat;
@end


@protocol ConfigurationDataDelegate <NSObject>
@optional
- (void)libraryDialogClosed;
//- (void)triggerAuthenticationDidCancel:(id)sender
//;
//- (void)jrEngageDialogDidFailToShowWithError:(NSError*)error;
//
//- (void)jrAuthenticationDidNotComplete
//;
//- (void)jrAuthenticationDidSucceedForUser:(NSDictionary*)auth_info
//                              forProvider:(NSString*)provider
//;
//- (void)jrAuthenticationDidFailWithError:(NSError*)error
//                             forProvider:(NSString*)provider
//;
//- (void)jrAuthenticationDidReachTokenUrl:(NSString*)tokenUrl
//                            withResponse:(NSURLResponse*)response
//                              andPayload:(NSData*)tokenUrlPayload
//                             forProvider:(NSString*)provider;
//
//- (void)jrAuthenticationCallToTokenUrl:(NSString*)tokenUrl
//                      didFailWithError:(NSError*)error
//                           forProvider:(NSString*)provider;
//
//- (void)jrSocialDidNotCompletePublishing;
//
//- (void)jrSocialDidCompletePublishing;
//
//- (void)jrSocialDidPublishActivity:(JRActivityObject*)activity
//                       forProvider:(NSString*)provider;
//
//- (void)jrSocialPublishingActivity:(JRActivityObject*)activity
//                  didFailWithError:(NSError*)error
//                       forProvider:(NSString*)provider;
@end


@interface ConfigurationData : NSObject <JREngageDelegate>
{
    JREngage *jrEngage;
    id<ConfigurationDataDelegate> delegate;

    NSMutableArray *resultsArray;

    UINavigationController *applicationNavigationController;
    UINavigationController *customNavigationController;
    EmbeddedTableViewController *embeddedTable;

    CGRect                   popoverRect;
    UIPopoverArrowDirection  popoverArrowDirection;
    UIBarButtonItem         *popoverBarButton;
    BOOL                     usingPopoverFromRect;
    BOOL                     usingPopoverFromBarButtonItem;

    BOOL iPad;

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

    BOOL sharingBackgroundColor;
    BOOL sharingBackgroundImageView;
    BOOL sharingTitleView;
    BOOL sharingTitleString;

    BOOL signinAddNativeLogin;
    BOOL signinAlwaysForceReauth;
    BOOL signinSkipUserLanding;
    BOOL signinExcludeProviders;
    BOOL signinStraightToProvider;

    NSArray  *excludeProvidersArray;
    NSString *goStraightToProvider;

    JRActivityObject    *activity;

    NSString *activityAction;
    NSString *activityUrl;
    NSString *activityTitle;
    NSString *activityDescription;

    NSMutableArray      *activityMediaArray;
    NSMutableArray      *activityActionLinksArray;
    NSMutableDictionary *activityPropertiesDictionary;

    JREmailObject *activityEmailObject;
    JRSmsObject   *activitySmsObject;

 /* Default activity properties, which are set in the constructor using static, constant strings; The static constant
    strings can be changed to test various things. Also, default activity properties can be added to an activity
    independently, to allow for testing various configurations. */
    NSString *defaultActivityAction;
    NSString *defaultActivityUrl;
    NSString *defaultActivityTitle;
    NSString *defaultActivityDescription;

    JRImageMediaObject  *defaultActivityImage;
    JRMp3MediaObject    *defaultActivitySong;
    JRFlashMediaObject  *defaultActivityVideo;
    JREmailObject       *defaultActivityEmail;
    JREmailObject       *defaultActivityEmailHtml;
    JRSmsObject         *defaultActivitySms;
    JRActionLink        *defaultActivityActionLink;
    NSMutableDictionary *defaultActivityProperties;

    NSInteger numberOfDefaultImages;
    NSInteger numberOfDefaultSongs;
    NSInteger numberOfDefaultVideos;
    NSInteger numberOfDefaultActionLinks;

    BOOL activityAddDefaultAction;
    BOOL activityAddDefaultUrl;
    BOOL activityAddDefaultTitle;
    BOOL activityAddDefaultDescription;
    BOOL activityAddDefaultImage;
    BOOL activityAddDefaultSong;
    BOOL activityAddDefaultVideo;
    BOOL activityAddDefaultActionLinks;
    BOOL activityAddDefaultProperties;
    BOOL activityAddDefaultEmailObject;
    BOOL activityAddDefaultSmsObject;

    BOOL emailObjectToHtml;
    BOOL emailObjectToShortenAllUrls;
    BOOL emailObjectToShortenSomeUrls;
    BOOL emailObjectToShortenNonexistentUrls;
    BOOL emailObjectToShortenBadUrls;

    BOOL smsObjectToShortenUrl;
    BOOL smsObjectToShortenNonexistentUrls;
    BOOL smsObjectToShortenBadUrls;

    NSMutableDictionary *customInterface;
}

+ (ConfigurationData*)sharedConfigurationData;
@property (nonatomic, copy, readonly) NSMutableArray *resultsArray;

@property (nonatomic, retain) id<ConfigurationDataDelegate> delegate;

@property BOOL iPad;

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

@property BOOL sharingBackgroundColor;
@property BOOL sharingBackgroundImageView;
@property BOOL sharingTitleView;
@property BOOL sharingTitleString;

@property BOOL signinAddNativeLogin;
@property BOOL signinAlwaysForceReauth;
@property BOOL signinSkipUserLanding;
@property BOOL signinExcludeProviders;
@property BOOL signinStraightToProvider;

@property (copy) NSArray  *excludeProvidersArray;
@property (copy) NSString *goStraightToProvider;

@property BOOL activityAddDefaultAction;
@property BOOL activityAddDefaultUrl;
@property BOOL activityAddDefaultTitle;
@property BOOL activityAddDefaultDescription;
@property BOOL activityAddDefaultImage;
@property BOOL activityAddDefaultSong;
@property BOOL activityAddDefaultVideo;
@property BOOL activityAddDefaultActionLinks;
@property BOOL activityAddDefaultProperties;
@property BOOL activityAddDefaultEmailObject;
@property BOOL activityAddDefaultSmsObject;

@property NSInteger numberOfDefaultImages;
@property NSInteger numberOfDefaultSongs;
@property NSInteger numberOfDefaultVideos;
@property NSInteger numberOfDefaultActionLinks;


@property(nonatomic) BOOL emailObjectToHtml;
@property(nonatomic) BOOL emailObjectToShortenAllUrls;
@property(nonatomic) BOOL emailObjectToShortenBadUrls;
@property(nonatomic) BOOL emailObjectToShortenNonexistentUrls;
@property(nonatomic) BOOL emailObjectToShortenSomeUrls;
@property(nonatomic) BOOL smsObjectToShortenBadUrls;
@property(nonatomic) BOOL smsObjectToShortenNonexistentUrls;
@property(nonatomic) BOOL smsObjectToShortenUrl;

@property (copy) NSString *activityAction;
@property (copy) NSString *activityUrl;
@property (copy) NSString *activityTitle;
@property (copy) NSString *activityDescription;

@property (retain, nonatomic) UINavigationController *applicationNavigationController;

- (void)resetSignIn;
- (void)resetActivity;
- (void)resetCustomInterface;

- (void)clearResultsArray;
- (void)addResultObjectToResultsArray:(ResultObject *)resultObject
                        andLogMessage:(NSString *)logMessage ofType:(LogMessageType)logMessageType;

- (void)addActivityImageWithSrc:(NSString *)src andHref:(NSString *)href;
- (void)addActivitySongWithSrc:(NSString *)src title:(NSString *)title artist:(NSString *)artist andAlbum:(NSString *)album;
- (void)addActivityVideoWithSwfsrc:(NSString *)swfsrc imgsrc:(NSString *)imgsrc width:(NSUInteger)width height:(NSUInteger)height
                     expandedWidth:(NSUInteger)expandedWidth andExpandedHeight:(NSUInteger)expandedHeight;
- (void)addActivityPropertiesWithDictionary:(NSDictionary *)properties;
- (void)addActivityEmailWithSubject:(NSString *)subject body:(NSString *)body isHtml:(BOOL)isHtml andUrls:(NSArray *)urls;
- (void)addActivitySmsWithMessage:(NSString *)message andUrls:(NSArray *)urls;

- (void)setPopoverRect:(CGPoint)rect andArrowDirection:(UIPopoverArrowDirection)arrowDirection;
- (void)setPopoverBarButtonItem:(UIBarButtonItem *)barButton andArrowDirection:(UIPopoverArrowDirection)arrowDirection;

- (void)startTestWithNavigationController:(NavigationControllerType)navigationControllerType;

- (void)triggerAuthenticationDidCancel:(id)sender;
@end