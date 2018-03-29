//
//  XYPanView.m
//  Test
//
//  Created by wing on 2018/3/28.
//  Copyright © 2018年 wing. All rights reserved.
//

#import "XYPanView.h"
#import "UIView+WingFrameExtension.h"
@interface XYPanView()<UIGestureRecognizerDelegate>
@property(nonatomic,strong)UIView *topCircleV;
@property(nonatomic,strong)UIView *bottomCircleV;
@end
@implementation XYPanView
#define kCircleVWH 30
#define kTopCircleVTag 100
#define kBottomCircleVTag 101
#define kCellH  50 //高度最小限制值
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.5];
        [self addPanGesture];
        [self setupXYPanViewUI];
        
    }
    return self;
}
#pragma mark --- 添加拖动手势
- (void)addPanGesture
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizerDidPan:)];
    [self addGestureRecognizer:pan];
}
#pragma mark --- 拖动事件
- (void)panGestureRecognizerDidPan:(UIPanGestureRecognizer *)panGestureRecognizer
{
    
    CGPoint translation = [panGestureRecognizer translationInView:self.superview];
    
    self.center = CGPointMake(self.center.x, self.center.y + translation.y);
    
    [panGestureRecognizer setTranslation:CGPointZero inView:self.superview];
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [self revokeDelegate];
    }
}
#pragma mark --- 点击手势
//顶部circle点击
- (void)topTap:(UIPanGestureRecognizer *)tap
{
    CGPoint transitionPoint = [tap translationInView:self.superview];
    //当高度小于限定值，并且继续减小趋势时 进行限制
    //高度小于限定值，但是是增大趋势，就不进行限制
    if (self.wing_height < kCellH && transitionPoint.y > 0) {
        [self limit:tap];
        return;
    }
    [tap setTranslation:CGPointZero inView:self.superview];
    [self refreshSelfPosition:YES y:transitionPoint.y];
}
//底部circle点击
- (void)bottomTap:(UIPanGestureRecognizer *)tap
{
    CGPoint transitionPoint = [tap translationInView:self.superview];
    //当高度小于限定值，并且继续减小趋势时 进行限制
    //高度小于限定值，但是是增大趋势，就不进行限制
    if (self.wing_height < kCellH && transitionPoint.y < 0) {
        [self limit:tap];
        return;
    }
    tap.view.center = CGPointMake(tap.view.center.x, tap.view.center.y + transitionPoint.y);
    [tap setTranslation:CGPointZero inView:self.superview];
    
    [self refreshSelfPosition:NO y:0];
}
//刷新各视图 位置 等
- (void)refreshSelfPosition:(BOOL)isTopPan y:(CGFloat)transitionPointY
{
    
    if (isTopPan) {
        self.wing_y += transitionPointY;
        self.wing_height -= transitionPointY;
        _bottomCircleV.wing_centerY -= transitionPointY;
    } else {
        CGPoint topVCenterPoint = [self convertPoint:_topCircleV.center toView:self.superview];
        CGPoint bottomVCenterPoint = [self convertPoint:_bottomCircleV.center toView:self.superview];
        CGFloat h = ABS(topVCenterPoint.y - bottomVCenterPoint.y);
        self.wing_height = h;
    }
    
}
//当self的高度小于限定值时，将pan手势置于self上
- (void)limit:(UIPanGestureRecognizer *)pan
{
    [self panGestureRecognizerDidPan:pan];
    if (pan.state == UIGestureRecognizerStateEnded) {
        self.wing_height = kCellH;
        _topCircleV.wing_centerY = 0;
        _bottomCircleV.wing_centerY = kCellH;
    }
}
#pragma mark --- 更新按钮位置
- (void)refreshCirClePositionForView:(UIView *)v
{
    CGRect frame = _bottomCircleV.frame;
    frame.origin.y = self.frame.size.height - kCircleVWH * 0.5;
    _bottomCircleV.frame = frame;
}
#pragma mark --- 通知代理
- (void)revokeDelegate
{
    if (_delegate && [_delegate respondsToSelector:@selector(panViewDidEndMove:)]) {
        [_delegate panViewDidEndMove:self];
    }
}
#pragma mark - 布局UI
- (void)setupXYPanViewUI
{
    [self addSubview:self.topCircleV];
    [self addSubview:self.bottomCircleV];
}
- (UIView *)topCircleV
{
    if (!_topCircleV) {
        _topCircleV = [[UIView alloc] init];
        _topCircleV.tag = kTopCircleVTag;
        CGFloat y = - kCircleVWH * 0.5;
        CGFloat x = 24 + kCellH;
        CGFloat w = kCircleVWH;
        CGFloat h = kCircleVWH;
        _topCircleV.frame = CGRectMake(x, y, w, h);
        _topCircleV.backgroundColor = [UIColor redColor];
        _topCircleV.layer.cornerRadius = kCircleVWH * 0.5;
        _topCircleV.layer.masksToBounds = YES;
        UIPanGestureRecognizer *tap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(topTap:)];
        [_topCircleV addGestureRecognizer:tap];
        
    }
    return _topCircleV;
}
- (UIView *)bottomCircleV
{
    if (!_bottomCircleV) {
        _bottomCircleV = [[UIView alloc] init];
        _bottomCircleV.tag = kBottomCircleVTag;
        CGFloat y = self.frame.size.height - kCircleVWH * 0.5;
        CGFloat x = self.frame.size.width - 24 - kCircleVWH;
        CGFloat w = kCircleVWH;
        CGFloat h = kCircleVWH;
        _bottomCircleV.frame = CGRectMake(x, y, w, h);
        _bottomCircleV.backgroundColor = [UIColor redColor];
        _bottomCircleV.layer.cornerRadius = kCircleVWH * 0.5;
        _bottomCircleV.layer.masksToBounds = YES;
        UIPanGestureRecognizer *tap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(bottomTap:)];
        [_bottomCircleV addGestureRecognizer:tap];
    }
    return _bottomCircleV;
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        CGPoint p = [self convertPoint:point toView:_topCircleV];
        // 判断触摸点是否在button上
        if ([_topCircleV pointInside:p withEvent:nil]) {
            view = _topCircleV;
        } else {
            CGPoint p = [self convertPoint:point toView:_bottomCircleV];
            if ([_bottomCircleV pointInside:p withEvent:nil]) {
                view = _bottomCircleV;
            }
        }
    }
    return view;
}
#pragma mark --- UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}
@end
