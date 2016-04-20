//
//  BUKAppDelegate.m
//  BUKSocialKit
//
//  Created by LazyClutch on 04/20/2016.
//  Copyright (c) 2016 LazyClutch. All rights reserved.
//

#import "BUKAppDelegate.h"
#import "BUKSocialKit.h"

@implementation BUKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation
{
    return [[BUKSocialShareHelper sharedInstance] handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [[BUKSocialShareHelper sharedInstance] handleOpenURL:url];
}

@end
