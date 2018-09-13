//
//  KKRrefreshControl.m
//  下拉刷新
//
//  Created by kkmac on 2018/9/13.
//  Copyright © 2018年 kkmac. All rights reserved.
//

#import "KKRefreshControl.h"

typedef NS_ENUM(NSInteger, KKRrefreshControlState) {
    Normal = 0,
    Pulling = 1,
    Refreshing = 2,
};


@interface KKRefreshControl()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, assign) KKRrefreshControlState refreshState;
@property (nonatomic, assign) KKRrefreshControlState oldState;
@end



@implementation KKRefreshControl

+ (instancetype)headeraWithRefreshingTarget:(id)target refreshingAction:(SEL)action {
    KKRefreshControl *refresh = [[KKRefreshControl alloc]  init];
    [refresh addTarget:target refreshingAction:action];
    return refresh;
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    CGFloat refreshX = 0;
    CGFloat refreshH = 64;
    CGFloat refreshY = -refreshH;
    CGFloat refreshW = CGRectGetWidth([UIScreen mainScreen].bounds);
    self = [super initWithFrame:CGRectMake(refreshX, refreshY, refreshW, refreshH)];
    if (self) {
        [self addControl];
    }
    return self;
}

//即将加载到哪个父类试图
- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        if ([newSuperview isKindOfClass:[UIScrollView class]]) {
            self.scrollView = (UIScrollView *)newSuperview;
            //监听scrollView的contentOffset
            [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
            
        }
    }
}

//监听contentOffset
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    //判断用户是否正在拖动
    if (self.scrollView.dragging) {
        NSLog(@"%d", self.scrollView.isDecelerating);
        if (self.scrollView.contentOffset.y > -128 && self.refreshState == Pulling) {//下拉
            self.label.text = @"下拉刷新";
            self.refreshState = Normal;
        }else if (self.scrollView.contentOffset.y <= -128 && self.refreshState == Normal) {
            self.label.text = @"松开立即刷新";
            self.refreshState = Pulling;
        }else {
            
        }
    }else {
        NSLog(@"=====");
        if (self.refreshState == Pulling) {
            self.refreshState = Refreshing;
            self.label.text = @"正在刷新";
        }
    }
    [self sizeLabelToFit];
    
}

- (void)addControl {
    [self addSubview:self.label];
}

/**
 *  提供给外界调用的方法,  .h文件里面有这个方法
 */
- (void)endRefreshing {
    self.refreshState = Normal;
}


/**
 监听刷新

 @param target 监听者
 @param action 开始刷新执行方法
 */
- (void)addTarget:(id)target refreshingAction:(SEL)action {
    [self addTarget:target action:action forControlEvents:UIControlEventValueChanged];
}

/**
 自动下拉刷新
 */
- (void)beginRefresh {
    self.refreshState = Pulling;
}

- (void)dealloc {
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)setRefreshState:(KKRrefreshControlState)refreshState {
    _refreshState = refreshState;
    UIEdgeInsets inset = self.scrollView.contentInset;
    switch (refreshState) {
        case Normal: {
            if (self.oldState == Refreshing) {
                [UIView animateWithDuration:0.5 animations:^{
                    self.scrollView.contentInset = UIEdgeInsetsMake(inset.top-128, inset.left, inset.bottom, inset.right);
                }];
                
            }
        }
            break;
        case Pulling:
            break;
            
        case Refreshing: {
            [self sendActionsForControlEvents:UIControlEventValueChanged];
            [UIView animateWithDuration:0.5 animations:^{
               self.scrollView.contentInset = UIEdgeInsetsMake(inset.top + 128, inset.left, inset.bottom, inset.right);
            }];
        }
            
            break;
            
        default:
            break;
    }
    self.oldState = refreshState;
}


- (UILabel *)label {
    if (_label == nil) {
        CGFloat width = 100;
        CGFloat x = ([UIScreen mainScreen].bounds.size.width-width)/2.0;
        _label = [[UILabel alloc] initWithFrame:CGRectMake(x, 10, width, 44)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = @"下拉刷新";
        [self sizeLabelToFit];
    }
    return _label;
}

- (void)sizeLabelToFit {
    [_label sizeToFit];
    _label.center = CGPointMake(self.center.x, _label.center.y);
}


@end





