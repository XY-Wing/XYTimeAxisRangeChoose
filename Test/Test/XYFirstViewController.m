//
//  XYFirstViewController.m
//  Test
//
//  Created by wing on 2018/3/29.
//  Copyright © 2018年 wing. All rights reserved.
//

#import "XYFirstViewController.h"

@interface XYFirstViewController ()
@property(nonatomic,strong)UIView *testV;
@end
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
@implementation XYFirstViewController
- (UIView *)testV
{
    if (!_testV) {
        _testV = [[UIView alloc] initWithFrame:CGRectMake(0, 100, kScreenW, 100)];
        _testV.backgroundColor = [UIColor redColor];
    }
    return _testV;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.testV];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGFloat h = _testV.frame.size.height;
    _testV.transform = CGAffineTransformScale(_testV.transform, 0, h ++);
}
@end
