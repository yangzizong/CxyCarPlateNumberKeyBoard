//
//  CxyCarPlateNumberTextField.m
//  CxyCarPlateNumberKeyBoard
//
//  Created by 洋子总 on 2018/11/7.
//  Copyright © 2018 hertz. All rights reserved.
//

#import "CxyCarPlateNumberTextField.h"
#import "CxyCarPlateNumberKeyBoard.h"
#import "CxyCarPlateNumberKeyBoardViewModel.h"
#import "UITextField+SelectedRange.h"

@interface CxyCarPlateNumberTextField ()

@property (nonatomic, strong) CxyCarPlateNumberKeyBoard *carPlateNumberKeyBoard;

@end

@implementation CxyCarPlateNumberTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.showCarPlateNumberKeyBoard = YES;
        self.checkCarPlateNumberValue = YES;
    }
    return self;
}

- (CxyCarPlateNumberKeyBoard *)carPlateNumberKeyBoard {
    if (!_carPlateNumberKeyBoard) {
        _carPlateNumberKeyBoard = [[CxyCarPlateNumberKeyBoard alloc] init];
        
        if (self.maxLength == NSIntegerMax) {
            self.maxLength = 8;
        }
        
        __weak typeof(self) weakSelf = self;
        _carPlateNumberKeyBoard.keyBoardEditing = ^(BOOL isDelete, NSString * _Nonnull text) {
            [weakSelf textFieldShouldDelete:isDelete orAddText:text];
        };
    }
    return _carPlateNumberKeyBoard;
}

- (void)setShowCarPlateNumberKeyBoard:(BOOL)showCarPlateNumberKeyBoard {
    _showCarPlateNumberKeyBoard = showCarPlateNumberKeyBoard;
    
    if (showCarPlateNumberKeyBoard) {
        self.inputView = self.carPlateNumberKeyBoard;
    } else {
        if ([self.inputView isKindOfClass:[CxyCarPlateNumberKeyBoard class]]) {
            self.inputView = nil;
        }
    }
}

- (void)setShowProvinceType:(BOOL)showProvinceType {
    _showProvinceType = showProvinceType;
    self.carPlateNumberKeyBoard.showProvinceKeyType = showProvinceType;
}

- (void)textFieldShouldDelete:(BOOL)del orAddText:(NSString *)text {
    NSMutableString *oldText = self.text.mutableCopy;
    NSRange range = [self selectedRange];
    if (del) {
        if (range.location == 0 && range.length == 0) {
            
        } else if(range.length == 0 && range.location > 0){
            range.location -= 1;
            range.length = 1;
        }
        [oldText deleteCharactersInRange:range];
        range.length = 0;
    } else {
        if (range.location == 0) {
            if (![CxyCarPlateNumberKeyBoardViewModel isProvince:text] && self.checkCarPlateNumberValue) {
                self.carPlateNumberKeyBoard.showProvinceKeyType = YES;
                return ;
            }
        }
        if (range.location > 0) {
            if ([CxyCarPlateNumberKeyBoardViewModel isProvince:text]  && self.checkCarPlateNumberValue) {
                self.carPlateNumberKeyBoard.showProvinceKeyType = NO;
                return ;
            }
        }
        if (range.length > 0) {
            [oldText replaceCharactersInRange:range withString:text];
        } else {
            [oldText insertString:text atIndex:range.location];
        }
        range.location += text.length;
        range.length = 0;
    }
    if (oldText.length > 1 && self.checkCarPlateNumberValue) {
        NSString *checkPlate = [oldText substringFromIndex:1];
        checkPlate = [CxyCarPlateNumberKeyBoardViewModel removeProvince:checkPlate];
        oldText = [[oldText substringToIndex:1] stringByAppendingString:checkPlate].mutableCopy;
    }
    
    self.text = oldText.copy;
    if (range.location > self.text.length) {
        range.location = self.text.length;
    }
    [self setSelectedRange:range];
    NSNotification *notice = [[NSNotification alloc] initWithName:UITextFieldTextDidChangeNotification object:self userInfo:nil];
    [super Cxy_textFieldEditChanged:notice];
    
    // 代理方法
    if ([self.Cxy_delegate respondsToSelector:@selector(Cxy_textField:shouldChangeCharactersInRange:replacementString:)]) {
        if (del) {
            range.length = 1;
        } else {
            range.length = 0;
        }
        [self.Cxy_delegate Cxy_textField:self shouldChangeCharactersInRange:range replacementString:text];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
