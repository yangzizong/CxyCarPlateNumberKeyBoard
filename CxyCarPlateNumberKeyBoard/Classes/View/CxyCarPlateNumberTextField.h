//
//  CxyCarPlateNumberTextField.h
//  CxyCarPlateNumberKeyBoard
//
//  Created by 洋子总 on 2018/11/7.
//  Copyright © 2018 hertz. All rights reserved.
//

#import "CxyTextField.h"
@class CxyCarPlateNumberTextField;

@protocol CxyCarPlateNumberTextFieldDelegate <NSObject>

@optional
- (BOOL)Cxy_textField:(CxyCarPlateNumberTextField *_Nullable)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *_Nullable)string;

@end

NS_ASSUME_NONNULL_BEGIN

@interface CxyCarPlateNumberTextField : CxyTextField

/* 声明代理 */
@property (nonatomic, weak  ) id<CxyCarPlateNumberTextFieldDelegate> Cxy_delegate;

/* 显示车牌号码键盘, 默认YES */
@property (nonatomic, assign) BOOL showCarPlateNumberKeyBoard;

/* 校验车牌输入值, 第一位为省份, 其余为数字或字母, 默认YES */
@property (nonatomic, assign) BOOL checkCarPlateNumberValue;

/* 是否显示省份键盘类型 */
@property (nonatomic, assign) BOOL showProvinceType;

@end

NS_ASSUME_NONNULL_END
