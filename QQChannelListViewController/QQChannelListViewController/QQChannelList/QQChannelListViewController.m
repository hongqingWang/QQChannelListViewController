//
//  QQChannelListViewController.m
//  QQChannelListViewController
//
//  Created by Mac on 12/12/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

#import "QQChannelListViewController.h"

@interface QQChannelListViewController ()

/// closeButton
@property (nonatomic, strong) UIButton *closeButton;
/// collectionView
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation QQChannelListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - SetupUI
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor colorWithWhite:255.0 alpha:0.1];
    [self.view addSubview:self.closeButton];
    [self.view addSubview:self.collectionView];
}

#pragma mark - Event Response
- (void)close {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Getters and Setters
- (UIButton *)closeButton {
    if (_closeButton == nil) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"qq_nav_close"] forState:UIControlStateNormal];
        _closeButton.frame = CGRectMake(16, 16 + 16, 20, 20);
        [_closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        CGRect frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor redColor];
    }
    return _collectionView;
}

@end
