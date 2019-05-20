//
//  CxyCarPlateNumberKeyBoard.h
//  CxyCarPlateNumberKeyBoard
//
//  Created by 洋子总 on 2018/11/6.
//  Copyright © 2018 hertz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CxyCarPlateNumberKeyBoard : UIView

/**
 * 键盘点击事件
 * isDelete: 点击删除
 * text: 输入的文字
 */
@property (nonatomic, copy  ) void(^keyBoardEditing)(BOOL isDelete, NSString *text);

/* 是否显示省份类型, 切换DataSource值 */
@property (nonatomic, assign) BOOL showProvinceKeyType;

@end

NS_ASSUME_NONNULL_END
