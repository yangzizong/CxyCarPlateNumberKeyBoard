//
//  CxyCarPlateNumberKeyBoardViewModel.m
//  CxyCarPlateNumberKeyBoard
//
//  Created by 洋子总 on 2018/11/7.
//  Copyright © 2018 hertz. All rights reserved.
//

#import "CxyCarPlateNumberKeyBoardViewModel.h"
#import "CxyCarPlateNumberKeyBoardModel.h"

@implementation CxyCarPlateNumberKeyBoardViewModel

- (void)setShowProvinceKeyType:(BOOL)showProvinceKeyType {
    _showProvinceKeyType = showProvinceKeyType;
    
    if (showProvinceKeyType) {
        // 显示省份键盘
        [self showProvinceKeyboard];
    } else {
        // 显示字母键盘
        [self showAlphabetKeyboard];
    }
}

#pragma mark - 显示省份键盘
- (void)showProvinceKeyboard {
    [self.dataSource removeAllObjects];
    
    NSArray <NSArray <NSString *>*> *province = @[
                                                  @[@"京",@"津",@"渝",@"沪",@"冀",@"晋",@"辽",@"吉",@"黑",@"苏"],
                                                  @[@"浙",@"皖",@"闽",@"赣",@"鲁",@"豫",@"鄂",@"湘",@"粤",@"琼"],
                                                  @[@"川",@"贵",@"云",@"陕",@"甘",@"青",@"蒙",@"桂",@"宁",@"新"],
                                                  @[@"A",@"藏",@"使",@"领",@"警",@"学",@"港",@"澳",@"delete"]
                                                  ];
    [province enumerateObjectsUsingBlock:^(NSArray<NSString *> * _Nonnull objArray, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *items = [NSMutableArray new];
        
        [objArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CxyCarPlateNumberKeyBoardModel *model = [[CxyCarPlateNumberKeyBoardModel alloc] init];
            model.text = obj;
            
            if ([obj isEqualToString:@"A"]) { // 切换键盘
                model.changeKeyBoardType = YES;
            } else if ([obj isEqualToString:@"delete"]) { // 删除按钮
                model.deleteTextType = YES;
                model.image = [UIImage imageNamed:@"CxyCarPlateNumber.bundle/cxy_delete"];
                model.text = @"";
            }
            [items addObject:model];
        }];
        
        [self.dataSource addObject:items.copy];
    }];
}

#pragma mark - 显示字母键盘
- (void)showAlphabetKeyboard {
    [self.dataSource removeAllObjects];
    
    NSArray <NSArray <NSString *>*> *province = @[
                                                  @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"],
                                                  @[@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P"],
                                                  @[@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L"],
                                                  @[@"省",@"Z",@"X",@"C",@"V",@"B",@"N",@"M",@"delete"]
                                                  ];
    [province enumerateObjectsUsingBlock:^(NSArray<NSString *> * _Nonnull objArray, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *items = [NSMutableArray new];
        
        [objArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CxyCarPlateNumberKeyBoardModel *model = [[CxyCarPlateNumberKeyBoardModel alloc] init];
            model.text = obj;
            
            if ([obj isEqualToString:@"省"]) { // 切换键盘
                model.changeKeyBoardType = YES;
            } else if ([obj isEqualToString:@"delete"]) { // 删除按钮
                model.deleteTextType = YES;
                model.image = [UIImage imageNamed:@"CxyCarPlateNumber.bundle/cxy_delete"];
                model.text = @"";
            }
            [items addObject:model];
        }];
        
        [self.dataSource addObject:items.copy];
    }];
}

/* 判断当前Text是否为省份 */
+ (BOOL)isProvince:(NSString *)text {
    // 注意: containsobject比较的是对象的内存地址而不是对象内容!
    return [self.provinces containsObject:text];
}

+ (NSArray *)provinces {
    return @[@"京",@"津",@"渝",@"沪",@"冀",@"晋",@"辽",@"吉",@"黑",@"苏",@"浙",@"皖",@"闽",@"赣",@"鲁",@"豫",@"鄂",@"湘",@"粤",@"琼",@"川",@"贵",@"云",@"陕",@"甘",@"青",@"蒙",@"桂",@"宁",@"新",@"藏",@"使",@"领",@"警",@"学",@"港",@"澳"];
}

// 如果text中包含有省份, 则删除字段
+ (NSString *)removeProvince:(NSString *)text {
    __block NSString *plate = text.copy;
    NSArray *provinces = self.provinces;
    [provinces enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        plate = [plate stringByReplacingOccurrencesOfString:obj withString:@""];
    }];
    return plate;
}

- (NSMutableArray<NSArray<CxyCarPlateNumberKeyBoardModel *> *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
