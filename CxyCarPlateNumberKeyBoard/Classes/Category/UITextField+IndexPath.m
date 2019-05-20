//
//  UITextField+IndexPath.m
//  HertzCwz
//
//  Created by 洋子总 on 2018/11/12.
//  Copyright © 2018 hertz. All rights reserved.
//

#import "UITextField+IndexPath.h"
#import <objc/runtime.h>

@implementation UITextField (IndexPath)

static char indexPathKey;
- (NSIndexPath *)indexPath {
    return objc_getAssociatedObject(self, &indexPathKey);
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    objc_setAssociatedObject(self, &indexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
