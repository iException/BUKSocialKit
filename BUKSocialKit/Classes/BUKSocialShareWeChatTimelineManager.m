//
//  BUKSocialShareWeChatTimelineManager.m
//  BUKSocialKit
//
//  Created by Lazy on 1/15/16.
//  Copyright © 2016 Lazy. All rights reserved.
//

#import "BUKSocialShareWeChatTimelineManager.h"
#import "UIImage+ImageCompress.h"
#import "UIImage+Resize.h"
#import "WXApi.h"

@interface BUKSocialShareWeChatTimelineManager () <WXApiDelegate>

@end

@implementation BUKSocialShareWeChatTimelineManager

static const CGFloat kThumbnailWidth = 80.0f;
static const CGFloat kThumbnailHeight = 80.0f;

- (instancetype)initWithAppOnly:(BOOL)appOnly
{
    if (self = [super init]) {
        self.isAppOnly = appOnly;
    }
    return self;
}

- (void)shareData:(BUKSocialData *)data withCompletionHandler:(BUKSocialShareCompletionHandler)handler
{
    if (self.isAppOnly) {
        [self shareBXAppOnlyData:data withCompletionHandler:handler];
        return;
    }
    [super shareData:data withCompletionHandler:handler];
    
    if (![WXApi isWXAppInstalled]) {
        self.handler(BUKSocialShareResultCodeNotInstallClient);
        return;
    }
    
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
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
}

- (void)shareBXAppOnlyData:(BUKSocialData *)data withCompletionHandler:(BUKSocialShareCompletionHandler)handler
{
    [super shareData:data withCompletionHandler:handler];

    if (![WXApi isWXAppInstalled]) {
        self.handler(BUKSocialShareResultCodeNotInstallClient);
        return;
    }

    WXMediaMessage *message = [WXMediaMessage message];
    message.title = data.title;
    message.description = data.content;
    UIImage *thumbNail = [data.image resizedImageToSize:CGSizeMake(kThumbnailWidth, kThumbnailHeight)];
    [message setThumbImage:thumbNail];

    WXAppExtendObject *object = [WXAppExtendObject object];
    NSData *fileData = [NSKeyedArchiver archivedDataWithRootObject:data];
    object.fileData = fileData;
    object.extInfo = @"com.baixing.iosbaixing.bxfile";
    object.url = @"https://itunes.apple.com/cn/developer/bai-xing-wang/id591540116";
    message.mediaObject = object;

    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;

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
    BUKSocialShareResultCode code = BUKSocialShareResultCodeSuccess;
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
            code = BUKSocialShareResultCodeFaild;
            break;
    }
    
    if (self.handler) {
        self.handler(code);
    }
}

@end
