//
//  XYTimeAxisCell.m
//  Test
//
//  Created by wing on 2018/3/29.
//  Copyright © 2018年 wing. All rights reserved.
//

#import "XYTimeAxisCell.h"
#import "UIView+WingFrameExtension.h"
@interface XYTimeAxisCell()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIView *lineV;
@end
@implementation XYTimeAxisCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupXYTimeAxisCellUI];
    }
    return self;
}
#pragma mark - 布局UI
- (void)setupXYTimeAxisCellUI
{
    
}
#pragma mark - 懒加载UI

@end
