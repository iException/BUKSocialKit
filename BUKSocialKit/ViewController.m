//
//  ViewController.m
//  BUKSocialKit
//
//  Created by Lazy on 1/14/16.
//  Copyright © 2016 Lazy. All rights reserved.
//

#import "ViewController.h"
#import "BUKSocialKit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[BUKSocialShareHelper sharedInstance] setWeiboAppKey:@"2454831345" appSecret:@"56f9b633b5821179b4ae702a82e7527a" url:@"http://www.baixing.com/a/mobile"];
    [[BUKSocialShareHelper sharedInstance] setQQWithAppId:@"1105039495" appKey:@"2fuWb4qrmezq72yv" url:@"http://www.baixing.com/a/mobile"];
    [[BUKSocialShareHelper sharedInstance] setWXAppId:@"wxad9d46bc30040c71" appSecret:@"a59c72c189e0a2560fdf24cf2a2d1a50" url:@"http://www.baixing.com/a/mobile"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}

- (IBAction)shareToWeibo:(id)sender {
    BUKSocialData *data = [[BUKSocialData alloc] initWithTitle:@"123" content:@"很多思考和看见伤口的健康" url:nil image:[UIImage imageNamed:@"sample"]];
    BUKSocialShareManager *manager = [BUKSocialShareManager managerWithType:BUKSocialShareTypeWeibo];
    [manager shareData:data withCompletionHandler:^(BUKSocialShareResultCode code) {
        NSLog(@"%@",@(code));
    }];
}


- (IBAction)shareToQQ:(id)sender {
    BUKSocialData *data = [[BUKSocialData alloc] initWithTitle:@"123" content:@"很多思考和看见伤口的健康" url:@"http://baixing.com" image:[UIImage imageNamed:@"sample"]];
    BUKSocialShareManager *manager = [BUKSocialShareManager managerWithType:BUKSocialShareTypeQQ];
    [manager shareData:data withCompletionHandler:^(BUKSocialShareResultCode code) {
        NSLog(@"%@",@(code));
    }];
}

- (IBAction)shareToQzone:(id)sender {
    BUKSocialData *data = [[BUKSocialData alloc] initWithTitle:@"123" content:@"非得说开了房间快乐撒进来看" url:@"http://baixing.com" image:[UIImage imageNamed:@"sample"]];
    BUKSocialShareManager *manager = [BUKSocialShareManager managerWithType:BUKSocialShareTypeQQZone];
    [manager shareData:data withCompletionHandler:^(BUKSocialShareResultCode code) {
        NSLog(@"%@",@(code));
    }];
}

- (IBAction)shareToWeChat:(id)sender {
    BUKSocialData *data = [[BUKSocialData alloc] initWithTitle:@"123" content:@"非得说开了房间快乐撒进来看" url:@"http://baixing.com" image:[UIImage imageNamed:@"sample"]];
    BUKSocialShareManager *manager = [BUKSocialShareManager managerWithType:BUKSocialShareTypeWechatFriend];
    [manager shareData:data withCompletionHandler:^(BUKSocialShareResultCode code) {
        NSLog(@"%@",@(code));
    }];
}


- (IBAction)shareToWeChatTimeLine:(id)sender {
    BUKSocialData *data = [[BUKSocialData alloc] initWithTitle:@"123" content:@"非得说开了房间快乐撒进来看" url:@"http://baixing.com" image:[UIImage imageNamed:@"sample"]];
    BUKSocialShareManager *manager = [BUKSocialShareManager managerWithType:BUKSocialShareTypeWechatTimeline];
    [manager shareData:data withCompletionHandler:^(BUKSocialShareResultCode code) {
        NSLog(@"%@",@(code));
    }];
}
@end
