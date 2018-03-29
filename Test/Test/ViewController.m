//
//  ViewController.m
//  Test
//
//  Created by wing on 2018/3/28.
//  Copyright © 2018年 wing. All rights reserved.
//

#import "ViewController.h"
#import "XYPanView.h"
#import "XYCell.h"
#import "XYTimeAxisView.h"
#import "XYFirstViewController.h"
#import "UIView+WingFrameExtension.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,XYPanViewDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)XYPanView *panV;
@property(nonatomic,strong)XYTimeAxisView *axisV;

@property(nonatomic,strong)UIView *topCircleV;
@property(nonatomic,strong)UIView *bottomCircleV;
@end
#define kCircleVWH 30
#define kTopCircleVTag 100
#define kBottomCircleVTag 101
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kCellH 50
@implementation ViewController

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_tableView registerClass:[XYCell class] forCellReuseIdentifier:@"XYCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _tableView;
}
- (XYPanView *)panV
{
    if (!_panV) {
        _panV = [[XYPanView alloc] initWithFrame:CGRectMake(0, 100, kScreenW, 150)];
        _panV.delegate = self;
    }
    return _panV;
}
- (XYTimeAxisView *)axisV
{
    if (!_axisV) {
        CGRect frame = _tableView.frame;
        CGFloat x = frame.origin.x;
        CGFloat y = frame.origin.y;
        CGFloat w = kCellH;
        CGFloat h = kCellH * 30; //tableview 总高度
        _axisV = [[XYTimeAxisView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    }
    return _axisV;
}
- (UIView *)topCircleV
{
    if (!_topCircleV) {
        _topCircleV = [[UIView alloc] init];
        _topCircleV.tag = kTopCircleVTag;
        CGFloat y = CGRectGetMinY(self.panV.frame) - kCircleVWH * 0.5;
        CGFloat x = 24 + 50;
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
        CGFloat y = CGRectGetMaxY(self.panV.frame) - kCircleVWH * 0.5;
        CGFloat x = self.panV.frame.size.width - 24 - kCircleVWH;
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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [_tableView addSubview:self.panV];
//    [_tableView addSubview:self.topCircleV];
//    [_tableView addSubview:self.bottomCircleV];
    [_tableView addSubview:self.axisV];
}
#pragma mark --- XYPanViewDelegate
-(void)panViewDidEndMove:(XYPanView *)panV
{
    
    //圆的位置
    _topCircleV.wing_y = CGRectGetMinY(self.panV.frame) - kCircleVWH * 0.5;
    _bottomCircleV.wing_y = CGRectGetMaxY(self.panV.frame) - kCircleVWH * 0.5;
    
//    NSArray *arr = [_tableView indexPathsForRowsInRect:panV.frame];
//    for (NSIndexPath *indexPath in arr) {
//        NSLog(@"row = %zd",indexPath.row);
//    }
    
    
}
//顶部circle点击
- (void)topTap:(UIPanGestureRecognizer *)tap
{
    CGPoint transitionPoint = [tap translationInView:self.view];
    tap.view.center = CGPointMake(tap.view.center.x, tap.view.center.y + transitionPoint.y);
    [tap setTranslation:CGPointZero inView:self.view];
    [self upDatePanVPositionAndFrame];
}
//底部circle点击
- (void)bottomTap:(UIPanGestureRecognizer *)tap
{
    CGPoint transitionPoint = [tap translationInView:self.view];
    tap.view.center = CGPointMake(tap.view.center.x, tap.view.center.y + transitionPoint.y);
    [tap setTranslation:CGPointZero inView:self.view];
    [self upDatePanVPositionAndFrame];
}
- (void)upDatePanVPositionAndFrame
{
    _panV.wing_height = ABS(_topCircleV.wing_centerY - _bottomCircleV.wing_centerY);
//    NSLog(@"%f",_topCircleV.wing_centerY - _bottomCircleV.wing_centerY);
    _panV.wing_y = _topCircleV.wing_centerY;
    
}
#pragma mark --- UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellH;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XYCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"indexPath.row = %zd",indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self presentViewController:[[XYFirstViewController alloc] init] animated:YES completion:nil];
}
@end
