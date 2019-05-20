//
//  CxyTextField.h
//  CxyCarPlateNumberKeyBoard
//
//  Created by 洋子总 on 2018/11/6.
//  Copyright © 2018 hertz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CxyTextField : UITextField

/* 最大输入长度 */
@property (nonatomic, assign) NSUInteger maxLength;

/* 文本修改变化之后(编辑结束)的回调 */
@property (nonatomic, copy  ) void(^Cxy_textEditChanged)(CxyTextField *textField);

- (void)Cxy_textFieldEditChanged:(NSNotification *)sender;

@end

NS_ASSUME_NONNULL_END
