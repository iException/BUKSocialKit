//
//  BUKSocialShareManager.m
//  BUKSocialKit
//
//  Created by Lazy on 1/14/16.
//  Copyright © 2016 Lazy. All rights reserved.
//

#import "BUKSocialShareManager.h"
#import "BUKSocialShareWeiboManager.h"
#import "BUKSocialShareQQManager.h"
#import "BUKSocialShareQzoneManager.h"
#import "BUKSocialShareWechatFriendManager.h"
#import "BUKSocialShareWeChatTimelineManager.h"
#import "BUKSocialData.h"

@interface BUKSocialShareManager ()

@end

@implementation BUKSocialShareManager

+ (BUKSocialShareManager *)managerWithType:(BUKSocialShareType)type
{
    BUKSocialShareManager *manager;
    
    switch (type) {
        case BUKSocialShareTypeWeibo:
            manager = [[BUKSocialShareWeiboManager alloc] init];
            break;
        case BUKSocialShareTypeQQ:
            manager = [[BUKSocialShareQQManager alloc] init];
            break;
        case BUKSocialShareTypeQQZone:
            manager = [[BUKSocialShareQzoneManager alloc] init];
            break;
        case BUKSocialShareTypeWechatFriend:
            manager = [[BUKSocialShareWechatFriendManager alloc] init];
            break;
        case BUKSocialShareTypeWechatTimeline:
            manager = [[BUKSocialShareWeChatTimelineManager alloc] init];
            break;
        default:
            break;
    }
    
    return manager;
}

#pragma mark - private -

- (void)shareData:(BUKSocialData *)data withCompletionHandler:(BUKSocialShareCompletionHandler)handler
{
    self.handler = handler;
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    return YES;
}

@end
