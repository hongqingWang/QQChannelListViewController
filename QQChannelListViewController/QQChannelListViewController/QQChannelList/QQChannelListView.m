//
//  QQChannelListView.m
//  QQChannelListViewController
//
//  Created by Mac on 12/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQChannelListView.h"

static NSString *const qqChannelListCellID = @"qqChannelListCellID";

@interface QQChannelListView ()<UICollectionViewDataSource, UICollectionViewDelegate>

/// closeButton
@property (nonatomic, strong) UIButton *closeButton;
/// carve
@property (nonatomic, strong) UIView *carve;
/// CollectionView
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation QQChannelListView

- (instancetype)init {
    if (self = [super init]) {
        self = [[QQChannelListView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20)];
        [self setupUI];
    }
    return self;
}

#pragma mark - SetupUI
- (void)setupUI {
    
    [self addSubview:self.closeButton];
    [self addSubview:self.carve];
    [self addSubview:self.collectionView];
}

#pragma mark - Event Response
- (void)close {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20);
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:qqChannelListCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}



#pragma mark - Getters and Setters
- (UIButton *)closeButton {
    if (_closeButton == nil) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"qq_nav_close"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        _closeButton.frame = CGRectMake(16, 16, 10, 10);
    }
    return _closeButton;
}

- (UIView *)carve {
    if (_carve == nil) {
        _carve = [[UIView alloc] init];
        _carve.backgroundColor = [UIColor lightGrayColor];
        _carve.frame = CGRectMake(0, 43.5, [UIScreen mainScreen].bounds.size.width, 0.5);
    }
    return _carve;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        CGRect frame = CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:qqChannelListCellID];
        _collectionView.backgroundColor = self.backgroundColor;
    }
    return _collectionView;
}

@end
