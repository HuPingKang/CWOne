//
//  ONEDetailViewController.m
//  CWOne
//
//  Created by Coulson_Wang on 2017/8/5.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "ONEDetailViewController.h"
#import "ONEDetailTableViewController.h"
#import "ONEHomeNavigationController.h"

@interface ONEDetailViewController ()

@end

@implementation ONEDetailViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 先显示一个加载视图。数据加载完成后，再显示tableview
    
    // 隐藏自定义的titleView
    ONEHomeNavigationController *navVC = (ONEHomeNavigationController *)self.navigationController;
    [navVC hideCustomTitleView];
    
    // 设置NavBar
    
    // 添加子控制器
    ONEDetailTableViewController *detailTableVC = [[ONEDetailTableViewController alloc] init];
    [self addChildViewController:detailTableVC];
    
    // 添加tableView
    detailTableVC.view.frame = self.view.bounds;
    [self.view addSubview:detailTableVC.view];
    
    // 添加自定义的底部工具条
}

@end
