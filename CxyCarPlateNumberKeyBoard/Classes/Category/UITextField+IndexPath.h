//
//  UITextField+IndexPath.h
//  HertzCwz
//
//  Created by 洋子总 on 2018/11/12.
//  Copyright © 2018 hertz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (IndexPath)

/* 对应的 cell indexPath */
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

NS_ASSUME_NONNULL_END
