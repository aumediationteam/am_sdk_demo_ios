//
//  AMAdManager.h
//  AutoMediationSDK
//
//  Created by Martin Lau on 04/05/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol AMAdLoadingDelegate;
@interface AMAdManager : NSObject
+(instancetype) sharedManager;
@property(nonatomic, strong) NSDictionary *extra;
-(void) loadADWithPlacementID:(NSString*)placementID customData:(NSDictionary*)customData delegate:(id<AMAdLoadingDelegate>)delegate;
-(void) clearCache;
@end
