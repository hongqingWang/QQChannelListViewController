//
//  QQChannelListView.m
//  QQChannelListViewController
//
//  Created by Mac on 12/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQChannelListView.h"
#import "QQChannelListViewFlowLayout.h"
#import "QQChannelListCell.h"
#import "QQChannelListHeaderView.h"

static NSString *const qqChannelListCellIdentifier = @"qqChannelListCellIdentifier";
static NSString *const qqChannelListHeaderViewIdentifier = @"qqChannelListHeaderViewIdentifier";

#define QQ_MY_CHANNEL_LIST_CELL_BACKGROUND_COLOR        [UIColor colorWithRed:243 / 255.0 green:243 / 255.0 blue:243 / 255.0 alpha:1.0]
#define QQ_MORE_CHANNEL_LIST_CELL_BACKGROUND_COLOR      [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1.0]

@interface QQChannelListView ()<UICollectionViewDataSource, UICollectionViewDelegate, QQChannelListHeaderViewDelegate>

/// closeButton
@property (nonatomic, strong) UIButton *closeButton;
/// carve
@property (nonatomic, strong) UIView *carve;
/// CollectionView
@property (nonatomic, strong) UICollectionView *collectionView;
/// MyChannels
@property (nonatomic, strong) NSMutableArray *myChannelArrayM;
/// RecommandChannels
@property (nonatomic, strong) NSMutableArray *recommandChannelArrayM;
/// isEdit
@property (nonatomic, assign) BOOL isEdit;
/// HeaderTitle
@property (nonatomic, strong) NSArray *headerTitles;
/// HeaderSubTitle
@property (nonatomic, strong) NSArray *headerSubTitles;

@end

@implementation QQChannelListView

- (instancetype)initWithMyChannels:(NSArray *)myChannels recommandChannels:(NSArray *)recommandChannels {
    
    if (self = [super init]) {
        
        self = [[QQChannelListView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20)];
        [self setupUIWithMyChannels:myChannels recommandChannels:recommandChannels];
    }
    return self;
}

#pragma mark - SetupUI
- (void)setupUIWithMyChannels:(NSArray *)myChannels recommandChannels:(NSArray *)recommandChannels {

    [self.myChannelArrayM addObjectsFromArray:myChannels];
    [self.recommandChannelArrayM addObjectsFromArray:recommandChannels];
    // 默认不可编辑
    self.isEdit = NO;
    
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

#pragma mark - QQChannelListHeaderViewDelegate
- (void)channelListHeaderView:(QQChannelListHeaderView *)channelListHeaderView didClickEditButton:(UIButton *)button {
    
    self.isEdit = !self.isEdit;
    
//    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
//    [self.collectionView reloadSections:indexSet];
        [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return section == 0 ? self.myChannelArrayM.count : self.recommandChannelArrayM.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    QQChannelListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:qqChannelListCellIdentifier forIndexPath:indexPath];
    cell.deleteImageView.hidden = (self.isEdit && indexPath.section == 0) ? NO : YES;
    cell.titleLabel.backgroundColor = (indexPath.section == 0) ? QQ_MY_CHANNEL_LIST_CELL_BACKGROUND_COLOR : QQ_MORE_CHANNEL_LIST_CELL_BACKGROUND_COLOR;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    QQChannelListHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:qqChannelListHeaderViewIdentifier forIndexPath:indexPath];
    
    headerView.titleLabel.text = self.headerTitles[indexPath.section];
    headerView.subTitleLabel.text = self.isEdit ? self.headerSubTitles[0][indexPath.section] : self.headerSubTitles[1][indexPath.section];
    headerView.rightButton.hidden = (indexPath.section == 0) ? NO : YES;
    headerView.rightButton.selected = self.isEdit;
    
    headerView.delegate = self;
    
    return headerView;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld", indexPath.row);
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
        QQChannelListViewFlowLayout *flowLayout = [[QQChannelListViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[QQChannelListCell class] forCellWithReuseIdentifier:qqChannelListCellIdentifier];
        [_collectionView registerClass:[QQChannelListHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:qqChannelListHeaderViewIdentifier];
        _collectionView.backgroundColor = self.backgroundColor;
    }
    return _collectionView;
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

- (NSArray *)headerTitles {
    if (_headerTitles == nil) {
        _headerTitles = @[@"我的频道", @"频道推荐"];
    }
    return _headerTitles;
}

- (NSArray *)headerSubTitles {
    if (_headerSubTitles == nil) {
        _headerSubTitles = @[
                             @[@"拖拽可以排序", @"点击添加频道"],
                             @[@"点击进入频道", @"点击添加频道"]
                             ];
    }
    return _headerSubTitles;
}

@end
