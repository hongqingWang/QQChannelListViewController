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
/// selectIndex
@property (nonatomic, assign) NSInteger selectIndex;
/// isEdit
@property (nonatomic, assign) BOOL isEdit;
/// HeaderTitle
@property (nonatomic, strong) NSArray *headerTitles;
/// HeaderSubTitle
@property (nonatomic, strong) NSArray *headerSubTitles;

@end

@implementation QQChannelListView

- (instancetype)initWithMyChannels:(NSArray *)myChannels recommandChannels:(NSArray *)recommandChannels selectIndex:(NSInteger)selectIndex {
    
    if (self = [super init]) {
        
        self = [[QQChannelListView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20)];
        [self setupUIWithMyChannels:myChannels recommandChannels:recommandChannels selectIndex:selectIndex];
    }
    return self;
}

#pragma mark - SetupUI
- (void)setupUIWithMyChannels:(NSArray *)myChannels recommandChannels:(NSArray *)recommandChannels selectIndex:(NSInteger)selectIndex {
    
    for (NSString *title in myChannels) {
        
        QQChannel *channel = [[QQChannel alloc] init];
        channel.title = title;
        
        if ([title isEqualToString:@"推荐"]) {
            channel.resident = YES;
            channel.isSelected = YES;
        }
        channel.editable = YES;
        channel.isSelected = NO;
        channel.channelType = MyChannel;
        [self.myChannelArrayM addObject:channel];
    }
    
    for (NSString *title in recommandChannels) {
        
        QQChannel *channel = [[QQChannel alloc] init];
        channel.title = title;
        channel.editable = NO;
        channel.channelType = RecommandChannel;
        [self.recommandChannelArrayM addObject:channel];
    }
    self.selectIndex = selectIndex;
    // 默认不可编辑
    self.isEdit = NO;
    
    [self addSubview:self.closeButton];
    [self addSubview:self.carve];
    [self addSubview:self.collectionView];
}

#pragma mark - Event Response
- (void)close {
    
    if (self.isEdit) {
        self.isEdit = !self.isEdit;
    }
    [self.collectionView reloadData];
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20);
    } completion:^(BOOL finished) {
        
        self.selectCallBack(self.myChannelArrayM, self.recommandChannelArrayM, self.selectIndex);
    }];
}

/**
 * 长按手势
 */
- (void)longPress:(UILongPressGestureRecognizer *)longPress {
    
//    if (!self.isEdit) {
//        self.isEdit = !self.isEdit;
////        [self.collectionView reloadData];
////        return;
//    }
    
    
    
    
    
    CGPoint point = [longPress locationInView:self.collectionView];
    NSIndexPath *sourceIndexPath = [self.collectionView indexPathForItemAtPoint:point];
    
    NSLog(@"%@", NSStringFromCGPoint(point));
    // 如果
//    if (sourceIndexPath.section != 0) {
//        NSLog(@"aaaa");
//    }
    
//    if (sourceIndexPath.section == 0 && sourceIndexPath.item == 0) {
//        NSLog(@"aaa");
//        return;
//    }
    
    
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
        {
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:sourceIndexPath];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self.collectionView updateInteractiveMovementTargetPosition:point];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
//            if (sourceIndexPath.section == 1) {
//                return;
//            }
            [self.collectionView endInteractiveMovement];
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            [self.collectionView cancelInteractiveMovement];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - QQChannelListHeaderViewDelegate
- (void)channelListHeaderView:(QQChannelListHeaderView *)channelListHeaderView didClickEditButton:(UIButton *)button {
    
    self.isEdit = !self.isEdit;
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
    
    cell.channel = (indexPath.section == 0) ? self.myChannelArrayM[indexPath.row] : self.recommandChannelArrayM[indexPath.row];
    cell.deleteImageView.hidden = (self.isEdit && cell.channel.editable && !cell.channel.resident) ? NO : YES;
    
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

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0 && indexPath.row == 1) {
//        return NO;
//    }
    QQChannelListCell *cell = (QQChannelListCell *)[collectionView cellForItemAtIndexPath:indexPath];
    return (indexPath.section == 0 && !cell.channel.resident) ? YES : NO;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && !self.isEdit) {
        
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20);
        } completion:^(BOOL finished) {
            
            self.selectCallBack(self.myChannelArrayM, self.recommandChannelArrayM, indexPath.row);
        }];
    }
    
    if (indexPath.section == 0 && self.isEdit) {
        
        QQChannelListCell *cell = (QQChannelListCell *)[collectionView cellForItemAtIndexPath:indexPath];
        
        if (cell.channel.resident) {
            return;
        } else {
            
            cell.channel.channelType = RecommandChannel;
            //        cell.channel.editable = NO;
            [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
            [self.myChannelArrayM removeObjectAtIndex:indexPath.item];
            [self.recommandChannelArrayM insertObject:cell.channel atIndex:0];
            NSIndexPath *destinationIndexPath = [NSIndexPath indexPathForItem:0 inSection:1];
            [self.collectionView moveItemAtIndexPath:indexPath toIndexPath:destinationIndexPath];
        }
    }
    
    if (indexPath.section == 1) {
        
        QQChannelListCell *cell = (QQChannelListCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.channel.channelType = MyChannel;
//        cell.channel.editable = YES;
        [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
        [self.recommandChannelArrayM removeObjectAtIndex:indexPath.item];
        [self.myChannelArrayM addObject:cell.channel];
        NSIndexPath *destinationIndexPath = [NSIndexPath indexPathForItem:self.myChannelArrayM.count - 1 inSection:0];
        [self.collectionView moveItemAtIndexPath:indexPath toIndexPath:destinationIndexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
//    if (destinationIndexPath.section == 0 && destinationIndexPath.row == 0) {
//        NSLog(@"移动到固定标签位置了");
//        return;
//    }
    
    QQChannel *channel = self.myChannelArrayM[sourceIndexPath.item];
    [self.myChannelArrayM removeObjectAtIndex:sourceIndexPath.item];
    
    if (destinationIndexPath.section == 0) {
        
        [self.myChannelArrayM insertObject:channel atIndex:destinationIndexPath.item];
    } else if (destinationIndexPath.section == 1) {
        channel.channelType = RecommandChannel;
        [self.recommandChannelArrayM insertObject:channel atIndex:destinationIndexPath.item];
    }
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
//        [_collectionView addSubview:self.myChannelView];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[QQChannelListCell class] forCellWithReuseIdentifier:qqChannelListCellIdentifier];
        [_collectionView registerClass:[QQChannelListHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:qqChannelListHeaderViewIdentifier];
        _collectionView.backgroundColor = self.backgroundColor;
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [_collectionView addGestureRecognizer:longPress];
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
