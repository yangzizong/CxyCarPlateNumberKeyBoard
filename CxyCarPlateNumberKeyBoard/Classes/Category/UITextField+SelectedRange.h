//
//  UITextField+SelectedRange.h
//  HertzCwz
//
//  Created by 洋子总 on 2018/11/6.
//  Copyright © 2018 hertz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (SelectedRange)

// 获取焦点的位置
- (NSRange)selectedRange;

// 设置焦点的位置
- (void)setSelectedRange:(NSRange)range;

@end

NS_ASSUME_NONNULL_END
