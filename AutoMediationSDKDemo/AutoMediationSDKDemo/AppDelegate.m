//
//  AppDelegate.m
//  AutoMediationSDKDemo
//
//  Created by Martin Lau on 09/04/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#import "AppDelegate.h"
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>
@import AutoMediationSDK;
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [UMConfigure initWithAppkey:@"5b18d139f43e482fb400008f" channel:@"App Store"];
    [UMConfigure setLogEnabled:YES];
    [MobClick setCrashReportEnabled:YES];
//    [[AMAPI sharedInstance] setDataConsentSet:AMDataConsentSetPersonalized consentString:nil];
//    [AMAPI sharedInstance].networkConsentInfo = @{
//    kNetworkNameMintegral:@{@1:@YES, @2:@YES, @3:@YES},
//    kNetworkNameInmobi:@{kInmobiGDPRStringKey:@"0", kInmobiConsentStringKey:@"true"},
//    kNetworkNameMopub:@NO,
//    kNetworkNameApplovin:@{kApplovinConscentStatusKey:@YES, kApplovinUnderAgeKey:@NO},
//    kNetworkNameTapjoy:@{kTapjoyConsentValueKey:@"0", kTapjoyGDPRSubjectionKey:@NO},
//    kNetworkNameChartboost:@NO,
//    kNetworkNameVungle:@1,
//    kNetworkNameIronSource:@YES,
//    kNetworkNameUnityAds:@YES
//    };
#ifdef DEBUG
    [[AMAPI sharedInstance] startWithAppID:@"a5b7e58d58cc88"/*@"a5b3c9c596c043"*/ appKey:@"64c685c78eb04ced8a26af6b7d28aab8" error:nil];
#else
    [[AMAPI sharedInstance] startWithAppID:@"3/agent" appKey:@"3/agent" error:nil];
#endif
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
