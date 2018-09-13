//
//  ViewController.m
//  下拉刷新
//
//  Created by kkmac on 2018/9/13.
//  Copyright © 2018年 kkmac. All rights reserved.
//

#import "ViewController.h"
#import "KKRefreshControl.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *refreshView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) KKRefreshControl *refreshControl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    
//    self.refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, -50, CGRectGetWidth(self.view.frame), 50)];
//    [self.tableView addSubview:self.refreshView];
//
//    _label = [[UILabel alloc] initWithFrame:self.refreshView.bounds];
//    _label.textAlignment = NSTextAlignmentCenter;
//    [self.refreshView addSubview:_label];
    _refreshControl = [KKRefreshControl headeraWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    [self.tableView addSubview:_refreshControl];
    [_refreshControl beginRefresh];
    
}

- (void)refresh {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView.contentOffset.y >= 0) {
//        return;
//    }
//    if (scrollView.contentInset.top == 149) {
//        return;
//    }
//
//    if (scrollView.contentOffset.y <= -149.0) {
//        self.label.text = @"松开立即刷新";
//    }else {
//        self.label.text = @"下拉可以刷新";
//    }
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    if (scrollView.contentOffset.y <= -149.0) {
//        self.label.text = @"正在刷新";
//        [UIView animateWithDuration:1.0 animations:^{
//            UIEdgeInsets inset = scrollView.contentInset;
//            inset.top = 149;
//            scrollView.contentInset = inset;
//        }];
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            UIEdgeInsets inset = scrollView.contentInset;
//            inset.top = 0;
//            scrollView.contentInset = inset;
//        });
//    }
//}





@end








