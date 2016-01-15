//
//  BUKSocialShareWechatFriendManager.m
//  BUKSocialKit
//
//  Created by Lazy on 1/15/16.
//  Copyright © 2016 Lazy. All rights reserved.
//

#import "BUKSocialShareWechatFriendManager.h"
#import "UIImage+ImageCompress.h"
#import "UIImage+Resize.h"
#import "WXApi.h"

@interface BUKSocialShareWechatFriendManager () <WXApiDelegate>

@end

@implementation BUKSocialShareWechatFriendManager

static const CGFloat kThumbnailWidth = 120.0f;
static const CGFloat kThumbnailHeight = 160.0f;

- (void)shareData:(BUKSocialData *)data withCompletionHandler:(BUKSocialShareCompletionHandler)handler
{
    [super shareData:data withCompletionHandler:handler];
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = data.title;
    message.description = data.content;
    UIImage *thumbNail = [data.image resizedImageToSize:CGSizeMake(kThumbnailWidth, kThumbnailHeight)];
    [message setThumbImage:thumbNail];
    
    if (data.url) {
        WXWebpageObject *object = [WXWebpageObject object];
        object.webpageUrl = data.url;
        message.mediaObject = object;
    } else {
        WXImageObject *object = [WXImageObject object];
        object.imageData = UIImagePNGRepresentation(data.image);
        message.mediaObject = object;
    }
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

#pragma mark - WXApiDelegate

- (void)onResp:(BaseResp *)resp
{
    enum WXErrCode errCode = resp.errCode;
    BUKSocialShareResultCode code;
    switch (errCode) {
        case WXSuccess:
            code = BUKSocialShareResultCodeSuccess;
            break;
        case WXErrCodeCommon:
            code = BUKSocialShareResultCodeFaild;
            break;
        case WXErrCodeUserCancel:
            code = BUKSocialShareResultCodeCancel;
            break;
        case WXErrCodeSentFail:
            code = BUKSocialShareResultCodeFaild;
            break;
        case WXErrCodeAuthDeny:
            code = BUKSocialShareResultCodeTokenInvalid;
            break;
        case WXErrCodeUnsupport:
            code = BUKSocialShareResultCodeContentNotSupported;
            break;
        default:
            break;
    }
    self.handler(code);
}

- (void)onReq:(BaseReq *)req
{
    
}

@end
