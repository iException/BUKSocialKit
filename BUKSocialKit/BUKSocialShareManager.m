//
//  BUKSocialShareManager.m
//  BUKSocialKit
//
//  Created by Lazy on 1/14/16.
//  Copyright © 2016 Lazy. All rights reserved.
//

#import "BUKSocialShareManager.h"
#import "BUKSocialShareWeiboManager.h"
#import "BUKSocialData.h"

@interface BUKSocialShareManager ()

@end

@implementation BUKSocialShareManager

+ (BUKSocialShareManager *)managerWithType:(BUKSocialShareType)type
{
    static dispatch_once_t token;
    static BUKSocialShareManager *_sharedInstance;
    
    dispatch_once(&token, ^{
        switch (type) {
            case BUKSocialShareTypeWeibo:
                _sharedInstance = [[BUKSocialShareWeiboManager alloc] init];
                break;
                
            default:
                break;
        }
    });
    
    return _sharedInstance;
}



#pragma mark - private -

- (void)shareData:(BUKSocialData *)data withCompletionHandler:(BUKSocialShareCompletionHandler)handler
{

}

@end
