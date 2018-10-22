//
//  ViewController.m
//  AutoMediationSDKDemo
//
//  Created by Martin Lau on 09/04/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import "ViewController.h"
#import <AutoMediationSDK/AMAPI.h>
#import "AMADShowViewController.h"
#import "AMRewardedVideoVideoViewController.h"
#import "AMBannerViewController.h"
#import "AMInterstitialViewController.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, readonly) UITableView *tableView;
@property(nonatomic, readonly) NSArray<NSArray<NSString*>*>* placementNames;
@end

static NSString *const kCellIdentifier = @"cell";
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _placementNames = @[@[kFacebookPlacement, kAdMobPlacement, kInmobiPlacement, kFlurryPlacement, kApplovinPlacement, kMintegralPlacement, kMintegralVideoPlacement, kMopubPlacementName, kGDTPlacement, kChartboostPlacementName, kTapjoyPlacementName, kIronsourcePlacementName, kVunglePlacementName, kAdcolonyPlacementName, kTTPlacementName, kTTVideoPlacement, kOnewayPlacementName, kYeahmobiPlacement, kAppnextPlacement],
                        @[kFacebookPlacement, kAdMobPlacement, kInmobiPlacement, kFlurryPlacement, kApplovinPlacement, kGDTPlacement, kMopubPlacementName, kTTPlacementName, kYeahmobiPlacement, kAppnextPlacement],
                        @[kFacebookPlacement, kAdMobPlacement, kInmobiPlacement, kFlurryPlacement, kApplovinPlacement, kMintegralPlacement, kMopubPlacementName, kChartboostPlacementName, kTapjoyPlacementName, kIronsourcePlacementName, kVunglePlacementName, kAdcolonyPlacementName, kUnityAdsPlacementName, kTTPlacementName, kOnewayPlacementName, kYeahmobiPlacement, kAppnextPlacement, kAllPlacementName],
                        @[kFacebookPlacement, kAdMobPlacement, kInmobiPlacement, kFlurryPlacement, kApplovinPlacement, kMintegralPlacement, kMopubPlacementName, kGDTPlacement, kGDTTemplatePlacement, kYeahmobiPlacement, kAppnextPlacement, kAllPlacementName]];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"GDPR" style:UIBarButtonItemStylePlain target:self action:@selector(policyButtonTapped)];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)policyButtonTapped {
    [[AMAPI sharedInstance] presentDataConsentDialogInViewController:self];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return [_placementNames count];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_placementNames[section] count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25.0f;
}

-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @[@"Interstitial", @"Banner", @"RV", @"Native"][section];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    cell.textLabel.text = _placementNames[[indexPath section]][[indexPath row]];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([indexPath section] == 2) {
        AMRewardedVideoVideoViewController *tVC = [[AMRewardedVideoVideoViewController alloc] initWithPlacementName:_placementNames[[indexPath section]][[indexPath row]]];
        [self.navigationController pushViewController:tVC animated:YES];
    } else if ([indexPath section] == 3) {        AMADShowViewController *tVC = [[AMADShowViewController alloc] initWithPlacementName: _placementNames[[indexPath section]][[indexPath row]]];
        [self.navigationController pushViewController:tVC animated:YES];
    } else if ([indexPath section] == 1) {
        AMBannerViewController *tVC = [[AMBannerViewController alloc] initWithPlacementName:_placementNames[[indexPath section]][[indexPath row]]];
        [self.navigationController pushViewController:tVC animated:YES];
    } else if ([indexPath section] == 0) {
        AMInterstitialViewController *tVC = [[AMInterstitialViewController alloc] initWithPlacementName:_placementNames[[indexPath section]][[indexPath row]]];
        [self.navigationController pushViewController:tVC animated:YES];
    }
}
@end
