//
//  AMAdManager+Interstitial.h
//  AMInterstitial
//
//  Created by Martin Lau on 21/09/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMInterstitialDelegate.h"
@interface AMAdManager (Interstitial)
-(BOOL) interstitialReadyForPlacementID:(NSString*)placementID;
-(void) showInterstitialWithPlacementID:(NSString*)placementID inViewController:(UIViewController*)viewController delegate:(id<AMInterstitialDelegate>)delegate;
@end
