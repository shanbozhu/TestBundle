//
//  PBTestListTwoCell.h
//  TestOC
//
//  Created by Zhu,Shanbo on 2019/6/26.
//  Copyright © 2019年 DaMaiIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBTestTwoEspressos.h"

NS_ASSUME_NONNULL_BEGIN

@interface PBTestListTwoCell : UITableViewCell

@property (nonatomic, strong) PBTestTwoEspressos *testTwoEspressos;

+ (id)testListTwoCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
