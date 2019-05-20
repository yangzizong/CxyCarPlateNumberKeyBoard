//
//  CxyTextField.m
//  CxyCarPlateNumberKeyBoard
//
//  Created by 洋子总 on 2018/11/6.
//  Copyright © 2018 hertz. All rights reserved.
//

#import "CxyTextField.h"
#import "UITextField+SelectedRange.h"

// 占位文字颜色
#define CPPlaceholderColorKey @"placeholderLabel.textColor"

@implementation CxyTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 文本框光标颜色
//        self.tintColor = kColorMain;
        
        self.maxLength = NSIntegerMax;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Cxy_textFieldEditChanged:) name:UITextFieldTextDidChangeNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Cxy_textFieldEditChanged:) name:UITextFieldTextDidEndEditingNotification object:self];
    }
    return self;
}

- (void)Cxy_textFieldEditChanged:(NSNotification *)sender {
    CxyTextField *textField = sender.object;
    if (![textField isEqual:self]) {
        return;
    }
    if (self.maxLength == NSIntegerMax) {
        if (self.Cxy_textEditChanged) {
            self.Cxy_textEditChanged(textField);
        }
        return;
    }
    
    NSString *toBeString = textField.text;
    
    NSRange range = [self selectedRange];
    // 键盘输入模式
    NSString *lang = [[UIApplication sharedApplication] textInputMode].primaryLanguage;
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > self.maxLength) {
                textField.text = [toBeString substringToIndex:self.maxLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > self.maxLength) {
            textField.text = [toBeString substringToIndex:self.maxLength];
        }
    }
    if (range.location > textField.text.length) {
        range.location = textField.text.length;
    }
    [self setSelectedRange:range];
    
    if (self.Cxy_textEditChanged) {
        self.Cxy_textEditChanged(textField);
    }
}

/**
 * 文本框聚焦时调用（弹出当前文本框对应的键盘时调用）
 */
- (BOOL)becomeFirstResponder {
    return [super becomeFirstResponder];
}

/**
 * 文本框失去焦点时调用（隐藏当前文本框对应的键盘时调用）
 */
- (BOOL)resignFirstResponder {
    return [super resignFirstResponder];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
