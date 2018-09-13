//
//  KKRrefreshControl.h
//  下拉刷新
//
//  Created by kkmac on 2018/9/13.
//  Copyright © 2018年 kkmac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKRefreshControl : UIControl
+ (instancetype)headeraWithRefreshingTarget:(id)target refreshingAction:(SEL)action;
/**
 *  提供给外界调用的方法,  .h文件里面有这个方法
 */
- (void)endRefreshing;
/**
 监听刷新
 
 @param target 监听者
 @param action 开始刷新执行方法
 */
- (void)addTarget:(id)target refreshingAction:(SEL)action;

/**
 自动开始刷新
 */
- (void)beginRefresh;
@end
