//
//  CxyCarPlateNumberKeyBoardModel.h
//  CxyCarPlateNumberKeyBoard
//
//  Created by 洋子总 on 2018/11/6.
//  Copyright © 2018 hertz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CxyCarPlateNumberKeyBoardModel : NSObject

@property (nonatomic, copy  ) NSString *text;

@property (nonatomic, strong) UIImage *image;

// 是否是切换键盘按钮
@property (nonatomic, assign) BOOL changeKeyBoardType;
// 是否是删除按钮
@property (nonatomic, assign) BOOL deleteTextType;

@end

NS_ASSUME_NONNULL_END
