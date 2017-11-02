//
//  TestListOneController.m
//  TestBundle
//
//  Created by DaMaiIOS on 17/11/2.
//  Copyright © 2017年 DaMaiIOS. All rights reserved.
//

#import "TestListOneController.h"
#import <objc/runtime.h>
#import "TestPerson.h"

@implementation TestListOneController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"(1)动态添加方法";
    
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
    
    class_addMethod([testPerson class], @selector(myfunc), (IMP)myfuncMethod, "v@:");
    if ([testPerson respondsToSelector:@selector(myfunc)]) {
        [testPerson performSelector:@selector(myfunc) withObject:@"test"];
    } else {
        NSLog(@"没有定义该方法");
    }
    
}

void myfuncMethod (id self, SEL _cmd, NSString *content) {
    NSLog(@"我执行了, %@", content);
}


@end
