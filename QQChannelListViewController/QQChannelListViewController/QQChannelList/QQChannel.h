//
//  QQChannel.h
//  QQChannelListViewController
//
//  Created by Mac on 12/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ChannelType) {
    MyChannel,
    RecommandChannel
};

@interface QQChannel : NSObject

/// 固定频道
@property (nonatomic, assign) BOOL resident;
/// 可编辑频道
@property (nonatomic, assign) BOOL editable;
/// 标题
@property (nonatomic, copy) NSString *title;
/// 是否被选中
@property (nonatomic, assign) BOOL isSelected;
/// 频道类型
@property (nonatomic, assign) ChannelType channelType;

@end
