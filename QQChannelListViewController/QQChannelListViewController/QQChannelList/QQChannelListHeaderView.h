//
//  QQChannelListHeaderView.h
//  QQChannelListViewController
//
//  Created by Mac on 13/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QQChannelListHeaderView;

@protocol QQChannelListHeaderViewDelegate <NSObject>

- (void)channelListHeaderView:(QQChannelListHeaderView *)channelListHeaderView didClickEditButton:(UIButton *)button;

@end

@interface QQChannelListHeaderView : UICollectionReusableView

/// Title
@property (nonatomic, strong) UILabel *titleLabel;
/// SubTitle
@property (nonatomic, strong) UILabel *subTitleLabel;
/// Button
@property (nonatomic, strong) UIButton *rightButton;

/// QQChannelListHeaderViewDelegate
@property (nonatomic, weak) id <QQChannelListHeaderViewDelegate> delegate;

@end
