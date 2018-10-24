//
//  AMADShowViewController.m
//  AutoMediationSDKDemo
//
//  Created by Martin Lau on 17/04/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import "AMADShowViewController.h"
#import "MTAutolayoutCategories.h"
@import AutoMediationSDK;
#ifdef NATIVE_INTEGRATED
@import AutoMediationNative;
#endif

NSString *const kInmobiPlacement = @"Inmobi";
NSString *const kFacebookPlacement = @"Facebook";
NSString *const kAdMobPlacement = @"AdMob";
NSString *const kApplovinPlacement = @"Applovin";
NSString *const kFlurryPlacement = @"Flurry";
NSString *const kMintegralPlacement = @"Mintegral";
NSString *const kMopubPlacementName = @"Mopub";
NSString *const kMopubVideoPlacementName = @"Mopub Video Placement";
NSString *const kGDTPlacement = @"GDT";
NSString *const kGDTTemplatePlacement = @"GDT(Template)";
NSString *const kYeahmobiPlacement = @"Yeahmobi";
NSString *const kAppnextPlacement = @"Appnext";
NSString *const kAllPlacementName = @"All";

#ifdef DEBUG
static NSString *const kPlacement0ID = @"b5b3c9ce05d849";
static NSString *const kInmobiPlacementID = @"b5b7ea464ecc07";
static NSString *const kMintegralPlacementID = @"b5b7ea485828b1";
static NSString *const kFacebookPlacementID = @"b5b7ea44a6d3ca";
static NSString *const kAdMobPlacementID = @"b5b7ea456bb0ec";
static NSString *const kApplovinPlacementID = @"b5b7ea4789562a";
static NSString *const kFlurryPlacementID = @"b5b7ea4a970252";
static NSString *const kMopubPlacementID = @"b5b7ea49415238";
static NSString *const kGDTPlacementID = @"b5bac73f0796e5";
static NSString *const kGDTTemplatePlacementID = @"b5ba34ee81601a";
static NSString *const kMopubVideoPlacementID = @"b5b7fb74d1e080";
static NSString *const kYeahmobiPlacementID = @"b5bc7ec73074a0";
static NSString *const kAppnextPlacementID = @"b5bc7ec86f35e7";
static NSString *const kAllPlacementID = @"b5b7ea43935ea5";
#else
static NSString *const kPlacement0ID = @"b5b7fb70c679a8";
static NSString *const kInmobiPlacementID = @"b5b7fb71a74213";
static NSString *const kMintegralPlacementID = @"b5b7fb74400d3a";
static NSString *const kFacebookPlacementID = @"b5b7fb6feac7bf";
static NSString *const kAdMobPlacementID = @"b5b7fb70c679a8";
static NSString *const kApplovinPlacementID = @"b5b7fb72c2aabe";
static NSString *const kFlurryPlacementID = @"b5b7fb7237ae4b";
static NSString *const kMopubPlacementID = @"b5b7fb74d1e080";
static NSString *const kGDTPlacementID = @"b5bc93f5f47e0e";
static NSString *const kGDTTemplatePlacementID = @"b5bc93f75e1376";
static NSString *const kMopubVideoPlacementID = @"b5b7fb74d1e080";
static NSString *const kYeahmobiPlacementID = @"b5bc93f853669e";
static NSString *const kAppnextPlacementID = @"b5bc93f9493b79";
static NSString *const kAllPlacementID = @"b5b7fb6ebae672";
#endif
#ifdef NATIVE_INTEGRATED
@interface DMADView:AMNativeADView
@property(nonatomic, readonly) UILabel *advertiserLabel;
@property(nonatomic, readonly) UILabel *textLabel;
@property(nonatomic, readonly) UILabel *titleLabel;
@property(nonatomic, readonly) UILabel *ctaLabel;
@property(nonatomic, readonly) UILabel *ratingLabel;
@property(nonatomic, readonly) UIImageView *iconImageView;
@property(nonatomic, readonly) UIImageView *mainImageView;
@property(nonatomic, readonly) UIImageView *sponsorImageView;
@end

@implementation DMADView
-(void) initSubviews {
    [super initSubviews];
    _advertiserLabel = [UILabel autolayoutLabelFont:[UIFont boldSystemFontOfSize:15.0f] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
    [self addSubview:_advertiserLabel];
    
    _titleLabel = [UILabel autolayoutLabelFont:[UIFont boldSystemFontOfSize:18.0f] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
    [self addSubview:_titleLabel];
    
    _textLabel = [UILabel autolayoutLabelFont:[UIFont systemFontOfSize:15.0f] textColor:[UIColor blackColor]];
    [self addSubview:_textLabel];
    
    _ctaLabel = [UILabel autolayoutLabelFont:[UIFont systemFontOfSize:15.0f] textColor:[UIColor blackColor]];
    [self addSubview:_ctaLabel];
    
    _ratingLabel = [UILabel autolayoutLabelFont:[UIFont systemFontOfSize:15.0f] textColor:[UIColor blackColor]];
    [self addSubview:_ratingLabel];
    
    _iconImageView = [UIImageView autolayoutView];
    _iconImageView.layer.cornerRadius = 4.0f;
    _iconImageView.layer.masksToBounds = YES;
    _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_iconImageView];
    
    _mainImageView = [UIImageView autolayoutView];
    _mainImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_mainImageView];
    
    _sponsorImageView = [UIImageView autolayoutView];
    _sponsorImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_sponsorImageView];
}

-(NSArray<UIView*>*)clickableViews {
    return @[_iconImageView, _ctaLabel];
}

-(void) layoutMediaView {
    self.mediaView.frame = CGRectMake(0, 120.0f, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - 120.0f);
}

-(void) makeConstraintsForSubviews {
    [super makeConstraintsForSubviews];
    NSDictionary *viewsDict = nil;
    if (self.mediaView != nil) {
        viewsDict = @{@"titleLabel":self.titleLabel, @"textLabel":self.textLabel, @"ctaLabel":self.ctaLabel, @"ratingLabel":self.ratingLabel, @"iconImageView":self.iconImageView, @"mainImageView":self.mainImageView, @"mediaView":self.mediaView, @"advertiserLabel":self.advertiserLabel, @"sponsorImageView":self.sponsorImageView};
    } else {
        viewsDict = @{@"titleLabel":self.titleLabel, @"textLabel":self.textLabel, @"ctaLabel":self.ctaLabel, @"ratingLabel":self.ratingLabel, @"iconImageView":self.iconImageView, @"mainImageView":self.mainImageView, @"advertiserLabel":self.advertiserLabel, @"sponsorImageView":self.sponsorImageView};
    }
    [self addConstraintsWithVisualFormat:@"|[mainImageView]|" options:0 metrics:nil views:viewsDict];
    [self addConstraintsWithVisualFormat:@"V:[iconImageView][mainImageView]|" options:0 metrics:nil views:viewsDict];
    
    [self addConstraintWithItem:self.iconImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.iconImageView attribute:NSLayoutAttributeHeight multiplier:1.0f constant:.0f];
    
    [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self addConstraintsWithVisualFormat:@"|-15-[iconImageView(90)]-8-[titleLabel]-8-[sponsorImageView]-15-|" options:NSLayoutFormatAlignAllTop metrics:nil views:viewsDict];
    [self addConstraintsWithVisualFormat:@"V:|-15-[titleLabel]-8-[textLabel]-8-[ctaLabel]-8-[ratingLabel]-8-[advertiserLabel]" options:NSLayoutFormatAlignAllLeading | NSLayoutFormatAlignAllTrailing metrics:nil views:viewsDict];
}
@end
#endif

#ifdef NATIVE_INTEGRATED
@interface AMADShowViewController()<AMNativeADDelegate>
#else
@interface AMADShowViewController()
#endif
@property(nonatomic, readonly) NSDictionary *placementIDs;
@property(nonatomic, readonly) NSString *name;
@property(nonatomic, readonly) UIActivityIndicatorView *loadingView;
@property(nonatomic, readonly) UIButton *reloadADButton;
@property(nonatomic, readonly) UIButton *clearAdButton;
@property(nonatomic, readonly) UIButton *showAdButton;
@property(nonatomic, readonly) UILabel *failureTipsLabel;
@property(nonatomic, readonly) UIButton *removeAdButton;
@end
@implementation AMADShowViewController
#ifdef NATIVE_INTEGRATED
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
                          kFlurryPlacement:kFlurryPlacementID,
                          kGDTPlacement:kGDTPlacementID,
                          kGDTTemplatePlacement:kGDTTemplatePlacementID,
                          kYeahmobiPlacement:kYeahmobiPlacementID,
                          kAppnextPlacement:kAppnextPlacementID
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
    _showAdButton.enabled = NO;
    
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
    _removeAdButton.enabled = NO;
    
    _failureTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(.0f, 64.0f, CGRectGetWidth(self.view.bounds), 400.0f)];
    _failureTipsLabel.text = @"Failed to load ad";
    _failureTipsLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_failureTipsLabel];
    _failureTipsLabel.hidden = YES;
    
    if ([[AMAdManager sharedManager] nativeAdReadyForPlacementID:_placementIDs[_name]]) {
        [self showAD];
    } else {
        _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _loadingView.center = _failureTipsLabel.center;
        [_loadingView startAnimating];
        [self.view addSubview:_loadingView];
        [[AMAdManager sharedManager] loadADWithPlacementID:_placementIDs[_name] extra:@{kExtraInfoNativeAdTypeKey:@([@{kGDTPlacement:@(AMGDTNativeAdTypeSelfRendering), kGDTTemplatePlacement:@(AMGDTNativeAdTypeTemplate), kMintegralPlacement:@(AMGDTNativeAdTypeSelfRendering)}[_name] integerValue]), kExtraInfoNativeAdSizeKey:[NSValue valueWithCGSize:CGSizeMake(CGRectGetWidth(self.view.bounds) - 30.0f, 400.0f)]} customData:@{@"network":@"facebook"} delegate:self];
    }
}

-(void) removeAdButtonTapped {
    [[self.view viewWithTag:adViewTag] removeFromSuperview];
}

-(void) clearAdButtonTapped {
    [[AMAdManager sharedManager] clearCache];
}

-(void) dealloc {
    NSLog(@"dealloc");
}

static NSInteger adViewTag = 3333;
-(void) reloadADButtonTapped {
    _failureTipsLabel.hidden = YES;
    _reloadADButton.enabled = NO;
    [self.view addSubview:_loadingView];
    [[AMAdManager sharedManager] loadADWithPlacementID:_placementIDs[_name] extra:@{kExtraInfoNativeAdTypeKey:@([@{kGDTPlacement:@(AMGDTNativeAdTypeSelfRendering), kGDTTemplatePlacement:@(AMGDTNativeAdTypeTemplate)}[_name] integerValue]), kExtraInfoNativeAdSizeKey:[NSValue valueWithCGSize:CGSizeMake(CGRectGetWidth(self.view.bounds) - 30.0f, 400.0f)]} customData:nil delegate:self];
}

-(void) showAD {
    //Remove previously shown ad first.
    [self removeAdButtonTapped];
    _removeAdButton.enabled = YES;
    AMNativeADConfiguration *config = [[AMNativeADConfiguration alloc] init];
    config.ADFrame = CGRectMake(.0f, 64.0f, CGRectGetWidth(self.view.bounds), 300.0f);
    config.delegate = self;
    config.renderingViewClass = [DMADView class];
    UIView *adView = [[AMAdManager sharedManager] retriveAdViewWithPlacementID:_placementIDs[_name] configuration:config];
    adView.tag = adViewTag;
    [self.view addSubview:adView];
    if (adView == nil) NSLog(@"retrive ad view failed");
}
    
-(void) didStartPlayingVideoInAdView:(AMNativeADView*)adView placementID:(NSString*)placementID {
    NSLog(@"Native Demo: didStartPlayingVideoInAdView:placementID:%@", placementID);
}

-(void) didEndPlayingVideoInAdView:(AMNativeADView*)adView placementID:(NSString*)placementID {
    NSLog(@"Native Demo: didEndPlayingVideoInAdView:placementID:%@", placementID);
}

-(void) didClickNativeAdInAdView:(AMNativeADView*)adView placementID:(NSString*)placementID {
    NSLog(@"Native Demo: didClickNativeAdInAdView:placementID:%@", placementID);
}

-(void) didShowNativeAdInAdView:(AMNativeADView*)adView placementID:(NSString*)placementID {
    NSLog(@"Native Demo: didShowNativeAdInAdView:placementID:%@", placementID);
    adView.mainImageView.hidden = [adView isVideoContents];
}


-(void) didFinishLoadingADWithPlacementID:(NSString *)placementID {
    NSLog(@"Native Demo: didFinishLoadingADWithPlacementID:%@", placementID);
    [_loadingView removeFromSuperview];
    _failureTipsLabel.hidden = YES;
    _reloadADButton.enabled = YES;
    _showAdButton.enabled = YES;
    if ([self.view viewWithTag:adViewTag] == nil) {
        [self showAD];
    }
}


-(void) didFailToLoadADWithPlacementID:(NSString *)placementID error:(NSError *)error {
    NSLog(@"Native Demo: didFailToLoadADWithPlacementID:%@ error:%@", placementID, error);
    [_loadingView removeFromSuperview];
    _failureTipsLabel.hidden = NO;
    _reloadADButton.enabled = YES;
}
#endif
@end
