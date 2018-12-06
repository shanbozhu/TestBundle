//
//  PBTestController.m
//  TestBundle
//
//  Created by DaMaiIOS on 17/7/9.
//  Copyright © 2017年 DaMaiIOS. All rights reserved.
//

#import "PBTestController.h"
#import "PBTestListController.h"
#import "PBTestListOneController.h"
#import "PBTestListTwoController.h"

@interface PBTestController ()

@property (nonatomic, strong) NSArray *arr;

@end

@implementation PBTestController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.tableFooterView = [[UIView alloc]init];
    
    self.arr = @[@"(0)动态变量控制",
                 @"(1)动态添加方法",
                 @"(2)动态交换两个方法的实现"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    cell.textLabel.text = self.arr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        PBTestListController *testListController = [[PBTestListController alloc]init];
        testListController.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:testListController animated:YES];
        testListController.view.backgroundColor = [UIColor whiteColor];
    }
    
    if (indexPath.row == 1) {
        PBTestListOneController *testListOneController = [[PBTestListOneController alloc]init];
        testListOneController.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:testListOneController animated:YES];
        testListOneController.view.backgroundColor = [UIColor whiteColor];
    }
    
    if (indexPath.row == 2) {
        PBTestListTwoController *testListTwoController = [[PBTestListTwoController alloc]init];
        testListTwoController.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:testListTwoController animated:YES];
        testListTwoController.view.backgroundColor = [UIColor whiteColor];
    }
}

@end
