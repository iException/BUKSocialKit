//
//  BUKSocialShareManager.h
//  BUKSocialKit
//
//  Created by Lazy on 1/14/16.
//  Copyright © 2016 Lazy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUKSocialData.h"

typedef NS_ENUM(NSInteger, BUKSocialShareResultCode){
    BUKSocialShareResultCodeSuccess            = 200,        //成功
    BUKSocialShareResultCodeTokenInvalid       = 400,        //授权用户token错误
    BUKSocialShareResultCodeBaned              = 505,        //用户被封禁
    BUKSocialShareResultCodeFaild              = 510,        //发送失败（由于内容不符合要求或者其他原因）
    BUKSocialShareResultCodeArgumentsError     = 522,        //参数错误,提供的参数不符合要求
    BUKSocialShareResultCodeEmptyContent       = 5007,       //发送内容为空
    BUKSocialShareResultCodeContentNotSupported= 5008,       //发送内容不支持
    BUKSocialShareResultCodeShareRepeated      = 5016,       //分享内容重复
    BUKSocialShareResultCodeGetNoUidFromOauth  = 5020,       //授权之后没有得到用户uid
    BUKSocialShareResultCodeAccessTokenExpired = 5027,       //token过期
    BUKSocialShareResultCodeNetworkError       = 5050,       //网络错误
    BUKSocialShareResultCodeGetProfileFailed   = 5051,       //获取账户失败
    BUKSocialShareResultCodeCancel             = 5052,       //用户取消授权
    BUKSocialShareResultCodeNotLogin           = 5053,       //用户没有登录
    BUKSocialShareResultCodeNotInstallClient   = 5054,       //用户没有安装客户端
    BUKSocialShareResultCodeNotRegisted        = 5055,       //用户没有授权
    BUKSocialShareResultCodeNoApiAuthority     = 100031      //QQ空间应用没有在QQ互联平台上申请上传图片到相册的权限
};

typedef void (^BUKSocialShareCompletionHandler)(BUKSocialShareResultCode code);

@interface BUKSocialShareManager : NSObject

@property (nonatomic, copy) BUKSocialShareCompletionHandler handler;

+ (BUKSocialShareManager *)managerWithType:(BUKSocialShareType)type;

- (void)shareData:(BUKSocialData *)data withCompletionHandler:(BUKSocialShareCompletionHandler)handler;
- (BOOL)handleOpenURL:(NSURL *)url;

@end
