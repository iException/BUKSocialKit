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

@interface BUKSocialShareQzoneManager () <TencentSessionDelegate, QQApiInterfaceDelegate>

@property (nonatomic, strong) TencentOAuth *oAuth;

@end

@implementation BUKSocialShareQzoneManager

- (void)shareData:(BUKSocialData *)data withCompletionHandler:(BUKSocialShareCompletionHandler)handler
{
    [super shareData:data withCompletionHandler:handler];
    
    if (![QQApiInterface isQQInstalled]) {
        self.handler(BUKSocialShareResultCodeNotInstallClient);
        return;
    }
    
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
    [QQApiInterface sendReq:req];
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    return [QQApiInterface handleOpenURL:url delegate:self];
}

- (void)handleRespResult:(NSString *)result
{
    NSInteger resultCode = [result integerValue];
    BUKSocialShareResultCode code = BUKSocialShareResultCodeSuccess;
    
    switch (resultCode) {
        case BUKQQBaseRespResultSuccess:
            code = BUKSocialShareResultCodeSuccess;
            break;
        case BUKQQBaseRespResultParamsError:
            code = BUKSocialShareResultCodeArgumentsError;
            break;
        case BUKQQBaseRespResultGroupInvalid:
            code = BUKSocialShareResultCodeFaild;
            break;
        case BUKQQBaseRespResultUploadFail:
            code = BUKSocialShareResultCodeFaild;
            break;
        case BUKQQBaseRespResultUserCancel:
            code = BUKSocialShareResultCodeCancel;
            break;
        case BUKQQBaseRespResultInternalError:
            code = BUKSocialShareResultCodeFaild;
            break;
        default:
            code = BUKSocialShareResultCodeFaild;
            break;
    }
    
    if (self.handler) {
        self.handler(code);
    }
}

#pragma mark - TencentSessionDelegate

- (void)tencentDidLogin
{}

- (void)tencentDidNotLogin:(BOOL)cancelled
{}

- (void)tencentDidNotNetWork
{}

#pragma mark - TencentApiInterfaceDelegate

- (void)onResp:(QQBaseResp *)resp
{
    [self handleRespResult:resp.result];
}

- (void)onReq:(QQBaseReq *)req
{}

- (void)isOnlineResponse:(NSDictionary *)response
{}

@end
