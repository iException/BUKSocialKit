//
//  BUKSocialData.m
//  BUKSocialKit
//
//  Created by Lazy on 1/14/16.
//  Copyright © 2016 Lazy. All rights reserved.
//

#import "BUKSocialData.h"

@implementation BUKSocialData

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content url:(NSString *)url image:(UIImage *)image
{
    self = [super init];
    if (self) {
        _title = title;
        _content = content;
        _url = url;
        _image = image;
    }
    return self;
}

- (instancetype)init{
    return [self initWithTitle:nil content:nil url:nil image:nil];
}

@end
