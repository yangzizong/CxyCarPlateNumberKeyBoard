//
//  CxyCarPlateNumberKeyBoardCell.m
//  CxyCarPlateNumberKeyBoard
//
//  Created by 洋子总 on 2018/11/7.
//  Copyright © 2018 hertz. All rights reserved.
//

#import "CxyCarPlateNumberKeyBoardCell.h"
#import "CxyCarPlateNumberKeyBoardModel.h"
#import <Masonry/Masonry.h>

/** 颜色值 */
#define UIColorFrom0xValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8) )/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface CxyCarPlateNumberKeyBoardCell ()

@property (nonatomic, strong) UIButton *textButton;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CxyCarPlateNumberKeyBoardCell

- (UIButton *)textButton {
    if (!_textButton) {
        _textButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_textButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
        [self.contentView addSubview:_textButton];
        
        _textButton.backgroundColor = [UIColor whiteColor];
        _textButton.layer.masksToBounds = YES;
        _textButton.layer.cornerRadius = 5;
        [_textButton setTitleColor:UIColorFrom0xValue(0x333333) forState:UIControlStateNormal];
        _textButton.userInteractionEnabled = NO;
        
        [_textButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(8, 2, 2, 2));
        }];
    }
    return _textButton;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageView];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
             make.center.equalTo(self.textButton);
        }];
    }
    return _imageView;
}

- (void)setModel:(CxyCarPlateNumberKeyBoardModel *)model {
    _model = model;
    [self.textButton setTitle:model.text forState:UIControlStateNormal];
    self.imageView.image = model.image;
    [self.textButton setTitleColor:UIColorFrom0xValue(0x333333) forState:UIControlStateNormal];
    
    [self resetColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.textButton.backgroundColor = UIColorFrom0xValue(0xCDCDCD);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self resetColor];
        
        if (self.didClicked) {
            self.didClicked(self.indexPath);
        }
        self.userInteractionEnabled = YES;
    });
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self resetColor];
    });
}

- (void)resetColor {
    if (_model.changeKeyBoardType) {
        self.textButton.backgroundColor = UIColorFrom0xValue(0x157EFB);
        [self.textButton setTitleColor:UIColorFrom0xValue(0xFFFFFF) forState:UIControlStateNormal];
    } else if (_model.deleteTextType) {
        self.textButton.backgroundColor = UIColorFrom0xValue(0xABB2BE);
    } else {
        self.textButton.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    }
}

@end
