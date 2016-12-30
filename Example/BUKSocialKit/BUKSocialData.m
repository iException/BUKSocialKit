//
//  BUKSocialData.m
//  BUKSocialKit
//
//  Created by Lazy on 1/14/16.
//  Copyright © 2016 Lazy. All rights reserved.
//

#import "BUKSocialData.h"
@interface BUKSocialData () <NSCoding>
@end

@implementation BUKSocialData

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content url:(NSString *)url image:(UIImage *)image
{
    self = [super init];
    if (self) {
        _title = title;
        _content = content;
        _url = url;
        _image = image;
        _socialDataType = BUKSocialDataTypeURL;
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _socialDataType = BUKSocialDataTypeURL;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [self init])) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.url = [aDecoder decodeObjectForKey:@"url"];
        self.image = [aDecoder decodeObjectForKey:@"image"];
        self.imageData = [aDecoder decodeObjectForKey:@"imageData"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeObject:self.image forKey:@"image"];
    [aCoder encodeObject:self.imageData forKey:@"imageData"];
}

+ (instancetype)dataWithTitle:(NSString *)title content:(NSString *)content url:(NSString *)url image:(UIImage *)image
{
    BUKSocialData *socialData = [[BUKSocialData alloc] initWithTitle:title content:content url:url image:image];
    socialData.socialDataType = url.length > 0 ? BUKSocialDataTypeURL : BUKSocialDataTypeImage;
    return socialData;
}
@end
