//
//  XYPanView.h
//  Test
//
//  Created by wing on 2018/3/28.
//  Copyright © 2018年 wing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYPanView;
@protocol XYPanViewDelegate <NSObject>
- (void)panViewDidEndMove:(XYPanView *)panV;
@end
@interface XYPanView : UIView
@property(nonatomic,weak)id<XYPanViewDelegate>delegate;
@end
