//
//  BBACommentContentLabelItem.m
//  BBAComs-BBAComment
//
//  Created by liuyang108 on 2018/1/30.
//  Copyright © 2018年 Baidu. All rights reserved.
//

#import "BBACommentContentLabelItem.h"
//#import "BBACommentLabelLineSpaceFixer.h"

@interface BBACommentContentLabelItem ()

@property (nonatomic, strong) NSAttributedString *attributedString;

@property (nonatomic, strong) NSTextStorage *textStorage;

@property (nonatomic, strong) BBACommentContentTextLayoutItem *layoutItem;

@property (nonatomic, weak) BBACommentContentTextLayoutItem *currrentLayoutItem;

@end

@implementation BBACommentContentLabelItem

+ (instancetype)itemWithAttributedString:(NSAttributedString *)attributedString width:(CGFloat)width maximumNumberOfLines:(NSInteger)maximumNumberOfLines {
    BBACommentContentLabelItem *item = [[BBACommentContentLabelItem alloc] init];
    item.attributedString = attributedString;
    
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:attributedString];
    BBACommentContentTextLayoutItem *layoutItem = [[BBACommentContentTextLayoutItem alloc] initWithWidth:width maximumNumberOfLines:maximumNumberOfLines forTextStorage:textStorage];
    item.textStorage = textStorage;
    item.currrentLayoutItem = layoutItem;
    item.layoutItem = layoutItem;
    return item;
}

@end

#pragma mark -

@interface BBACommentContentTextLayoutItem ()

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) NSInteger maximumNumberOfLines;
@property (nonatomic, strong) NSTextStorage *textStroage;
@property (nonatomic, strong) NSLayoutManager *layoutManager;
@property (nonatomic, strong) NSTextContainer *textContainer;
@property (nonatomic, assign) CGSize size;

@end

@implementation BBACommentContentTextLayoutItem

- (instancetype)initWithWidth:(CGFloat)width maximumNumberOfLines:(NSInteger)maximumNumberOfLines forTextStorage:(NSTextStorage *)textStorage {
    self = [super init];
    if (self) {
        _width = width;
        _maximumNumberOfLines = maximumNumberOfLines;
        
        NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
//        layoutManager.delegate = [BBACommentLabelLineSpaceFixer sharedInstance];
        [textStorage addLayoutManager:layoutManager];
        
        NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(width, CGFLOAT_MAX)];
        textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
        textContainer.lineFragmentPadding = 0.f;
        textContainer.maximumNumberOfLines = maximumNumberOfLines;
        [layoutManager addTextContainer:textContainer];
        [layoutManager glyphRangeForTextContainer:textContainer];
        CGSize allSize =  [layoutManager usedRectForTextContainer:textContainer].size;
        
        self.textStroage = textStorage;
        self.layoutManager = layoutManager;
        self.textContainer = textContainer;
        self.size = CGSizeMake(ceil(allSize.width), ceil(allSize.height));
    }
    return self;
}

- (instancetype)initWithWidth:(CGFloat)width maximumNumberOfLines:(NSInteger)maximumNumberOfLines attributedString:(NSAttributedString *)attributedString {
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:attributedString];
    return [self initWithWidth:width maximumNumberOfLines:maximumNumberOfLines forTextStorage:textStorage];
}

@end