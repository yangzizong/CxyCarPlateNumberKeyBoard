//
//  CxyCarPlateNumberKeyBoardCell.h
//  CxyCarPlateNumberKeyBoard
//
//  Created by 洋子总 on 2018/11/7.
//  Copyright © 2018 hertz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CxyCarPlateNumberKeyBoardModel;

NS_ASSUME_NONNULL_BEGIN

@interface CxyCarPlateNumberKeyBoardCell : UICollectionViewCell

@property (nonatomic, strong) CxyCarPlateNumberKeyBoardModel *model;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy  ) void(^didClicked)(NSIndexPath *indexPath);

@end

NS_ASSUME_NONNULL_END
