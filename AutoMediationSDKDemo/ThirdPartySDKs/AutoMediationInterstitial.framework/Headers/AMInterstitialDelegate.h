//
//  AMInterstitialDelegate.h
//  AMInterstitial
//
//  Created by Martin Lau on 21/09/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#ifndef AMInterstitialDelegate_h
#define AMInterstitialDelegate_h
#import <AutoMediationSDK/AutoMediationSDK.h>
@protocol AMInterstitialDelegate<AMAdLoadingDelegate>
-(void) interstitialDidShowForPlacementID:(NSString*)placementID;
-(void) interstitialFailedToShowForPlacementID:(NSString*)placementID error:(NSError*)error;
-(void) interstitialDidStartPlayingVideoForPlacementID:(NSString*)placementID;
-(void) interstitialDidEndPlayingVideoForPlacementID:(NSString*)placementID;
-(void) interstitialDidFailToPlayVideoForPlacementID:(NSString*)placementID error:(NSError*)error;
-(void) interstitialDidCloseForPlacementID:(NSString*)placementID;
-(void) interstitialDidClickForPlacementID:(NSString*)placementID;
@end

#endif /* AMInterstitialDelegate_h */
