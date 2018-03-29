//
//  XYCell.m
//  Test
//
//  Created by wing on 2018/3/28.
//  Copyright © 2018年 wing. All rights reserved.
//

#import "XYCell.h"

@implementation XYCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupXYCellUI];
    }
    return self;
}
#pragma mark - 布局UI
- (void)setupXYCellUI
{
    
}
#pragma mark - 懒加载UI
- (void)setFrame:(CGRect)frame
{
    CGFloat w = 50;
    frame.size.width -= w;
    frame.origin.x += w;
    [super setFrame:frame];
}
@end
