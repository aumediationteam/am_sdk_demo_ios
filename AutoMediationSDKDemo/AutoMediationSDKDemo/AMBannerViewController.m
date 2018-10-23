//
//  AMBannerViewController.m
//  AutoMediationSDKDemo
//
//  Created by Martin Lau on 19/09/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import "AMBannerViewController.h"
@import AutoMediationSDK;
@import AutoMediationBanner;
#ifdef DEBUG
static NSString *const kGDTPlacementID = @"b5ba34f1ab7965";
static NSString *const kTTPlacementID = @"b5ba34f9cd9da4";
static NSString *const kAdmobPlacementID = @"b5ba351d45b55a";
static NSString *const kApplovinPlacementID = @"b5ba3529911aef";
static NSString *const kMopubPlacementID = @"b5bc940c98fe17";
static NSString *const kFlurryPlacementID = @"b5bc940b2cf16a";
static NSString *const kAllPlacementID = @"b5b7fb6feac7bf";
static NSString *const kYeahmobiPlacementID = @"b5bc7ece984253";
static NSString *const kAppnextPlacementID = @"b5bc7ecfe8084b";
#else
static NSString *const kGDTPlacementID = @"b5bc940d49f448";
static NSString *const kTTPlacementID = @"b5bc940e1cfeae";
static NSString *const kAdmobPlacementID = @"b5bc9409ac2779";
static NSString *const kApplovinPlacementID = @"b5bc940be98d5e";
static NSString *const kFacebookPlacementID = @"b5bc9408f80d63";
static NSString *const kMopubPlacementID = @"b5bc940c98fe17";
static NSString *const kFlurryPlacementID = @"b5bc940b2cf16a";
static NSString *const kInmobiPlacementID = @"b5bc940a86ccd7";
static NSString *const kAllPlacementID = @"b5bc940824b3e0";
static NSString *const kYeahmobiPlacementID = @"b5bc940ed26ebe";
static NSString *const kAppnextPlacementID = @"b5bc940faa5f50";
#endif

NSString *const kBannerShownNotification = @"banner_shown";
NSString *const kBannerLoadingFailedNotification = @"banner_failed_to_load";
@interface AMBannerViewController ()<AMBannerDelegate>
@property(nonatomic, readonly) NSString *name;
@property(nonatomic, readonly) NSDictionary<NSString*, NSString*>* placementIDs;
@property(nonatomic, readonly) UIActivityIndicatorView *loadingView;
@property(nonatomic, readonly) UIButton *reloadADButton;
@property(nonatomic, readonly) UIButton *clearAdButton;
@property(nonatomic, readonly) UIButton *showAdButton;
@property(nonatomic, readonly) UILabel *failureTipsLabel;
@property(nonatomic, readonly) UIButton *removeAdButton;
@end

@implementation AMBannerViewController
-(instancetype) initWithPlacementName:(NSString*)name {
    self = [super initWithNibName:nil bundle:nil];
    if (self != nil) {
        _name = name;
        _placementIDs = @{
                          kGDTPlacement:kGDTPlacementID,
                          kTTPlacementName:kTTPlacementID,
                          kAdMobPlacement:kAdmobPlacementID,
                          kApplovinPlacement:kApplovinPlacementID,
                          kFacebookPlacement:kFacebookPlacementID,
                          kMopubPlacementName:kMopubPlacementID,
                          kFlurryPlacement:kFlurryPlacementID,
                          kInmobiPlacement:kInmobiPlacementID,
                          kAllPlacementName:kAllPlacementID,
                          kYeahmobiPlacement:kYeahmobiPlacementID,
                          kAppnextPlacement:kAppnextPlacementID
                          };
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = _name;
    _reloadADButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_reloadADButton addTarget:self action:@selector(reloadADButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [_reloadADButton setTitleColor:_reloadADButton.tintColor forState:UIControlStateNormal];
    [_reloadADButton setTitle:@"Reload AD" forState:UIControlStateNormal];
    _reloadADButton.frame = CGRectMake(.0f, CGRectGetMaxY(self.view.bounds) - 100.0f, (CGRectGetWidth(self.view.bounds) - 40) / 2.0f, 60.0f);
    [self.view addSubview:_reloadADButton];
    
    _showAdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_showAdButton addTarget:self action:@selector(showBanner) forControlEvents:UIControlEventTouchUpInside];
    [_showAdButton setTitleColor:_showAdButton.tintColor forState:UIControlStateNormal];
    [_showAdButton setTitle:@"Show AD" forState:UIControlStateNormal];
    _showAdButton.frame = CGRectMake(CGRectGetMaxX(_reloadADButton.frame) + 40.0f, CGRectGetMinY(_reloadADButton.frame), (CGRectGetWidth(self.view.bounds) - 40) / 2.0f, 60.0f);
    [self.view addSubview:_showAdButton];
    
    _clearAdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_clearAdButton addTarget:self action:@selector(clearAdButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [_clearAdButton setTitleColor:_clearAdButton.tintColor forState:UIControlStateNormal];
    [_clearAdButton setTitle:@"clear cache" forState:UIControlStateNormal];
    _clearAdButton.frame = CGRectMake(.0f, CGRectGetMinY(_reloadADButton.frame) - 20.0f - 60.0f, (CGRectGetWidth(self.view.bounds) - 40) / 2.0f, 60.0f);
    [self.view addSubview:_clearAdButton];
    
    _removeAdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_removeAdButton addTarget:self action:@selector(removeAdButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [_removeAdButton setTitleColor:_removeAdButton.tintColor forState:UIControlStateNormal];
    [_removeAdButton setTitle:@"Remove Ad" forState:UIControlStateNormal];
    _removeAdButton.frame = CGRectMake(CGRectGetMaxX(_clearAdButton.frame) + 40.0f, CGRectGetMinY(_clearAdButton.frame), (CGRectGetWidth(self.view.bounds) - 40) / 2.0f, 60.0f);
    [self.view addSubview:_removeAdButton];
    
    _failureTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(.0f, 64.0f, CGRectGetWidth(self.view.bounds), 400.0f)];
    _failureTipsLabel.text = @"Failed to load ad";
    _failureTipsLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_failureTipsLabel];
    _failureTipsLabel.hidden = YES;
    
    if ([[AMAdManager sharedManager] bannerAdReadyForPlacementID:_placementIDs[_name]]) {
        NSLog(@"AMBannerViewController::banner ad ready, will show");
        [self showBanner];
    } else {
        NSLog(@"AMBannerViewController::banner ad not ready, will load");
        [[AMAdManager sharedManager] loadADWithPlacementID:_placementIDs[_name] extra:@{kExtraInfoRootViewControllerKey:self} customData:nil delegate:self];
    }
}

-(void) reloadADButtonTapped {
    _failureTipsLabel.hidden = YES;
    [self.view addSubview:_loadingView];
    [[AMAdManager sharedManager] loadADWithPlacementID:_placementIDs[_name] extra:@{kExtraInfoRootViewControllerKey:self} customData:nil delegate:self];
}

-(void) removeAdButtonTapped {
    [[self.view viewWithTag:3333] removeFromSuperview];
}

-(void) clearAdButtonTapped {
    [[AMAdManager sharedManager] clearCache];
}

-(void) dealloc {
    NSLog(@"dealloc");
}

-(void) showBanner {
    if ([[AMAdManager sharedManager] bannerAdReadyForPlacementID:_placementIDs[_name]]) {
        NSInteger tag = 3333;
        [[self.view viewWithTag:tag] removeFromSuperview];
        AMBannerView *bannerView = [[AMAdManager sharedManager] retrieveBannerViewForPlacementID:_placementIDs[_name]];
        bannerView.delegate = self;
        bannerView.translatesAutoresizingMaskIntoConstraints = NO;
        bannerView.tag = tag;
        [self.view addSubview:bannerView];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:bannerView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:.0f]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:bannerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:64.0f]];
    } else {
        NSLog(@"Banner ad's not ready for placementID:%@", _placementIDs[_name]);
    }
}

#pragma mark - delegate method(s)
-(void) didFinishLoadingADWithPlacementID:(NSString *)placementID {
    NSLog(@"AMBannerViewController::didFinishLoadingADWithPlacementID:%@", placementID);
    [_loadingView removeFromSuperview];
    [self showBanner];
}

-(void) didFailToLoadADWithPlacementID:(NSString*)placementID error:(NSError*)error {
    NSLog(@"AMBannerViewController::didFailToLoadADWithPlacementID:%@ error:%@", placementID, error);
    _failureTipsLabel.hidden = NO;
#ifdef BANNER_AUTO_TEST
    [[NSNotificationCenter defaultCenter] postNotificationName:kBannerLoadingFailedNotification object:nil];
    [self.navigationController popViewControllerAnimated:NO];
#endif
}

-(void) bannerView:(AMBannerView *)bannerView didShowAdWithPlacementID:(NSString *)placementID {
    NSLog(@"AMBannerViewController::bannerView:didShowAdWithPlacementID:%@", placementID);
#ifdef BANNER_AUTO_TEST
    [[NSNotificationCenter defaultCenter] postNotificationName:kBannerShownNotification object:nil];
    [self.navigationController popViewControllerAnimated:NO];
#endif
}

-(void) bannerView:(AMBannerView*)bannerView didClickWithPlacementID:(NSString*)placementID {
    NSLog(@"AMBannerViewController::bannerView:didClickWithPlacementID:%@", placementID);
}

-(void) bannerView:(AMBannerView*)bannerView didCloseWithPlacementID:(NSString*)placementID {
    NSLog(@"AMBannerViewController::bannerView:didCloseWithPlacementID:%@", placementID);
}
@end
