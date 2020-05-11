//
//  PBYYTextCell.m
//  TestOC
//
//  Created by DaMaiIOS on 17/9/28.
//  Copyright © 2017年 DaMaiIOS. All rights reserved.
//

#import "PBYYTextCell.h"
#import <YYText/YYText.h>
#import <YYImage/YYImage.h>
#import "PBRegex.h"

@interface PBYYTextCell ()

@property (nonatomic, weak) YYLabel *fourLab;
@property (nonatomic, weak) YYTextView *textView;
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation PBYYTextCell

+ (id)testListCellWithTableView:(UITableView *)tableView {
    [tableView registerClass:[self class] forCellReuseIdentifier:@"PBYYTextCell"];
    PBYYTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PBYYTextCell"];
    cell.tableView = tableView;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)setTestList:(PBYYText *)testList {
    _testList = testList;
    
    [self fillTestListCell];
}


- (void)fillTestListCell {
    // 移除自定义视图上的所有子视图
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    NSString *str = @"我爱北京天安门我爱北京天安门我爱北京天安门我爱北京天安门我爱北京天安门我爱北京天｜安｜门我爱北京天安门我爱北京天安门我爱北京天安门我爱北京天安门我爱北京天安门我爱北京天安门我爱北京北京天安门我爱北京天安门我爱北京https://www.baidu.com/我爱北京天安门#爱北京天安#安门我爱北京天shanbo.zsb@alibaba-inc.com安门我爱北京天安门我爱北京天17600108786安门我爱北京天安@门我爱北京天安:爱北京天安门我爱我爱";
    
    // threeLab
    YYLabel *threeLab = [[YYLabel alloc]init];
    [self.contentView addSubview:threeLab];
    //threeLab.layer.borderColor = [UIColor redColor].CGColor;
    //threeLab.layer.borderWidth = 1;
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attStr yy_setFont:[UIFont systemFontOfSize:15] range:NSMakeRange(0, attStr.length)];
    [attStr yy_setLineSpacing:18 range:NSMakeRange(0, attStr.length)];
    [attStr yy_setColor:[UIColor darkGrayColor] range:NSMakeRange(0, attStr.length)];
    
    threeLab.textTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        NSLog(@"点击了文本,需要折叠");
        self.testList.fold = YES;
        [self.delegate testListCell:self];
    };
    
    // 文本截断
    NSMutableAttributedString *moreStr = [[NSMutableAttributedString alloc]initWithString:@"...展开全文"];
    [moreStr yy_setFont:attStr.yy_font range:moreStr.yy_rangeOfAll];
    [moreStr yy_setTextHighlightRange:moreStr.yy_rangeOfAll color:[UIColor blueColor] backgroundColor:[UIColor redColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"点击了更多,需要展开");
        self.testList.fold = NO;
        [self.delegate testListCell:self];
    }];
    
    YYLabel *moreLab = [[YYLabel alloc]init];
    moreLab.textAlignment = NSTextAlignmentCenter;
    moreLab.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    YYTextLayout *moreTextLayout = [YYTextLayout layoutWithContainerSize:CGSizeMake(200, 200) text:moreStr];
    moreLab.frame = CGRectMake(0, 0, moreTextLayout.textBoundingSize.width, moreTextLayout.textBoundingSize.height);
    moreLab.textLayout = moreTextLayout;
    
    NSMutableAttributedString *moreTruncationTokenStr = [NSMutableAttributedString yy_attachmentStringWithContent:moreLab contentMode:UIViewContentModeCenter attachmentSize:moreLab.frame.size alignToFont:attStr.yy_font alignment:YYTextVerticalAlignmentTop];
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-40, 100000)];
    container.truncationToken = moreTruncationTokenStr;
    container.truncationType = YYTextTruncationTypeEnd;
    if (self.testList.fold == YES) {
        container.maximumNumberOfRows = 3;
    } else {
        container.maximumNumberOfRows = 0;
    }
        
    YYTextLayout *threeTextLayout = [YYTextLayout layoutWithContainer:container text:attStr];
    threeLab.frame = CGRectMake(20, 20, threeTextLayout.textBoundingSize.width, threeTextLayout.textBoundingSize.height);
    threeLab.textLayout = threeTextLayout;
    
    // fourLab
    YYLabel *fourLab = [[YYLabel alloc]init];
    self.fourLab = fourLab;
    [self.contentView addSubview:fourLab];
    fourLab.frame = CGRectMake(20, CGRectGetMaxY(threeLab.frame)+50, [UIScreen mainScreen].bounds.size.width-40, 100000);
    //fourLab.layer.borderColor = [UIColor redColor].CGColor;
    //fourLab.layer.borderWidth = 1;
    fourLab.numberOfLines = 0;
    fourLab.textAlignment = NSTextAlignmentCenter;
    fourLab.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    //fourLab.displaysAsynchronously = YES;
    
    attStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attStr yy_setFont:[UIFont systemFontOfSize:15] range:NSMakeRange(0, attStr.length)];
    [attStr yy_setLineSpacing:18 range:NSMakeRange(0, attStr.length)];
    [attStr yy_setColor:[UIColor darkGrayColor] range:NSMakeRange(0, attStr.length)];
    [attStr yy_setColor:[UIColor redColor] range:NSMakeRange(8, 5)];
    
    // 图标
    UIImageView *iconImageView = [[UIImageView alloc]init];
    iconImageView.frame = CGRectMake(0, 0, 40, 12);
    //iconImageView.frame = CGRectMake(0, 0, CGRectGetWidth(fourLab.frame), 150); // 推荐此种宽度写法
    iconImageView.layer.cornerRadius = 3;
    iconImageView.layer.masksToBounds = YES;
    iconImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *zeroTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [iconImageView addGestureRecognizer:zeroTap];
    zeroTap.view.tag = 0;
    
    // 图标(渐变色)
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = iconImageView.bounds;
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(2, 0);
    for (CALayer *sublayer in iconImageView.layer.sublayers) {
        [sublayer removeFromSuperlayer];
    }
    [iconImageView.layer insertSublayer:layer atIndex:0];
    layer.colors = [NSArray arrayWithObjects:(id)[UIColor redColor].CGColor, (id)[UIColor blueColor].CGColor, nil];
    
    NSMutableAttributedString *attachStrZero = [NSMutableAttributedString yy_attachmentStringWithContent:iconImageView contentMode:UIViewContentModeCenter attachmentSize:iconImageView.frame.size alignToFont:attStr.yy_font alignment:YYTextVerticalAlignmentCenter];
    [attachStrZero yy_setLineSpacing:attStr.yy_lineSpacing range:attachStrZero.yy_rangeOfAll];
    [attStr insertAttributedString:attachStrZero atIndex:1];
    
    // 空心字
    [attStr yy_setStrokeWidth:@(2) range:NSMakeRange(25, 5)];
    [attStr yy_setStrokeColor:[UIColor blueColor] range:NSMakeRange(25, 5)];
    
    // 下划线,删除线
    YYTextDecoration *decoration = [YYTextDecoration decorationWithStyle:YYTextLineStyleSingle width:@(2) color:[UIColor redColor]];
    [attStr yy_setTextStrikethrough:decoration range:NSMakeRange(35, 5)];
    [attStr yy_setTextUnderline:decoration range:NSMakeRange(35, 5)];
    
    // 边框
    YYTextBorder *border = [[YYTextBorder alloc]init];
    border.strokeColor = [UIColor blueColor];
    border.strokeWidth = 2;
    border.cornerRadius = 3;
    border.lineStyle = YYTextLineStyleSingle;
    [attStr yy_setTextBorder:border range:NSMakeRange(45, 5)];
    
    // 阴影
    YYTextShadow *shadow = [[YYTextShadow alloc]init];
    shadow.color = [UIColor redColor];
    shadow.radius = 1;
    shadow.offset = CGSizeMake(2, 2);
    [attStr yy_setTextShadow:shadow range:NSMakeRange(55, 5)];
    
    // 文本内阴影
    YYTextShadow *innerShadow = [[YYTextShadow alloc]init];
    innerShadow.color = [UIColor redColor];
    innerShadow.radius = 1;
    innerShadow.offset = CGSizeMake(1, 1);
    [attStr yy_setTextInnerShadow:innerShadow range:NSMakeRange(65, 5)];
    
    // 点击高亮
    [attStr yy_setTextHighlightRange:NSMakeRange(75, 5) color:[UIColor blueColor] backgroundColor:[UIColor lightGrayColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"%@", [attStr.string substringWithRange:range]);
    }];
    
    // 点击高亮自定义
    UIColor *normalColor = [UIColor blueColor];
    [attStr yy_setColor:normalColor range:NSMakeRange(85, 5)];
    YYTextDecoration *normalDecoration = [YYTextDecoration decorationWithStyle:YYTextLineStyleSingle width:@(1) color:normalColor];
    [attStr yy_setTextUnderline:normalDecoration range:NSMakeRange(85, 5)];
    
    UIColor *highlightColor = [UIColor redColor];
    YYTextDecoration *highlightDecoration = [YYTextDecoration decorationWithStyle:YYTextLineStyleSingle width:@(1) color:highlightColor];
    YYTextHighlight *highlight = [[YYTextHighlight alloc]init];
    [highlight setColor:highlightColor];
    [highlight setUnderline:highlightDecoration];
    
    YYTextBorder *highlightBorder = [[YYTextBorder alloc]init];
    highlightBorder.insets = UIEdgeInsetsMake(-2, 0, -2, 0);
    highlightBorder.cornerRadius = 3;
    highlightBorder.fillColor = [UIColor greenColor];
    [highlight setBackgroundBorder:highlightBorder];
    highlight.tapAction =  ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        NSLog(@"%@", [attStr.string substringWithRange:range]);
    };
    [attStr yy_setTextHighlight:highlight range:NSMakeRange(85, 5)];
    
    // 斜体
    [attStr yy_setObliqueness:@(0.6) range:NSMakeRange(95, 5)];
    
    // @用户名称
    NSArray *resultAt = [[PBRegex regexAt]matchesInString:attStr.string options:kNilOptions range:attStr.yy_rangeOfAll];
    for (NSTextCheckingResult *at in resultAt) {
        if (at.range.location == NSNotFound && at.range.length <= 1) {
            continue;
        }
        
        if ([attStr yy_attribute:YYTextHighlightAttributeName atIndex:at.range.location] == nil) {
            [attStr yy_setColor:[UIColor blueColor] range:at.range];
            
            YYTextHighlight *highlight = [[YYTextHighlight alloc]init];
            
            YYTextBorder *highlightBorder = [[YYTextBorder alloc]init];
            highlightBorder.insets = UIEdgeInsetsMake(-2, 0, -2, 0);
            highlightBorder.cornerRadius = 3;
            highlightBorder.fillColor = [UIColor greenColor];
            [highlight setBackgroundBorder:highlightBorder];
            
            __weak typeof(highlight) weakHighlight = highlight;
            highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
                NSLog(@"%@, highlight = %@, yy_attribute = %@", [attStr.string substringWithRange:at.range], weakHighlight, [attStr yy_attribute:YYTextHighlightAttributeName atIndex:at.range.location]);
            };
            
            [attStr yy_setTextHighlight:highlight range:at.range];
        }
    }
    
    // #话题
    NSArray *resultTopic = [[PBRegex regexTopic]matchesInString:attStr.string options:kNilOptions range:attStr.yy_rangeOfAll];
    for (NSTextCheckingResult *at in resultTopic) {
        if (at.range.location == NSNotFound && at.range.length <= 1) {
            continue;
        }
        
        if ([attStr yy_attribute:YYTextHighlightAttributeName atIndex:at.range.location] == nil) {
            [attStr yy_setColor:[UIColor blueColor] range:at.range];
            
            YYTextHighlight *highlight = [[YYTextHighlight alloc]init];
            
            YYTextBorder *highlightBorder = [[YYTextBorder alloc]init];
            highlightBorder.insets = UIEdgeInsetsMake(-2, 0, -2, 0);
            highlightBorder.cornerRadius = 3;
            highlightBorder.fillColor = [UIColor greenColor];
            [highlight setBackgroundBorder:highlightBorder];
            
            highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
                NSLog(@"%@, yy_attribute = %@", [attStr.string substringWithRange:at.range], [attStr yy_attribute:YYTextHighlightAttributeName atIndex:at.range.location]);
            };
            
            [attStr yy_setTextHighlight:highlight range:at.range];
        }
    }
    
    // 邮件
    NSArray *resultEmail = [[PBRegex regexEmail]matchesInString:attStr.string options:kNilOptions range:attStr.yy_rangeOfAll];
    for (NSTextCheckingResult *at in resultEmail) {
        if (at.range.location == NSNotFound && at.range.length <= 1) {
            continue;
        }
        
        if ([attStr yy_attribute:YYTextHighlightAttributeName atIndex:at.range.location] == nil) {
            [attStr yy_setColor:[UIColor blueColor] range:at.range];
            
            YYTextHighlight *highlight = [[YYTextHighlight alloc]init];
            
            YYTextBorder *highlightBorder = [[YYTextBorder alloc]init];
            highlightBorder.insets = UIEdgeInsetsMake(-2, 0, -2, 0);
            highlightBorder.cornerRadius = 3;
            highlightBorder.fillColor = [UIColor greenColor];
            [highlight setBackgroundBorder:highlightBorder];
            
            highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
                NSLog(@"%@, yy_attribute = %@", [attStr.string substringWithRange:at.range], [attStr yy_attribute:YYTextHighlightAttributeName atIndex:at.range.location]);
            };
            
            [attStr yy_setTextHighlight:highlight range:at.range];
        }
    }
    
    // 链接
    NSArray *resultLink = [[PBRegex regexUrl]matchesInString:attStr.string options:kNilOptions range:attStr.yy_rangeOfAll];
    for (NSTextCheckingResult *at in resultLink) {
        if (at.range.location == NSNotFound && at.range.length <= 1) {
            continue;
        }
        
        if ([attStr yy_attribute:YYTextHighlightAttributeName atIndex:at.range.location] == nil) {
            [attStr yy_setColor:[UIColor blueColor] range:at.range];
            
            YYTextHighlight *highlight = [[YYTextHighlight alloc]init];
            
            YYTextBorder *highlightBorder = [[YYTextBorder alloc]init];
            highlightBorder.insets = UIEdgeInsetsMake(-2, 0, -2, 0);
            highlightBorder.cornerRadius = 3;
            highlightBorder.fillColor = [UIColor greenColor];
            [highlight setBackgroundBorder:highlightBorder];
            
            highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
                NSLog(@"%@, yy_attribute = %@", [attStr.string substringWithRange:at.range], [attStr yy_attribute:YYTextHighlightAttributeName atIndex:at.range.location]);
            };
            
            [attStr yy_setTextHighlight:highlight range:at.range];
        }
    }
    
    // 手机号
    NSArray *resultPhone = [[PBRegex regexPhone]matchesInString:attStr.string options:kNilOptions range:attStr.yy_rangeOfAll];
    for (NSTextCheckingResult *at in resultPhone) {
        if (at.range.location == NSNotFound && at.range.length <= 1) {
            continue;
        }
        
        if ([attStr yy_attribute:YYTextHighlightAttributeName atIndex:at.range.location] == nil) {
            [attStr yy_setColor:[UIColor blueColor] range:at.range];
            
            YYTextHighlight *highlight = [[YYTextHighlight alloc]init];
            
            YYTextBorder *highlightBorder = [[YYTextBorder alloc]init];
            highlightBorder.insets = UIEdgeInsetsMake(-2, 0, -2, 0);
            highlightBorder.cornerRadius = 3;
            highlightBorder.fillColor = [UIColor greenColor];
            [highlight setBackgroundBorder:highlightBorder];
            
            highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
                NSLog(@"%@, yy_attribute = %@", [attStr.string substringWithRange:at.range], [attStr yy_attribute:YYTextHighlightAttributeName atIndex:at.range.location]);
            };
            
            [attStr yy_setTextHighlight:highlight range:at.range];
        }
    }
    
    // gif图
    YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc]init];
    imageView.frame = CGRectMake(0, 0, CGRectGetWidth(fourLab.frame), 200);
    imageView.image = [YYImage imageNamed:@"pbyytext_tiqiu"];
    imageView.userInteractionEnabled = YES;
    imageView.layer.cornerRadius = 8;
    imageView.layer.masksToBounds = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [imageView addGestureRecognizer:tap];
    tap.view.tag = 1;
    
    NSMutableAttributedString *attachStr = [NSMutableAttributedString yy_attachmentStringWithContent:imageView contentMode:UIViewContentModeCenter attachmentSize:imageView.frame.size alignToFont:attStr.yy_font alignment:YYTextVerticalAlignmentCenter];
    [attachStr yy_setLineSpacing:attStr.yy_lineSpacing range:attachStr.yy_rangeOfAll];
    [attStr appendAttributedString:attachStr];
    
    // 追加文字
    NSMutableAttributedString *attStrTwo = [[NSMutableAttributedString alloc]initWithString:@"我爱北京天安门京天\\n\n安门我爱北京天北京天安门我爱北京天安门我爱北京天安"];
    [attStrTwo yy_setLineSpacing:attStr.yy_lineSpacing range:NSMakeRange(0, attStrTwo.length)];
    [attStrTwo yy_setColor:[UIColor darkGrayColor] range:NSMakeRange(0, attStrTwo.length)];
    [attStrTwo yy_setFont:attStr.yy_font range:NSMakeRange(0, attStrTwo.length)];
    [attStr appendAttributedString:attStrTwo];
    
    // 图片
    UIImageView *twoImageView = [[UIImageView alloc]init];
    twoImageView.frame = CGRectMake(0, 0, CGRectGetWidth(fourLab.frame), 300);
    twoImageView.image = [UIImage imageNamed:@"pbyytext_pic"];
    twoImageView.userInteractionEnabled = YES;
    twoImageView.layer.cornerRadius = 10;
    twoImageView.layer.masksToBounds = YES;
    UITapGestureRecognizer *twoTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [twoImageView addGestureRecognizer:twoTap];
    twoTap.view.tag = 2;
    
    NSMutableAttributedString *attachStrTwo = [NSMutableAttributedString yy_attachmentStringWithContent:twoImageView contentMode:UIViewContentModeCenter attachmentSize:twoImageView.frame.size alignToFont:attStr.yy_font alignment:YYTextVerticalAlignmentCenter];
    [attachStrTwo yy_setLineSpacing:attStr.yy_lineSpacing range:attachStrTwo.yy_rangeOfAll];
    [attStr appendAttributedString:attachStrTwo];
    
    // 表情
    NSMutableAttributedString *attStrFour = [[NSMutableAttributedString alloc]initWithString:@"我爱北京天安门我爱北京天安门我爱北京天安门我爱北:smile22:京天安门我爱北京天安门我爱北京天:bye55:安门我爱北京天安门我爱北京天安门:smile:我爱北京天安门:bye:我爱北京天安门我爱北京天安门"];
    [attStrFour yy_setLineSpacing:(attStr.yy_lineSpacing+12) range:NSMakeRange(0, attStrFour.length)];
    [attStrFour yy_setColor:[UIColor darkGrayColor] range:NSMakeRange(0, attStrFour.length)];
    [attStrFour yy_setFont:attStr.yy_font range:NSMakeRange(0, attStrFour.length)];
    [attStr appendAttributedString:attStrFour];
    
    NSMutableDictionary *mapper = [NSMutableDictionary dictionary];
    mapper[@":smile:"] = [YYImage imageNamed:@"002"]; // 002.png
    mapper[@":smile22:"] = [YYImage imageNamed:@"0022"]; // 0022.gif
    mapper[@":bye:"] = [YYImage imageNamed:@"005"]; // 005.png
    mapper[@":bye55:"] = [YYImage imageNamed:@"0055"]; // 0055.gif
    
    YYTextSimpleEmoticonParser *parser = [[YYTextSimpleEmoticonParser alloc]init];
    parser.emoticonMapper = mapper;
    fourLab.textParser = parser;
    
    // 下面四种方法计算lab高度
    /**
    {
        YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(CGRectGetWidth(fourLab.frame), MAXFLOAT) text:attStr];
        fourLab.frame = CGRectMake(CGRectGetMinX(threeLab.frame), CGRectGetMaxY(threeLab.frame)+50, layout.textBoundingSize.width, layout.textBoundingSize.height);
        fourLab.textLayout = layout;
    }
     */
    
    /**
    {
        fourLab.attributedText = attStr;
        YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(CGRectGetWidth(fourLab.frame), MAXFLOAT) text:attStr];
        fourLab.frame = CGRectMake(CGRectGetMinX(threeLab.frame), CGRectGetMaxY(threeLab.frame)+50, layout.textBoundingSize.width, layout.textBoundingSize.height);
    }
     */
    
    /**
    {
        fourLab.attributedText = attStr;
        CGSize size = [fourLab sizeThatFits:CGSizeMake(CGRectGetWidth(fourLab.frame), MAXFLOAT)];
        fourLab.frame = CGRectMake(CGRectGetMinX(threeLab.frame), CGRectGetMaxY(threeLab.frame)+50, size.width, size.height);
    }
     */
    
    {
        fourLab.attributedText = attStr;
        [fourLab sizeToFit];
    }
    
    // textView
    YYTextView *textView = [[YYTextView alloc]init];
    self.textView = textView;
    [self.contentView addSubview:textView];
    textView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0); // textView需要设置此属性
    //textView.layer.borderColor = [UIColor redColor].CGColor;
    //textView.layer.borderWidth = 1;
    textView.editable = NO;
    textView.frame = CGRectMake(20, CGRectGetMaxY(fourLab.frame)+50, [UIScreen mainScreen].bounds.size.width-40, 100000);
    textView.textParser = parser;
    textView.attributedText = attStr;
    [textView sizeToFit];
    
    // 防止textView的选择复制与父视图的滚动手势冲突
    [self.textView addObserver:self forKeyPath:@"panGestureRecognizer.enabled" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    self.tableView.panGestureRecognizer.enabled = self.textView.panGestureRecognizer.enabled;
}

- (CGSize)sizeThatFits:(CGSize)size {
    if ([self.contentView.subviews containsObject:self.textView]) {
        return CGSizeMake(size.width, CGRectGetMaxY(self.textView.frame)+20);
    }
    return CGSizeMake(size.width, CGRectGetMaxY(self.fourLab.frame)+20);
}

- (void)tapClick:(UITapGestureRecognizer *)tap {
    NSLog(@"点击了图片%ld", tap.view.tag);
}

@end
