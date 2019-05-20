//
//  CxyCarPlateNumberKeyBoardViewModel.h
//  CxyCarPlateNumberKeyBoard
//
//  Created by 洋子总 on 2018/11/7.
//  Copyright © 2018 hertz. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CxyCarPlateNumberKeyBoardModel;

NS_ASSUME_NONNULL_BEGIN

@interface CxyCarPlateNumberKeyBoardViewModel : NSObject

/* 是否显示省份键盘 */
@property (nonatomic, assign) BOOL showProvinceKeyType;

@property (nonatomic, strong) NSMutableArray <NSArray <CxyCarPlateNumberKeyBoardModel *>*> *dataSource;

/* 判断当前Text是否是省份 */
+ (BOOL)isProvince:(NSString *)text;

/* 如果Text中包含省份, 则删除字段 */
+ (NSString *)removeProvince:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
