//
//  QQChannelListViewFlowLayout.m
//  QQChannelListViewController
//
//  Created by Mac on 13/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQChannelListViewFlowLayout.h"

static CGFloat const margin = 10;
static CGFloat const qqChannelListHeaderViewHeight = 40;

#define QQ_CHANNEL_LIST_ITEM_WIDTH                  ([UIScreen mainScreen].bounds.size.width - 5 * margin - 20) / 4

@implementation QQChannelListViewFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, qqChannelListHeaderViewHeight);
    self.itemSize = CGSizeMake(QQ_CHANNEL_LIST_ITEM_WIDTH, QQ_CHANNEL_LIST_ITEM_WIDTH * 0.5);
    self.minimumInteritemSpacing = margin;
    self.minimumLineSpacing = margin;
    // 设置`SectionHeader`和`SectionCell`之间的距离
    self.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20);
}

@end
