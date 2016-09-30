//
//  BUKSocialData.h
//  BUKSocialKit
//
//  Created by Lazy on 1/14/16.
//  Copyright © 2016 Lazy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BUKSocialShareType){
    BUKSocialShareTypeNone = 0,
    BUKSocialShareTypeWeibo,
    BUKSocialShareTypeWechatFriend,
    BUKSocialShareTypeWechatTimeline,
    BUKSocialShareTypeQQ,
    BUKSocialShareTypeQQZone
};


/**
 * BUKSocialDataTypeURL  一个带有标题， 描述， 缩略图的socialdata
 * BUKSocialDataTypeImage  一个只有图片的socialdata
 * BUKSocialDataTypeSourceOnly  一个只能在分享来源app中打开的socialdata
 */
typedef NS_ENUM(NSInteger, BUKSocialDataType) {
    BUKSocialDataTypeURL = 0,
    BUKSocialDataTypeImage,
    BUKSocialDataTypeSourceOnly
};

@interface BUKSocialData : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

/**
 * 当socialType为BUKSocialDataTypeURL的时候， url就是分享跳转的链接, 若不设置， 则不会进行app的跳转。
 * 当socialType为BUKSocialDataTypeSourceOnly的时候， url是当检测到本机未安装分享源app时跳转的链接（如跳转到分享源app的app store下载界面，
 * 但是如果设置为除了app store以外的链接会跳转到safari显示 “未安装[app名]， 无法打开链接”， 若不设置， 跳转到微信的时候会显示 “由于不支持的分享类型， 无法分享到微信”的字样）
 */
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSData *imageData;

/**
 * 如果使用BUKSocialDataTypeSourceOnly 要在项目target中添加支持的文件类型。比如支持com.example.app.myfileext
 * 并且设置 extInfo为 "com.example.app.myfileext"
 * 其他情况不需要设置 extInfo
 * 添加支持的文件类型的具体方式 到target的info中的Document Types添加支持文件类型。
 * 详细方法见文档： https://developer.apple.com/library/ios/qa/qa1587/_index.html
 */
@property (nonatomic, copy) NSString *extInfo;

/**
 * 分享类型， 默认为BUKSocialDataTypeURL
 */
@property (nonatomic) BUKSocialDataType socialDataType;


- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content url:(NSString *)url image:(UIImage *)image;
+ (instancetype)dataWithTitle:(NSString *)title content:(NSString *)content url:(NSString *)url image:(UIImage *)image;
@end
