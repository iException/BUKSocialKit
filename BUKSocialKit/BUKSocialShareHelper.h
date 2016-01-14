//
//  BUKSocialShareHelper.h
//  BUKSocialKit
//
//  Created by Lazy on 1/14/16.
//  Copyright © 2016 Lazy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BUKSocialShareHelper : NSObject

+ (instancetype)sharedInstance;

- (void)setQQWithAppId:(NSString *)appId appKey:(NSString *)appKey url:(NSString *)url;
- (void)setWXAppId:(NSString *)appId appSecret:(NSString *)appSecret url:(NSString *)url;
- (void)setWeiboAppKey:(NSString *)appKey appSecret:(NSString *)appSecret url:(NSString *)url;

- (BOOL)handleOpenURL:(NSURL *)url;

@property (nonatomic, copy, readonly) NSString *qqAppId;
@property (nonatomic, copy, readonly) NSString *qqAppKey;
@property (nonatomic, copy, readonly) NSString *qqCallbackUrl;

@property (nonatomic, copy, readonly) NSString *wxAppId;
@property (nonatomic, copy, readonly) NSString *wxAppSecret;

@property (nonatomic, copy, readonly) NSString *weiboAppId;
@property (nonatomic, copy, readonly) NSString *weiboAppSecret;
@property (nonatomic, copy, readonly) NSString *weiboCallbackUrl;

@end
