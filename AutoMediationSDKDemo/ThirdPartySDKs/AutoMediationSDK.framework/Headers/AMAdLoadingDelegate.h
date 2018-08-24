//
//  AMAdLoadingDelegate.h
//  AutoMediationSDK
//
//  Created by Martin Lau on 04/07/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#ifndef AMAdLoadingDelegate_h
#define AMAdLoadingDelegate_h
@protocol AMAdLoadingDelegate<NSObject>
-(void) didFinishLoadingADWithPlacementID:(NSString *)placementID;
-(void) didFailToLoadADWithPlacementID:(NSString*)placementID error:(NSError*)error;
@end
#endif /* AMAdLoadingDelegate_h */
