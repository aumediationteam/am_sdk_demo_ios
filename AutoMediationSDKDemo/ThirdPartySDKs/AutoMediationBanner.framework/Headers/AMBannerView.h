//
//  AMBannerView.h
//  AMBanner
//
//  Created by Martin Lau on 18/09/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AMBannerDelegate;
@interface AMBannerView : UIView
//to be move into a internal category
@property(nonatomic, weak) id<AMBannerDelegate> delegate;
@end
