//
//  UIView+WingFrameExtension.m
//  百思不得姐
//
//  Created by Wing on 16/6/8.
//  Copyright © 2016年 Wing. All rights reserved.
//

#import "UIView+WingFrameExtension.h"
//透明背景view
static UIView * view;
@implementation UIView (WingFrameExtension)
//height  set
-(void)setWing_height:(CGFloat)wing_height
{
    CGRect frame = self.frame;
    frame.size.height = wing_height;
    self.frame = frame;
}
//height  get
-(CGFloat)wing_height
{
    return self.frame.size.height;
}

//width  set
-(void)setWing_width:(CGFloat)wing_width
{
    CGRect frame = self.frame;
    frame.size.width= wing_width;
    self.frame = frame;
}
//width  get
-(CGFloat)wing_width
{
    return self.frame.size.width;
}

//x
-(void)setWing_x:(CGFloat)wing_x
{
    CGRect frame = self.frame;
    frame.origin.x = wing_x;
    self.frame = frame;
    
}
-(CGFloat)wing_x
{
     return self.frame.origin.x;
}

//y
-(void)setWing_y:(CGFloat)wing_y
{
    CGRect frame = self.frame;
    frame.origin.y = wing_y;
    self.frame = frame;
}
-(CGFloat)wing_y
{
    return self.frame.origin.y;
}

//size
-(void)setWing_size:(CGSize)wing_size
{
    CGRect frame = self.frame;
    
    frame.size = wing_size;
    
    self.frame = frame;
}

-(CGSize)wing_size
{
    return self.frame.size;
}
//centerX
-(void)setWing_centerX:(CGFloat)wing_centerX
{
    CGPoint center = self.center;
    center.x = wing_centerX;
    self.center = center;
}
-(CGFloat)wing_centerX
{
    return self.center.x;
}
// centerY
-(void)setWing_centerY:(CGFloat)wing_centerY
{
    CGPoint center = self.center;
    center.y = wing_centerY;
    self.center = center;
}
-(CGFloat)wing_centerY
{
    return self.center.y;
}

- (void)setLabelCornerRoundedRect:(CGRect)rect rectCorner:(UIRectCorner)corner size:(CGSize)size
{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners: corner cornerRadii:size];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    shape.frame = self.bounds;
    shape.path = path.CGPath;
    self.layer.mask = shape;
}


@end
