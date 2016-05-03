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


/*
 * BUKSocialDataTypeURL  一个带有标题， 描述， 缩略图的socialdata
 * BUKSocialDataTypeImage  一个只有图片的socialdata
 * BUKSocialDataTypeSourceOnly  一个只能在分享来源app中打开的socialdata
 */
typedef NS_ENUM(NSInteger, BUKSocialDataType) {
    BUKSocialDataTypeURL = 0,
    BUKSocialDataTypeImage,
    BUKSocialDataTypeSourceOnly
};


/*
 * 如果使用BUKSocialDataTypeSourceOnly 要在项目target中添加支持的文件类型。比如支持com.example.app.myfileext  
 * 并且设置 extInfo为 "com.example.app.myfileext"
 * 其他情况不需要设置 extInfo
 */

@interface BUKSocialData : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSData *imageData;
@property (nonatomic, copy) NSString *extInfo;
@property (nonatomic) BUKSocialDataType socialDataType;


- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content url:(NSString *)url image:(UIImage *)image;
+ (instancetype)dataWithTitle:(NSString *)title content:(NSString *)content url:(NSString *)url image:(UIImage *)image;
+ (instancetype)urlDataWithTitle:(NSString *)title content:(NSString *)content url:(NSString *)url image:(UIImage *)image;
+ (instancetype)sourceOnlyDataWithTitle:(NSString *)title content:(NSString *)content url:(NSString *)url image:(UIImage *)image extInfo:(NSString *)extInfo;
+ (instancetype)dataWithImage:(UIImage *)image;
@end
