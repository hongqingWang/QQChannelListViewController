//
//  QQChannelListViewController.h
//  QQChannelListViewController
//
//  Created by Mac on 12/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectCallBack)(NSArray *myChannels, NSArray *recommandChannels, NSInteger selectIndex);

@interface QQChannelListViewController : UIViewController

/// SelectCallBack
@property (nonatomic, copy) SelectCallBack selectCallBack;

@end
