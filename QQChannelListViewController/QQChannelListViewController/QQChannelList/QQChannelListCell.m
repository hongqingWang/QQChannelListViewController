//
//  QQChannelListCell.m
//  QQChannelListViewController
//
//  Created by Mac on 13/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQChannelListCell.h"
#import "QQChannel.h"

#define QQ_MY_CHANNEL_LIST_CELL_BACKGROUND_COLOR        [UIColor colorWithRed:243 / 255.0 green:243 / 255.0 blue:243 / 255.0 alpha:1.0]
#define QQ_MORE_CHANNEL_LIST_CELL_BACKGROUND_COLOR      [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1.0]

@interface QQChannelListCell ()

@end

@implementation QQChannelListCell

- (void)setChannel:(QQChannel *)channel {
    _channel = channel;
    
    if (channel.channelType == MyChannel) {
        
        if (channel.resident) {
            self.titleLabel.textColor = [UIColor redColor];
            self.deleteImageView.hidden = YES;
        } else {
            self.titleLabel.textColor = [UIColor darkGrayColor];
        }
        if ([channel.title containsString:@"+"]) {
            channel.title = [channel.title substringFromIndex:1];
        }
        channel.editable = YES;
        self.titleLabel.backgroundColor = QQ_MY_CHANNEL_LIST_CELL_BACKGROUND_COLOR;
        
    } else if (channel.channelType == RecommandChannel) {
        
        if (![channel.title containsString:@"+"]) {
            channel.title = [@"+" stringByAppendingString:channel.title];
        }
        channel.editable = NO;
        self.deleteImageView.hidden = YES;
        self.titleLabel.textColor = [UIColor darkGrayColor];
        self.titleLabel.backgroundColor = QQ_MORE_CHANNEL_LIST_CELL_BACKGROUND_COLOR;
    }
    
    switch (channel.title.length) {
        case 2:
        {
            self.titleLabel.font = [UIFont systemFontOfSize:15];
        }
            break;
        case 3:
        {
            self.titleLabel.font = [UIFont systemFontOfSize:15];
        }
            break;
        case 4:
        {
            self.titleLabel.font = [UIFont systemFontOfSize:14];
        }
            break;
        case 5:
        {
            self.titleLabel.font = [UIFont systemFontOfSize:13];
        }
            break;
        case 6:
        {
            self.titleLabel.font = [UIFont systemFontOfSize:12];
        }
            break;
            
        default:
            break;
    }
    self.titleLabel.text = channel.title;
}

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
