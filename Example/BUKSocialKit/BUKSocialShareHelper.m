//
//  BUKSocialShareHelper.m
//  BUKSocialKit
//
//  Created by Lazy on 1/14/16.
//  Copyright © 2016 Lazy. All rights reserved.
//

#import "BUKSocialShareHelper.h"
#import "BUKSocialShareManager.h"
#import "WeiboSDK.h"
#import "WXApi.h"

@interface BUKSocialShareHelper ()

@property (nonatomic, copy, readwrite) NSString *qqAppId;
@property (nonatomic, copy, readwrite) NSString *qqAppKey;
@property (nonatomic, copy, readwrite) NSString *qqCallbackUrl;

@property (nonatomic, copy, readwrite) NSString *wxAppId;
@property (nonatomic, copy, readwrite) NSString *wxAppSecret;
@property (nonatomic, copy, readwrite) NSString *wxCallbackUrl;

@property (nonatomic, copy, readwrite) NSString *weiboAppKey;
@property (nonatomic, copy, readwrite) NSString *weiboAppSecret;
@property (nonatomic, copy, readwrite) NSString *weiboCallbackUrl;

@end

@implementation BUKSocialShareHelper

+ (instancetype)sharedInstance
{
    static dispatch_once_t token;
    static BUKSocialShareHelper *_sharedInstance;
    
    dispatch_once(&token, ^{
        _sharedInstance = [[BUKSocialShareHelper alloc] init];
    });
    
    return _sharedInstance;
}

#pragma mark - setter -

- (void)setQQWithAppId:(NSString *)appId appKey:(NSString *)appKey url:(NSString *)url
{
    self.qqAppId = appId;
    self.qqAppKey = appKey;
    self.qqCallbackUrl = url;
}

- (void)setWeiboAppKey:(NSString *)appKey appSecret:(NSString *)appSecret url:(NSString *)url
{
    self.weiboAppKey = appKey;
    self.weiboAppSecret = appSecret;
    self.weiboCallbackUrl = url;
    
#ifdef DEBUG
    [WeiboSDK enableDebugMode:YES];
#endif
    [WeiboSDK registerApp:appKey];
}

- (void)setWXAppId:(NSString *)appId appSecret:(NSString *)appSecret url:(NSString *)url
{
    self.wxAppId = appId;
    self.wxAppSecret = appSecret;
    self.wxCallbackUrl = url;
    
    [WXApi registerApp:appId];
}

#pragma mark - private -

- (BOOL)handleOpenURL:(NSURL *)url
{
    return [[self manager] handleOpenURL:url];
}

@end
