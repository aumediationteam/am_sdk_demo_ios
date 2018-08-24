//
//  AMNativeADView.h
//  AutoMediationSDK
//
//  Created by Martin Lau on 18/04/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMNativeAd.h"
#import "AMNativeRendering.h"
/**
 * Subclasses are expected to call super when overriding willMoveToSuperview: because it it within this method the base class kick off the rendering process.
 */
@protocol AMNativeADDelegate;
@protocol AMNativeADRenderer;
@class AMNativeADConfiguration;
@interface AMNativeADView : UIView<AMNativeRendering>
/**
 * Subclass implementation has to call [super initSubviews] for the ad view to work properly. By the time this method's called, the ad view is not yet full fledged.
 */
-(void) initSubviews;

/**
 * Create constraints for subviews in this method if you are using autolayout.
 */
-(void) makeConstraintsForSubviews;

/**
 * During ad refreshing, the media view might be removed from it's superview and recreated and added; so the layout logic for media view might be called multiple times with diference media views. You're recommended to use frame-based technique here.
 */
-(void) layoutMediaView;

/**
 * Whether the ad being shown is a video ad.
 */
-(BOOL) isVideoContents;

/*
 * ALWAYS call this method to retrieve the REAL rendered adview.
 */
-(AMNativeADView*)embededAdView;

/**
 * Returns an array containing views that are used to track clicks.
 */
-(NSArray<UIView*>*)clickableViews;

@property(nonatomic, weak) id<AMNativeADDelegate> delegate;
/**
 * The view that is used to play video or other media; it is set by the sdk; might be nil.
 */
@property(nonatomic) UIView *mediaView;
/**
 * The native ad that is being shown.
 */
@property(nonatomic, readonly) AMNativeAd *nativeAd;
@end
