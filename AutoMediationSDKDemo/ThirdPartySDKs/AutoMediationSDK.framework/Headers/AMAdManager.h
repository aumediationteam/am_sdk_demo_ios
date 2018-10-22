//
//  AMAdManager.h
//  AutoMediationSDK
//
//  Created by Martin Lau on 04/05/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//The value is (subclass of) UIViewController
extern NSString *const kExtraInfoRootViewControllerKey;
//Banner's ad size, the value is a NSValue wrapped CGSize; for banner ad loading, we only support (320.0f, 50.0f) now, so the value you pass via this key will be ignored.
extern NSString *const kExtraInfoAdSizeKey;
@protocol AMAdLoadingDelegate;
@interface AMAdManager : NSObject
+(instancetype) sharedManager;
@property(nonatomic, strong) NSDictionary *extra;
-(void) loadADWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra customData:(NSDictionary*)customData delegate:(id<AMAdLoadingDelegate>)delegate;
-(void) clearCache;
@end
