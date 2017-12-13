//
//  QQChannelListHeaderView.h
//  QQChannelListViewController
//
//  Created by Mac on 13/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QQChannelListHeaderView : UICollectionReusableView

+ (instancetype)qq_channelListHeaderViewWithCollectionView:(UICollectionView *)collectionView reuseIdentifier:(NSString *)reuseIdentifier atIndexPath:(NSIndexPath *)indexPath;

@end
