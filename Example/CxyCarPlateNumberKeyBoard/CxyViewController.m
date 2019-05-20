//
//  CxyViewController.m
//  CxyCarPlateNumberKeyBoard
//
//  Created by yangzizong on 05/20/2019.
//  Copyright (c) 2019 yangzizong. All rights reserved.
//

#import "CxyViewController.h"
#import "CxyCarPlateNumberCell.h"

static NSString * const CxyCarPlateNumberCellID = @"CxyCarPlateNumberCell";

@interface CxyViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CxyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setUpTableView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exitKeyboard:)];
    [self.view addGestureRecognizer:tap];
}

- (void)setUpTableView {
    [self.view addSubview:self.tableView];
    
    // 注册CxyCarPlateNumberCell
    [self.tableView registerClass:[CxyCarPlateNumberCell class] forCellReuseIdentifier:CxyCarPlateNumberCellID];
}

- (void)exitKeyboard:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - UITableVIewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CxyCarPlateNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:CxyCarPlateNumberCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
