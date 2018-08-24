//
//  AMAdManager+RewardedVideo.h
//  AutoMediationSDK
//
//  Created by Martin Lau on 05/07/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <AutoMediationSDK/AutoMediationSDK.h>
#import "AMRewardedVideoDelegate.h"
/*
 * A String, used for s2s
 */
extern NSString *const kAMAdLoadingExtraCustomData;
/*
 * Third-party extra data
 */
extern NSString *const kAMAdLoadingExtraKeywordKey;
extern NSString *const kAMAdLoadingExtraUserDataKeywordKey;
extern NSString *const kAMAdLoadingExtraUserIDKey;
extern NSString *const kAMAdLoadingExtraLocationKey;
@interface AMAdManager (RewardedVideo)
-(BOOL) rewardedVideoReadyForPlacementID:(NSString*)placementID;
-(void) showRewardedVideoWithPlacementID:(NSString*)placementID inViewController:(UIViewController*)viewController delegate:(id<AMRewardedVideoDelegate>)delegate;

@end
