//
//  BUKSocialShareQQManager.m
//  BUKSocialKit
//
//  Created by Lazy on 1/14/16.
//  Copyright © 2016 Lazy. All rights reserved.
//

#import "BUKSocialShareQQManager.h"
#import "BUKSocialShareHelper.h"
#import <TencentOpenAPI/TencentApiInterface.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface BUKSocialShareQQManager () <TencentSessionDelegate>

@property (nonatomic, strong) TencentOAuth *oAuth;

@end

@implementation BUKSocialShareQQManager

- (void)shareData:(BUKSocialData *)data withCompletionHandler:(BUKSocialShareCompletionHandler)handler
{
    [super shareData:data withCompletionHandler:handler];
   
#pragma clang diagnostic push 
#pragma clang diagnostic ignored "-Wunused-variable"
    TencentOAuth *oAuth = [[TencentOAuth alloc] initWithAppId:[[BUKSocialShareHelper sharedInstance] qqAppId] andDelegate:self];
#pragma clang diagnostic pop
    
    QQApiImageObject *imageObject = [QQApiImageObject objectWithData:UIImagePNGRepresentation(data.image) previewImageData:UIImagePNGRepresentation(data.image) title:data.title description:data.content];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:imageObject];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    [self handleRequest:sent];
}

- (void)handleRequest:(QQApiSendResultCode)sent
{
    NSLog(@"%@",@(sent));
}

#pragma mark - TencentLoginDelegate

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
