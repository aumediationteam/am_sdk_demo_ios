//
//  AMRewardedVideoVideoViewController.m
//  AutoMediationSDKDemo
//
//  Created by Martin Lau on 05/07/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import "AMRewardedVideoVideoViewController.h"
#import "AMAPI.h"
#import "MTAutolayoutCategories.h"
#import "AMAdManager.h"
#import "AMRewardedVideoDelegate.h"
#import "AMAdManager+RewardedVideo.h"

@interface AMRewardedVideoVideoViewController ()<AMRewardedVideoDelegate>
@property(nonatomic, readonly) NSString *name;
@property(nonatomic, readonly) NSDictionary *placementIDs;
@property(nonatomic, readonly) UIActivityIndicatorView *loadingView;
@property(nonatomic, readonly) UIButton *reloadADButton;
@property(nonatomic, readonly) UIButton *clearAdButton;
@property(nonatomic, readonly) UIButton *showAdButton;
@property(nonatomic, readonly) UILabel *failureTipsLabel;
@property(nonatomic, readonly) UIButton *removeAdButton;
@property(nonatomic, readonly) BOOL reload;
@end

NSString *const kTapjoyPlacementName = @"Tapjoy";
NSString *const kChartboostPlacementName = @"Chartboost";
NSString *const kIronsourcePlacementName = @"Ironsource";
NSString *const kVunglePlacementName = @"Vungle";
NSString *const kAdcolonyPlacementName = @"Adcolony";
NSString *const kUnityAdsPlacementName = @"Unity Ads";
NSString *const kTTPlacementName = @"TT";

#ifdef DEBUG
static NSString *const kPlacement0ID = @"b5b7fb88a6a770";
static NSString *const kInmobiPlacementID = @"b5b7e5ad3ddc1b";
static NSString *const kMintegralPlacementID = @"b5b7e59e5e04b8";
static NSString *const kFacebookPlacementID = @"b5b7e59a8a16d3";
static NSString *const kAdMobPlacementID = @"b5b7e59b39d94c";
static NSString *const kApplovinPlacementID = @"b5b7e59d260b59";
static NSString *const kFlurryPlacementID = @"b5b7e59c39ee37";
static NSString *const kMopubPlacementID = @"b5b7e59fd4dece";
static NSString *const kMopubVideoPlacementID = @"b5b7e59fd4dece";
static NSString *const kTapjoyRVPlacementID = @"b5b7e5a1f9b51e";
static NSString *const kChartboostRVPlacementID = @"b5b7e5a0dadeef";
static NSString *const kIronsourceRVPlacementID = @"b5b7e5a31258f5";
static NSString *const kVungleRVPlacementID = @"b5b7e6bc72d82a";
static NSString *const kAdcolonyRVPlacementID = @"b5b7e5a4e0ad96";
static NSString *const kUnityAdsPlacementID = @"b5b7e5a3ddb2e2";
static NSString *const kTTPlacementID = @"b5b7e5a759cafa";
static NSString *const kAllPlacementID = @"b5b7e59940e4b1";
#else
static NSString *const kPlacement0ID = @"b5b7e5a759cafa";
static NSString *const kInmobiPlacementID = @"b5b7fb79d7cac2";
static NSString *const kMintegralPlacementID = @"b5b7fb7cd85522";
static NSString *const kFacebookPlacementID = @"b5b7fb77e62b98";
static NSString *const kAdMobPlacementID = @"b5b7fb78c172d5";
static NSString *const kApplovinPlacementID = @"b5b7fb7bcd44b9";
static NSString *const kFlurryPlacementID = @"b5b7fb7aa6b812";
static NSString *const kMopubPlacementID = @"b5b7fb7dc63953";
static NSString *const kMopubVideoPlacementID = @"b5b7fb7dc63953";
static NSString *const kTapjoyRVPlacementID = @"b5b7fb7ffaa02a";//to be modified
static NSString *const kChartboostRVPlacementID = @"b5b7fb7f30a68d";//to be modified
static NSString *const kIronsourceRVPlacementID = @"b5b7fb84ea75d4";//to be modified
static NSString *const kVungleRVPlacementID = @"b5b7fb86932a8f";//to be modified
static NSString *const kAdcolonyRVPlacementID = @"b5b7fb87f857c1";//to be modified
static NSString *const kUnityAdsPlacementID = @"b5b7fb85b6a71b";//to be modified
static NSString *const kAllPlacementID = @"b5b7fb76e0a44a";
static NSString *const kTTPlacementID = @"b5b7fb88a6a770";
#endif
@implementation AMRewardedVideoVideoViewController
-(instancetype) initWithPlacementName:(NSString*)name {
    self = [super initWithNibName:nil bundle:nil];
    if (self != nil) {
        _name = name;
        _placementIDs = @{
                          kMintegralPlacement:kMintegralPlacementID,
                          kAllPlacementName:kAllPlacementID,
                          kInmobiPlacement:kInmobiPlacementID,
                          kFacebookPlacement:kFacebookPlacementID,
                          kAdMobPlacement:kAdMobPlacementID,
                          kMopubPlacementName:kMopubPlacementID,
                          kMopubVideoPlacementName:kMopubVideoPlacementID,
                          kApplovinPlacement:kApplovinPlacementID,
                          kTapjoyPlacementName:kTapjoyRVPlacementID,
                          kChartboostPlacementName:kChartboostRVPlacementID,
                          kIronsourcePlacementName:kIronsourceRVPlacementID,
                          kVunglePlacementName:kVungleRVPlacementID,
                          kAdcolonyPlacementName:kAdcolonyRVPlacementID,
                          kUnityAdsPlacementName:kUnityAdsPlacementID,
                          kFlurryPlacement:kFlurryPlacementID,
                          kTTPlacementName:kTTPlacementID
                          };
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _name;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _reloadADButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_reloadADButton addTarget:self action:@selector(reloadADButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [_reloadADButton setTitleColor:_reloadADButton.tintColor forState:UIControlStateNormal];
    [_reloadADButton setTitle:@"Reload AD" forState:UIControlStateNormal];
    _reloadADButton.frame = CGRectMake(.0f, CGRectGetMaxY(self.view.bounds) - 100.0f, (CGRectGetWidth(self.view.bounds) - 40) / 2.0f, 60.0f);
    [self.view addSubview:_reloadADButton];
    
    _showAdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_showAdButton addTarget:self action:@selector(showAD) forControlEvents:UIControlEventTouchUpInside];
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
    [_removeAdButton setTitle:@"Ad Ready?" forState:UIControlStateNormal];
    _removeAdButton.frame = CGRectMake(CGRectGetMaxX(_clearAdButton.frame) + 40.0f, CGRectGetMinY(_clearAdButton.frame), (CGRectGetWidth(self.view.bounds) - 40) / 2.0f, 60.0f);
    [self.view addSubview:_removeAdButton];
    
    _failureTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(.0f, 64.0f, CGRectGetWidth(self.view.bounds), 400.0f)];
    _failureTipsLabel.text = @"Failed to load ad";
    _failureTipsLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_failureTipsLabel];
    _failureTipsLabel.hidden = YES;
    
    [AMAdManager sharedManager].extra = @{kAMAdLoadingExtraUserIDKey:@"test_user_id", kAMAdLoadingExtraCustomData:@"test_custom_data"};
}

-(void) removeAdButtonTapped {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[[AMAdManager sharedManager] rewardedVideoReadyForPlacementID:_placementIDs[_name]] ? @"Ready!" : @"Not Yet!" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void) clearAdButtonTapped {
    [[AMAdManager sharedManager] clearCache];
}

-(void) dealloc {
    NSLog(@"dealloc");
}

-(void) reloadADButtonTapped {
    _reload = YES;
    _failureTipsLabel.hidden = YES;
    _reloadADButton.enabled = NO;
    [self.view addSubview:_loadingView];
    [[AMAdManager sharedManager] loadADWithPlacementID:_placementIDs[_name] customData:nil delegate:self];
}

-(void) showAD {
    //Remove previously shown ad first.
    [[AMAdManager sharedManager] showRewardedVideoWithPlacementID:_placementIDs[_name] inViewController:self delegate:self];
}

#pragma mark - loading delegate
-(void) didFinishLoadingADWithPlacementID:(NSString *)placementID {
    NSLog(@"RV Demo: didFinishLoadingADWithPlacementID");
    _failureTipsLabel.hidden = YES;
    _reloadADButton.enabled = YES;
    _showAdButton.enabled = YES;
    [_loadingView removeFromSuperview];
    if (!_reload) [self showAD];
    _reload = NO;
}

-(void) didFailToLoadADWithPlacementID:(NSString*)placementID error:(NSError*)error {
    [_loadingView removeFromSuperview];
    _failureTipsLabel.hidden = NO;
    _reloadADButton.enabled = YES;
    NSLog(@"RV Demo: failed to load:%@", error);
}
#pragma mark - showing delegate
-(void) rewardedVideoDidStartPlayingForPlacementID:(NSString*)placementID {
    NSLog(@"RV Demo: rewardedVideoDidStartPlayingForPlacementID:%@", placementID);
}

-(void) rewardedVideoDidEndPlayingForPlacementID:(NSString*)placementID {
    NSLog(@"RV Demo: rewardedVideoDidEndPlayingForPlacementID:%@", placementID);
}

-(void) rewardedVideoDidFailToPlayForPlacementID:(NSString*)placementID error:(NSError*)error {
    NSLog(@"RV Demo: rewardedVideoDidFailToPlayForPlacementID:%@ error:%@", placementID, error);
}

-(void) rewardedVideoDidCloseForPlacementID:(NSString*)placementID rewarded:(BOOL)rewarded {
    NSLog(@"RV Demo: rewardedVideoDidCloseForPlacementID:%@, rewarded:%@", placementID, rewarded ? @"yes" : @"no");
}

-(void) rewardedVideoDidClickForPlacementID:(NSString*)placementID {
    NSLog(@"RV Demo: rewardedVideoDidClickForPlacementID:%@", placementID);
}
@end
