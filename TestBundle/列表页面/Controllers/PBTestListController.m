//
//  PBTestListController.m
//  TestBundle
//
//  Created by DaMaiIOS on 17/7/9.
//  Copyright © 2017年 DaMaiIOS. All rights reserved.
//

#import "PBTestListController.h"
#import <objc/runtime.h>
#import "PBTestPerson.h"

@interface PBTestListController ()


@end

@implementation PBTestListController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"(0)动态变量控制";

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
    
    PBTestPerson *testPerson = [[PBTestPerson alloc]init];
    [testPerson setValue:@"xiaoming" forKey:@"_name"]; //kvc修改私有成员变量
    NSLog(@"name1 = %@", [testPerson valueForKey:@"_name"]);
    
    
    unsigned int count = 0;
    Ivar *ivar = class_copyIvarList([testPerson class], &count); //获取类的所有属性
    NSLog(@"count = %d", count);
    
    for (int i = 0; i < count; i++) {
        Ivar var = ivar[i];
        
        const char *varName = ivar_getName(var); //获取属性的c字符串名称
        NSString *name = [NSString stringWithUTF8String:varName]; //将c字符串转换为oc字符串
        
        if ([name isEqualToString:@"_name"]) { //oc字符串用于判断条件
            object_setIvar(testPerson, var, @"daming");
            break;
        }
        
    }
    NSLog(@"name2 = %@", [testPerson valueForKey:@"_name"]);
}




@end
