//
//  AMAdManager+Native.h
//  AMNative
//
//  Created by Martin Lau on 07/07/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <AutoMediationSDK/AutoMediationSDK.h>
@class AMNativeADView;
@class AMNativeADConfiguration;
@interface AMAdManager (Native)
-(BOOL) nativeAdReadyForPlacementID:(NSString*)placementID;
/**
 * This method uses the renderingViewClass you specify in the configuration to create an instance and:
 1) returns it(for networks Facebook, Inmobi, Mobvista, Admob, Flurry, Applovin) or
 2) adds it to a superView and returns the super view instead(for network Mopub).
 * To retrieve the instance of the class you specify as the rendering view class, cast the returned view to AMNativeADView and call its embededAdView method(the view returned might not be of class AMNativeADView).
 */
-(__kindof UIView*) retriveAdViewWithPlacementID:(NSString*)placementID configuration:(AMNativeADConfiguration*)configuration;
@end
