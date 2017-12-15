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
#import "QQChannel.h"

@interface ViewController ()

/// ChannelListView
@property (nonatomic, strong) QQChannelListView *channelListView;
/// MyChannels
@property (nonatomic, strong) NSMutableArray *myChannelArrayM;
/// RecommandChannels
@property (nonatomic, strong) NSMutableArray *recommandChannelArrayM;
/// selectIndex
@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"标题";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(presentChannelListView)];
    
    self.myChannelArrayM = [NSMutableArray arrayWithObjects:@"推荐", @"热点", @"北京", @"视频",
//                            @"社会", @"娱乐", @"问答", @"汽车",
//                            @"财经", @"军事", @"体育", @"段子",
//                            @"美女", @"时尚", @"国际", @"趣图",
//                            @"健康", @"特卖", @"房产", @"养生",
//                            @"历史", @"育儿", @"小说", @"教育",
                            @"搞笑", nil];
    self.recommandChannelArrayM = [NSMutableArray arrayWithObjects:@"科技", @"直播", @"数码", @"美食",
//                                   @"电影", @"手机", @"旅游", @"股票",
//                                   @"科学", @"动漫", @"故事", @"收藏",
//                                   @"精选", @"语录", @"星座", @"美图",
//                                   @"政务", @"辟谣", @"火山直播", @"中国新唱将",
                                   @"彩票", @"快乐男生", @"正能量", nil];
    
    self.selectIndex = 3;
    
    self.channelListView.selectCallBack = ^(NSArray *myChannels, NSArray *recommandChannels, NSInteger selectIndex) {
        
        for (QQChannel *channel in myChannels) {
            NSLog(@"myChannels = %@", channel.title);
        }
        
        for (QQChannel *channel in recommandChannels) {
            NSLog(@"recommandChannels = %@", channel.title);
        }
        
        NSLog(@"%ld", selectIndex);
    };
}

#pragma mark - Event Response
- (void)presentChannelListView {
    
    [self.navigationController.view addSubview:self.channelListView];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.channelListView.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20);
    }];
}

#pragma mark - Getters and Setters
- (QQChannelListView *)channelListView {
    if (_channelListView == nil) {
        _channelListView = [[QQChannelListView alloc] initWithMyChannels:self.myChannelArrayM recommandChannels:self.recommandChannelArrayM selectIndex:self.selectIndex];
        _channelListView.backgroundColor = [UIColor whiteColor];
        
    }
    return _channelListView;
}

- (NSMutableArray *)myChannelArrayM {
    if (_myChannelArrayM == nil) {
        _myChannelArrayM = [NSMutableArray array];
    }
    return _myChannelArrayM;
}

- (NSMutableArray *)recommandChannelArrayM {
    if (_recommandChannelArrayM == nil) {
        _recommandChannelArrayM = [NSMutableArray array];
    }
    return _recommandChannelArrayM;
}

@end
