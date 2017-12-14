//
//  QQChannelListCell.m
//  QQChannelListViewController
//
//  Created by Mac on 13/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQChannelListCell.h"
#import <Masonry.h>

@interface QQChannelListCell ()

@end

@implementation QQChannelListCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {

        [self setupUI];
    }
    return self;
}

#pragma mark - SetupUI
- (void)setupUI {
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.deleteImageView];

    self.titleLabel.frame = self.bounds;
    self.deleteImageView.frame = CGRectMake(self.bounds.size.width - 12, -5, 15, 15);
}

#pragma mark - Getters and Setters
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"推荐";
        _titleLabel.textColor = [UIColor darkGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
//        _titleLabel.backgroundColor = QQ_MY_CHANNEL_LIST_CELL_BACKGROUND_COLOR;
        _titleLabel.layer.cornerRadius = 5;
        _titleLabel.layer.masksToBounds = YES;
    }
    return _titleLabel;
}

- (UIImageView *)deleteImageView {
    if (_deleteImageView == nil) {
        _deleteImageView = [[UIImageView alloc] init];
        _deleteImageView.image = [UIImage imageNamed:@"qq_channel_list_delete"];
        _deleteImageView.hidden = YES;
    }
    return _deleteImageView;
}

@end
