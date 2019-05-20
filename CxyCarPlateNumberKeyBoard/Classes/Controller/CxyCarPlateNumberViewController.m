//
//  ZYCarPlateNumberViewController.m
//  CxyCarPlateNumberKeyBoard
//
//  Created by 洋子总 on 2018/11/7.
//  Copyright © 2018 hertz. All rights reserved.
//

#import "CxyCarPlateNumberViewController.h"

@interface ZYCarPlateNumberViewController ()

/* 车牌号码长度, 默认长度为7 */
@property (nonatomic, assign) NSUInteger plateNumberLength;

@end

@implementation ZYCarPlateNumberViewController

- (instancetype)init {
    if (self = [super init]) {
        // 默认车牌号码长度为7
        self.plateNumberLength = 7;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
