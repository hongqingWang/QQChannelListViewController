//
//  ViewController.m
//  QQChannelListViewController
//
//  Created by Mac on 12/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "ViewController.h"
#import "QQChannelListViewController.h"
#import "QQChannelListView.h"

@interface ViewController ()

/// ChannelListView
@property (nonatomic, strong) QQChannelListView *channelListView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"标题";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(presentChannelListView)];
    [self.navigationController.view addSubview:self.channelListView];
}

#pragma mark - Event Response
- (void)presentChannelListView {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.channelListView.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20);
    }];
}

#pragma mark - Getters and Setters
- (QQChannelListView *)channelListView {
    if (_channelListView == nil) {
        _channelListView = [[QQChannelListView alloc] initWithMyChannels:@[@"aaa", @"bbb", @"ccc"] recommandChannels:@[@"ccc", @"ddd"]];
        _channelListView.backgroundColor = [UIColor whiteColor];
    }
    return _channelListView;
}

@end
