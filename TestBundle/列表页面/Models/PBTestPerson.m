//
//  PBTestPerson.m
//  TestBundle
//
//  Created by DaMaiIOS on 17/11/2.
//  Copyright © 2017年 DaMaiIOS. All rights reserved.
//

#import "PBTestPerson.h"

@interface PBTestPerson ()

@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *sex;


@end

@implementation PBTestPerson

-(NSString *)name {
    NSLog(@"i am bobo");
    return _name;
}

-(NSString *)sex {
    NSLog(@"i am man");
    return _sex;
}

@end
