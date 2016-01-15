//
//  BUKSocialShareQzoneManager.m
//  BUKSocialKit
//
//  Created by Lazy on 1/15/16.
//  Copyright © 2016 Lazy. All rights reserved.
//

#import "BUKSocialShareQzoneManager.h"
#import "BUKSocialShareHelper.h"
#import <TencentOpenAPI/TencentApiInterface.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface BUKSocialShareQzoneManager () <TencentSessionDelegate>

@property (nonatomic, strong) TencentOAuth *oAuth;

@end

@implementation BUKSocialShareQzoneManager

- (void)shareData:(BUKSocialData *)data withCompletionHandler:(BUKSocialShareCompletionHandler)handler
{
    [super shareData:data withCompletionHandler:handler];
    
    self.oAuth = [[TencentOAuth alloc] initWithAppId:[[BUKSocialShareHelper sharedInstance] qqAppId] andDelegate:self];
    
    QQApiObject *object = nil;
    if (data.url) {
        object = [QQApiURLObject objectWithURL:[NSURL URLWithString:data.url] title:data.title description:data.content previewImageData:UIImagePNGRepresentation(data.image) targetContentType:QQApiURLTargetTypeNews];
        [(QQApiURLObject *)object setCflag:kQQAPICtrlFlagQZoneShareOnStart];
    } else {
        object = [QQApiImageObject objectWithData:UIImagePNGRepresentation(data.image) previewImageData:UIImagePNGRepresentation(data.image) title:data.title description:data.content];
        [(QQApiImageObject *)object setCflag:kQQAPICtrlFlagQZoneShareOnStart];
    }
    
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:object];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    [self handleRequest:sent];
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    return [TencentOAuth HandleOpenURL:url];
}

- (void)handleRequest:(QQApiSendResultCode)sent
{
    BUKSocialShareResultCode code;
    switch (sent) {
        case EQQAPISENDSUCESS:
            code = BUKSocialShareResultCodeSuccess;
            break;
        case EQQAPIQQNOTINSTALLED:
            code = BUKSocialShareResultCodeNotInstallClient;
            break;
        case EQQAPIQQNOTSUPPORTAPI:
            code = BUKSocialShareResultCodeFaild;
            break;
        case EQQAPIMESSAGECONTENTNULL:
            code = BUKSocialShareResultCodeEmptyContent;
            break;
        case EQQAPIMESSAGECONTENTINVALID:
            code = BUKSocialShareResultCodeFaild;
            break;
        case EQQAPIAPPNOTREGISTED:
            code = BUKSocialShareResultCodeNotRegisted;
            break;
        case EQQAPIAPPSHAREASYNC:
            code = BUKSocialShareResultCodeNetworkError;
            break;
        case EQQAPIQQNOTSUPPORTAPI_WITH_ERRORSHOW:
            code = BUKSocialShareResultCodeFaild;
            break;
        case EQQAPIQZONENOTSUPPORTTEXT:
            code = BUKSocialShareResultCodeNoApiAuthority;
            break;
        case EQQAPIQZONENOTSUPPORTIMAGE:
            code = BUKSocialShareResultCodeNoApiAuthority;
            break;
        default:
            break;
    }
    self.handler(code);

}

#pragma mark - TencentSessionDelegate

- (void)tencentDidLogin
{
    
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    
}

- (void)tencentDidNotNetWork
{
    
}

@end
