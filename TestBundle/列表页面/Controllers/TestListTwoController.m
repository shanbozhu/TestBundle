//
//  TestListTwoController.m
//  TestBundle
//
//  Created by DaMaiIOS on 17/11/2.
//  Copyright © 2017年 DaMaiIOS. All rights reserved.
//

#import "TestListTwoController.h"
#import <objc/runtime.h>
#import "TestPerson.h"

@interface TestListTwoController ()


@end

@implementation TestListTwoController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"(2)动态交换两个方法的实现";
    
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:btn];
        btn.frame = CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width-40, 40);
        [btn setTitle:@"点我" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    
    
    

}

-(void)btnClick:(UIButton *)btn {
    
    
    TestPerson *testPerson = [[TestPerson alloc]init];
    
    Method m1 = class_getInstanceMethod(testPerson.class, @selector(name));
    Method m2 = class_getInstanceMethod(testPerson.class, @selector(sex));
    
    method_exchangeImplementations(m1, m2);
    
    
    [testPerson performSelector:@selector(name)];
    [testPerson performSelector:@selector(sex)];
}




@end
