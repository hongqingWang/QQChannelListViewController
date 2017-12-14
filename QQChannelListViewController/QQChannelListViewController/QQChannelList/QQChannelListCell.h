//
//  QQChannelListCell.h
//  QQChannelListViewController
//
//  Created by Mac on 13/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQChannel.h"

@interface QQChannelListCell : UICollectionViewCell

/// DeleteIamgeView
@property (nonatomic, strong) UIImageView *deleteImageView;
/// QQChannel
@property (nonatomic, strong) QQChannel *channel;
/// Title
@property (nonatomic, strong) UILabel *titleLabel;

@end
