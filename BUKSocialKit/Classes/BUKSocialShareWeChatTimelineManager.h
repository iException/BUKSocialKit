//
//  BUKSocialShareWeChatTimelineManager.h
//  BUKSocialKit
//
//  Created by Lazy on 1/15/16.
//  Copyright © 2016 Lazy. All rights reserved.
//

#import "BUKSocialShareManager.h"

@interface BUKSocialShareWeChatTimelineManager : BUKSocialShareManager
@property (nonatomic) BOOL isAppOnly;
- (instancetype)initWithAppOnly:(BOOL)appOnly;
@end
