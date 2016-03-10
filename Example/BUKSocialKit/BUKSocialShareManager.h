//
//  BUKSocialShareManager.h
//  BUKSocialKit
//
//  Created by Lazy on 1/14/16.
//  Copyright © 2016 Lazy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUKSocialData.h"

typedef NS_ENUM(NSInteger, BUKQQBaseRespResult){
    BUKQQBaseRespResultSuccess       = 0,
    BUKQQBaseRespResultParamsError   = -1,
    BUKQQBaseRespResultGroupInvalid  = -2,
    BUKQQBaseRespResultUploadFail    = -3,
    BUKQQBaseRespResultUserCancel    = -4,
    BUKQQBaseRespResultInternalError = -5
};

typedef NS_ENUM(NSInteger, BUKSocialShareResultCode){
    BUKSocialShareResultCodeSuccess            = 200,        //成功
    BUKSocialShareResultCodeTokenInvalid       = 400,        //授权用户token错误
    BUKSocialShareResultCodeFaild              = 5000,        //发送失败（由于内容不符合要求或者其他原因）
    BUKSocialShareResultCodeArgumentsError     = 5001,        //参数错误,提供的参数不符合要求
    BUKSocialShareResultCodeEmptyContent       = 5002,       //发送内容为空
    BUKSocialShareResultCodeContentNotSupported= 5003,       //发送内容不支持
    BUKSocialShareResultCodeNetworkError       = 5004,       //网络错误
    BUKSocialShareResultCodeCancel             = 5005,       //用户取消授权
    BUKSocialShareResultCodeNotInstallClient   = 5006,       //用户没有安装客户端
    BUKSocialShareResultCodeNotRegisted        = 5007,       //用户没有授权
    BUKSocialShareResultCodeNoApiAuthority     = 100031,     //QQ空间应用没有在QQ互联平台上申请上传图片到相册的权限
    BUKSocialShareResultCodeGroupInvalid       = 150000,     //QQ群不在自己的群列表里面
    BUKSocialShareResultCodeUploadFail         = 150001,     //QQ上传图片失败
    BUKSocialShareResultCodeInternalError      = 150002      //QQ客户端内部处理错误
};

typedef void (^BUKSocialShareCompletionHandler)(BUKSocialShareResultCode code);

@interface BUKSocialShareManager : NSObject

@property (nonatomic, copy) BUKSocialShareCompletionHandler handler;

+ (BUKSocialShareManager *)managerWithType:(BUKSocialShareType)type;

- (void)shareData:(BUKSocialData *)data withCompletionHandler:(BUKSocialShareCompletionHandler)handler;
- (BOOL)handleOpenURL:(NSURL *)url;

@end
