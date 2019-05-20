//
//  CxyCarPlateNumberCell.h
//  CxyCarPlateNumberKeyBoard
//
//  Created by 洋子总 on 2018/12/17.
//  Copyright © 2018 Keyboard. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CxyCarPlateNumberCell : UITableViewCell

/** 车牌号码 */
@property (nonatomic, copy  ) NSString *strCarNumber;
/** 车牌前缀 */
@property (nonatomic, copy  ) NSString *strPrefixCarNumber;
/** 车牌数字 */
@property (nonatomic, copy  ) NSString *strCarNumberContent;

@end

NS_ASSUME_NONNULL_END
