//
//  AMNativeADDelegate.h
//  AutoMediationSDK
//
//  Created by Martin Lau on 08/05/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#ifndef AMNativeADDelegate_h
#define AMNativeADDelegate_h
#import <AutoMediationSDK/AMAdLoadingDelegate.h>
@class AMNativeADView;
@protocol AMNativeADDelegate<AMAdLoadingDelegate>
-(void) didShowNativeAdInAdView:(AMNativeADView*)adView placementID:(NSString*)placementID;
-(void) didClickNativeAdInAdView:(AMNativeADView*)adView placementID:(NSString*)placementID;
-(void) didStartPlayingVideoInAdView:(AMNativeADView*)adView placementID:(NSString*)placementID;
-(void) didEndPlayingVideoInAdView:(AMNativeADView*)adView placementID:(NSString*)placementID;
@end
#endif /* AMNativeADDelegate_h */
