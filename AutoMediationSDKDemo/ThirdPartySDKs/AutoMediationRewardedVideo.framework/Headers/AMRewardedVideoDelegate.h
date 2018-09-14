//
//  AMRewardedVideoDelegate.h
//  AutoMediationSDK
//
//  Created by Martin Lau on 05/07/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#ifndef AMRewardedVideoDelegate_h
#define AMRewardedVideoDelegate_h
#import <AutoMediationSDK/AutoMediationSDK.h>
@protocol AMRewardedVideoDelegate<AMAdLoadingDelegate>
-(void) rewardedVideoDidStartPlayingForPlacementID:(NSString*)placementID;
-(void) rewardedVideoDidEndPlayingForPlacementID:(NSString*)placementID;
-(void) rewardedVideoDidFailToPlayForPlacementID:(NSString*)placementID error:(NSError*)error;
-(void) rewardedVideoDidCloseForPlacementID:(NSString*)placementID rewarded:(BOOL)rewarded;
-(void) rewardedVideoDidClickForPlacementID:(NSString*)placementID;
@end
#endif /* AMRewardedVideoDelegate_h */
