//
//  QQChannelListHeaderView.m
//  QQChannelListViewController
//
//  Created by Mac on 13/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQChannelListHeaderView.h"

static CGFloat const margin = 10;

@interface QQChannelListHeaderView ()

/// Title
@property (nonatomic, strong) UILabel *titleLabel;
/// SubTitle
@property (nonatomic, strong) UILabel *subTitleLabel;
/// Button
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation QQChannelListHeaderView

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
    [self addSubview:self.subTitleLabel];
    [self addSubview:self.rightButton];
    
    self.titleLabel.frame = CGRectMake(2 * margin, 0, 70, 40);
    self.subTitleLabel.frame = CGRectMake(80 + 2 * margin, 5, 100, 35);
    self.rightButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 50 - 2 * margin, 7.5, 50, 25);
}

#pragma mark - Event Response
- (void)edit {
    
    self.rightButton.selected = !self.rightButton.selected;
}

#pragma mark - Getters and Setters
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"我的频道";
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    if (_subTitleLabel == nil) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.text = @"点击进入频道";
        _subTitleLabel.textColor = [UIColor lightGrayColor];
        _subTitleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _subTitleLabel;
}

- (UIButton *)rightButton {
    if (_rightButton == nil) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_rightButton setTitle:@"完成" forState:UIControlStateSelected];
        [_rightButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _rightButton.layer.borderColor = [UIColor redColor].CGColor;
        _rightButton.layer.borderWidth = 0.5;
        _rightButton.layer.cornerRadius = 25 / 2;
        _rightButton.layer.masksToBounds = YES;
        [_rightButton addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

@end
