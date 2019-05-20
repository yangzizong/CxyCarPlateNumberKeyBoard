//
//  CxyCarPlateNumberCell.m
//  CxyCarPlateNumberKeyBoard
//
//  Created by 洋子总 on 2018/12/17.
//  Copyright © 2018 Keyboard. All rights reserved.
//

#import "CxyCarPlateNumberCell.h"
#import "CxyCarPlateNumberHeader.h"
#import <Masonry/Masonry.h>

#define kColor(R,G,B,A) [UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]
#define KAPP_COLOR kColor(8, 189, 145, 1)
#define k_TextColor170 kColor(170, 170, 170, 1)

@interface CxyCarPlateNumberCell () <UITextFieldDelegate, CxyCarPlateNumberTextFieldDelegate>

@property (nonatomic, strong) UILabel *lbTitle;

@property (nonatomic, strong) CxyCarPlateNumberTextField *carNumberTF1;
@property (nonatomic, strong) CxyCarPlateNumberTextField *carNumberTF2;

@end

@implementation CxyCarPlateNumberCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.lbTitle];
        [self addSubview:self.carNumberTF1];
        [self addSubview:self.carNumberTF2];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 位置可根据UI进行调整
    [self.lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(15);
    }];
    
    [self.carNumberTF2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(self);
        make.width.mas_equalTo(100);
    }];
    
    [self.carNumberTF1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(-150);
        make.width.height.mas_equalTo(35);
    }];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.text > 0 && textField.tag == 200) {
        CxyCarPlateNumberTextField *tf = [self viewWithTag:200];
        tf.showProvinceType = YES;
    } else {
        CxyCarPlateNumberTextField *tf = [self viewWithTag:201];
        
        if (textField.text.length == 6) {
            tf.showProvinceType = YES;
        } else {
            tf.showProvinceType = NO;
        }
    }
}

#pragma mark - CxyCarPlateNumberTextFieldDelegate
- (BOOL)Cxy_textField:(CxyCarPlateNumberTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSInteger count = textField.text.length;
    // 如果是最后一位则可以输入省
    if (count == 6) {
        textField.showProvinceType = YES;
    } else {
        textField.showProvinceType = NO;
    }
    
    textField.checkCarPlateNumberValue = NO;
    
    // 车牌
    if (textField.tag == 200) {
        if (textField.text.length > 0) {
            CxyCarPlateNumberTextField *tf= [self viewWithTag:201];
            [tf becomeFirstResponder];
            [textField resignFirstResponder];
            
            textField.text = string;
            
            self.strPrefixCarNumber = string;
        }
    } else {
        self.strCarNumberContent = textField.text;
    }
    
    self.strCarNumber = [NSString stringWithFormat:@"%@%@", self.strPrefixCarNumber, self.strCarNumberContent];
    
    NSLog(@"car number:%@", self.strCarNumber);
    NSLog(@"location:%ld  length:%ld", range.location, range.length);
    NSLog(@"string:%@", string);
    
    return YES;
}

- (CxyCarPlateNumberTextField *)carNumberTF1 {
    if (!_carNumberTF1) {
        _carNumberTF1 = [[CxyCarPlateNumberTextField alloc] init];
        _carNumberTF1.tag = 200;
        _carNumberTF1.textAlignment = NSTextAlignmentCenter;
        _carNumberTF1.layer.borderWidth = 1;
        _carNumberTF1.layer.borderColor = k_TextColor170.CGColor;
        _carNumberTF1.maxLength = 1;
        _carNumberTF1.layer.cornerRadius = 5;
        _carNumberTF1.Cxy_delegate = self;
        _carNumberTF1.delegate = self;
        
        _carNumberTF1.showProvinceType = YES;
        _carNumberTF1.checkCarPlateNumberValue = NO;
        
        // 默认值
        _carNumberTF1.text = @"粤";
        self.strPrefixCarNumber = @"粤";
        
        // 隐藏光标
        _carNumberTF1.tintColor = [UIColor clearColor];
        
        [_carNumberTF1 becomeFirstResponder];
    }
    return _carNumberTF1;
}

- (CxyCarPlateNumberTextField *)carNumberTF2 {
    if (!_carNumberTF2) {
        _carNumberTF2 = [[CxyCarPlateNumberTextField alloc] init];
        _carNumberTF2.tag = 200 + 1;
        _carNumberTF2.textAlignment = NSTextAlignmentRight;
        _carNumberTF2.maxLength = 7;
        _carNumberTF2.Cxy_delegate = self;
        _carNumberTF2.delegate = self;
        _carNumberTF2.showProvinceType = NO;
        _carNumberTF2.placeholder = @"车牌号码";
        _carNumberTF2.checkCarPlateNumberValue = NO;
    }
    return _carNumberTF2;
}

- (UILabel *)lbTitle {
    if (!_lbTitle) {
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.text = @"车牌号码";
    }
    return _lbTitle;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
