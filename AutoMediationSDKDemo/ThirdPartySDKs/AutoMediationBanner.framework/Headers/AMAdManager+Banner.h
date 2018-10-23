//
//  AMAdManager+Banner.h
//  AMBanner
//
//  Created by Martin Lau on 18/09/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <AutoMediationSDK/AutoMediationSDK.h>

@class AMBannerView;
@interface AMAdManager (Banner)
-(BOOL) bannerAdReadyForPlacementID:(NSString*)placementID;
/*
 nil will be returned if you try to show banner ad for the placementID if it's not ready.
 */
-(nullable AMBannerView*)retrieveBannerViewForPlacementID:(NSString*)placementID;
@end
