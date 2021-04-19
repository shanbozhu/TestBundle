//
//  PBContentController.m
//  TestOC
//
//  Created by Zhu,Shanbo on 2021/4/14.
//  Copyright © 2021 DaMaiIOS. All rights reserved.
//

#import "PBContentController.h"
#import "PBContentLabel.h"
#import "PBContentLabelItem.h"

@interface PBContentController ()

@end

@implementation PBContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat width = 250;
    NSInteger maximumNumberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"哈哈哈😄哈哈哈哈哈哈哈😄哈哈哈哈哈哈哈😄哈哈哈哈哈哈哈😄哈哈哈哈哈哈哈😄哈哈哈哈哈哈哈😄哈哈哈哈哈哈哈😄哈哈哈哈哈哈哈😄哈哈哈哈哈哈哈😄哈哈哈哈哈哈哈😄哈哈哈哈哈哈哈😄哈哈哈哈哈哈哈😄哈哈哈哈哈哈哈😄哈哈哈哈哈哈哈😄哈哈哈哈"];
    [attributedString addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} range:NSMakeRange(0, attributedString.string.length)];
    
    NSTextAttachment*attch = [[NSTextAttachment alloc]init];
      attch.image= [UIImage imageNamed:@"0022"];
//      attch.bounds=CGRectMake(0,0,32,32);//设置图片大小
    NSMutableAttributedString *at = [[NSAttributedString attributedStringWithAttachment:attch] mutableCopy];
    [at addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} range:NSMakeRange(0, at.length)];
      [attributedString appendAttributedString:at];
    
    
    PBContentLabelItem *contentLabelItem = [[PBContentLabelItem alloc] initWithWidth:width maximumNumberOfLines:maximumNumberOfLines attributedString:attributedString];

    //
    PBContentLabel *lab = [[PBContentLabel alloc] init];
    [self.view addSubview:lab];
    lab.layer.borderColor = [UIColor redColor].CGColor;
    lab.layer.borderWidth = 1;
    
    lab.frame = CGRectMake(50, APPLICATION_NAVIGATIONBAR_HEIGHT + 50, width, 0);
    lab.contentLabelItem = contentLabelItem;
    lab.pb_height = contentLabelItem.size.height;
}

@end
