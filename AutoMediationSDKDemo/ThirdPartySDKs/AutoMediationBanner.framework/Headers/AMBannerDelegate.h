//
//  AMBannerDelegate.h
//  AutoMediationSDK
//
//  Created by Martin Lau on 18/09/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#ifndef AMBannerDelegate_h
#define AMBannerDelegate_h
#import <AutoMediationSDK/AutoMediationSDK.h>
@class AMBannerView;
@protocol AMBannerDelegate<AMAdLoadingDelegate>
-(void) bannerView:(AMBannerView*)bannerView didShowAdWithPlacementID:(NSString*)placementID;
-(void) bannerView:(AMBannerView*)bannerView didClickWithPlacementID:(NSString*)placementID;
-(void) bannerView:(AMBannerView*)bannerView didCloseWithPlacementID:(NSString*)placementID;
@end
#endif /* AMBannerDelegate_h */
