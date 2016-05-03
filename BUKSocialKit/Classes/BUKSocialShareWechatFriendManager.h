//
//  BUKSocialShareWechatFriendManager.h
//  BUKSocialKit
//
//  Created by Lazy on 1/15/16.
//  Copyright © 2016 Lazy. All rights reserved.
//

#import "BUKSocialShareManager.h"

@interface BUKSocialShareWechatFriendManager : BUKSocialShareManager
@property (nonatomic) BOOL isAppOnly;
- (instancetype)initWithAppOnly:(BOOL)appOnly;
@end
