//
//  QQChannelListHeaderView.m
//  QQChannelListViewController
//
//  Created by Mac on 13/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQChannelListHeaderView.h"

@implementation QQChannelListHeaderView

+ (instancetype)qq_channelListHeaderViewWithCollectionView:(UICollectionView *)collectionView reuseIdentifier:(NSString *)reuseIdentifier atIndexPath:(NSIndexPath *)indexPath {
    
    QQChannelListHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    headerView.backgroundColor = [UIColor yellowColor];
    
    return headerView;
}

@end
