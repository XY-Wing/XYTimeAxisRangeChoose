//
//  UIView+WingFrameExtension.h
//  百思不得姐
//
//  Created by Wing on 16/6/8.
//  Copyright © 2016年 Wing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WingFrameExtension)

/**宽*/
@property (nonatomic, assign) CGFloat wing_width;

/**高*/
@property (nonatomic, assign) CGFloat wing_height;

/**x*/
@property (nonatomic, assign) CGFloat wing_x;

/**y*/
@property (nonatomic, assign) CGFloat wing_y;

/**size*/
@property (nonatomic, assign) CGSize wing_size;
/**centerX*/
@property (nonatomic, assign) CGFloat wing_centerX;
/**centerY*/
@property (nonatomic, assign) CGFloat wing_centerY;
//指定位置圆角
- (void)setLabelCornerRoundedRect:(CGRect)rect rectCorner:(UIRectCorner)corner size:(CGSize)size;

@end
