//
//  BUKSocialShareWeiboManager.m
//  BUKSocialKit
//
//  Created by Lazy on 1/14/16.
//  Copyright © 2016 Lazy. All rights reserved.
//

#import "BUKSocialShareWeiboManager.h"
#import "BUKSocialShareHelper.h"
#import "UIImage+Resize.h"
#import "WeiboSDK.h"

@interface BUKSocialShareWeiboManager () <WeiboSDKDelegate>

@end

@implementation BUKSocialShareWeiboManager

static const CGFloat kThumbnailWidth = 160.0f;
static const CGFloat kThumbnailHeight = 160.0f;

- (void)shareData:(BUKSocialData *)data withCompletionHandler:(BUKSocialShareCompletionHandler)handler
{
    [super shareData:data withCompletionHandler:handler];
    
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = [[BUKSocialShareHelper sharedInstance] weiboCallbackUrl];
    request.scope = @"all";
    
    WBMessageObject *message = [[WBMessageObject alloc] init];
    message.text = data.content;
    
    if (data.url) {
        WBWebpageObject *webPage = [WBWebpageObject object];
        webPage.objectID = data.title;
        webPage.webpageUrl = data.url;
        webPage.title = data.title;
        webPage.description = data.content;
        webPage.thumbnailData = UIImagePNGRepresentation([data.image resizedImageToSize:CGSizeMake(kThumbnailWidth, kThumbnailHeight)]);
        message.mediaObject = webPage;
    } else {
        WBImageObject *image = [WBImageObject object];
        image.imageData = UIImagePNGRepresentation(data.image);
        message.imageObject = image;
    }
    
    
    WBSendMessageToWeiboRequest *sendRequest = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:request access_token:nil];
    [WeiboSDK sendRequest:sendRequest];
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

#pragma mark - WeiboSDKDelegate

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class] || [response isKindOfClass:[WBAuthorizeResponse class]]) {
        BUKSocialShareResultCode code = BUKSocialShareResultCodeSuccess;
        switch (response.statusCode) {
            case WeiboSDKResponseStatusCodeSuccess:
                code = BUKSocialShareResultCodeSuccess;
                break;
            case WeiboSDKResponseStatusCodeUserCancel:
                code = BUKSocialShareResultCodeCancel;
                break;
            case WeiboSDKResponseStatusCodeSentFail:
                code = BUKSocialShareResultCodeFaild;
                break;
            case WeiboSDKResponseStatusCodeAuthDeny:
                code = BUKSocialShareResultCodeTokenInvalid;
                break;
            case WeiboSDKResponseStatusCodeUserCancelInstall:
                code = BUKSocialShareResultCodeNotInstallClient;
                break;
            case WeiboSDKResponseStatusCodePayFail:
                code = BUKSocialShareResultCodeFaild;
                break;
            case WeiboSDKResponseStatusCodeShareInSDKFailed:
                code = BUKSocialShareResultCodeFaild;
                break;
            case WeiboSDKResponseStatusCodeUnsupport:
                code = BUKSocialShareResultCodeArgumentsError;
                break;
            case WeiboSDKResponseStatusCodeUnknown:
                code = BUKSocialShareResultCodeFaild;
                break;
            default:
                code = BUKSocialShareResultCodeFaild;
                break;
        }
        self.handler(code);
    }
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

@end
