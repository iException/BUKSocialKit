//
//  BUKSocialShareWeiboManager.m
//  BUKSocialKit
//
//  Created by Lazy on 1/14/16.
//  Copyright © 2016 Lazy. All rights reserved.
//

#import "BUKSocialShareWeiboManager.h"
#import "libWeiboSDK/WeiboSDK.h"
#import "BUKSocialShareHelper.h"

@interface BUKSocialShareWeiboManager () <WeiboSDKDelegate>

@end

@implementation BUKSocialShareWeiboManager

- (void)shareData:(BUKSocialData *)data withCompletionHandler:(BUKSocialShareCompletionHandler)handler
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = [[BUKSocialShareHelper sharedInstance] weiboCallbackUrl];
    request.scope = @"all";
    
    WBMessageObject *message = [[WBMessageObject alloc] init];
    message.text = data.content;
    WBImageObject *image = [[WBImageObject alloc] init];
    image.imageData = UIImagePNGRepresentation(data.image);
    message.imageObject = image;
    
    WBSendMessageToWeiboRequest *sendRequest = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:request access_token:nil];
    [WeiboSDK sendRequest:sendRequest];
}

#pragma mark - WeiboSDKDelegate

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class]) {
        BUKSocialShareResultCode code;
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
                break;
        }
        self.handler(code);
    }
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

@end
