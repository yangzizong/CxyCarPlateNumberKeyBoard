//
//  CxyCarPlateNumberKeyBoard.m
//  CxyCarPlateNumberKeyBoard
//
//  Created by 洋子总 on 2018/11/6.
//  Copyright © 2018 hertz. All rights reserved.
//

#import "CxyCarPlateNumberKeyBoard.h"
#import "CxyCarPlateNumberKeyBoardModel.h"
#import "CxyCarPlateNumberKeyBoardViewModel.h"
#import "CxyCarPlateNumberKeyBoardCell.h"

#define kScreenWidth        [UIScreen mainScreen].bounds.size.width
#define KScreenHeight       [UIScreen mainScreen].bounds.size.height
/** 屏幕最大高度 */
#define kScreen_Max_Length  (MAX(KScreenWidth, KScreenHeight))

/** 屏幕尺寸判断 */
#define k_IPHONE            (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
/** iPhonex 5.8寸 375*812 */
#define k_IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})
/** 底部安全区域 */
#define kSafeBottomMargin   (k_IPHONE_X ? 65.f : 0.f)
/** 颜色值 */
#define UIColorFrom0xValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8) )/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

static NSString * const CxyCarPlateNumberKeyBoardCellID = @"CxyCarPlateNumberKeyBoardCell";

@interface CxyCarPlateNumberKeyBoard ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) CxyCarPlateNumberKeyBoardViewModel *viewModel;

@property (nonatomic, assign) CGFloat keyboardItemHeight;

@property (nonatomic, assign) CGFloat keyboardItemWidth;

@end

@implementation CxyCarPlateNumberKeyBoard

- (instancetype)initWithFrame:(CGRect)frame {
    [self initItemSize];
    frame.size.width = kScreenWidth;
    frame.origin.y = 0;
    frame.origin.x = 0;
    
    if (k_IPHONE_X) {
        frame.size.height = self.keyboardItemHeight * 4 + kSafeBottomMargin + 10;
    } else {
        frame.size.height = self.keyboardItemHeight * 4 + 10;
    }
    
    if (self = [super initWithFrame:frame]) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self addSubview:self.collectionView];
        self.collectionView.backgroundColor = UIColorFrom0xValue(0xD1D4D9);
        
        // 注册CxyCarPlateNumberKeyBoardCell
        [self.collectionView registerClass:[CxyCarPlateNumberKeyBoardCell class] forCellWithReuseIdentifier:CxyCarPlateNumberKeyBoardCellID];
    }
    return self;
}

// 重新布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self initItemSize];
    CGRect frame = self.bounds;
    frame.size.width = kScreenWidth;
    frame.origin.y = 0;
    frame.origin.x = 0;
    if (k_IPHONE_X) {
        frame.size.height = self.keyboardItemHeight * 4 + kSafeBottomMargin + 10;
    } else {
        frame.size.height = self.keyboardItemHeight * 4 + 10;
    }
    self.collectionView.frame = frame;
    [self.collectionView reloadData];
}

// 初始化键盘item大小
- (void)initItemSize {
    self.keyboardItemWidth = kScreenWidth / 10.f;
    if (self.keyboardItemWidth > 60) {
        self.keyboardItemWidth = 60;
    }
    
    self.keyboardItemHeight = 54;
}

- (CxyCarPlateNumberKeyBoardViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[CxyCarPlateNumberKeyBoardViewModel alloc] init];
        _viewModel.showProvinceKeyType = YES;
    }
    return _viewModel;
}

- (void)setShowProvinceKeyType:(BOOL)showProvinceKeyType {
    _showProvinceKeyType = showProvinceKeyType;
    
    self.viewModel.showProvinceKeyType = showProvinceKeyType;
    
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.viewModel.dataSource.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.keyboardItemWidth, self.keyboardItemHeight);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel.dataSource[section] count];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    NSArray *items = self.viewModel.dataSource[section];
    CGFloat width = self.keyboardItemWidth * items.count;
    
    CGFloat leftMargin = 0;
    if (width < collectionView.bounds.size.width) {
        leftMargin = (collectionView.bounds.size.width - width)/2.f; // 保证所有按钮居中
    }
    
    return UIEdgeInsetsMake(0, leftMargin, 0, leftMargin);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CxyCarPlateNumberKeyBoardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CxyCarPlateNumberKeyBoardCellID forIndexPath:indexPath];
    cell.model = self.viewModel.dataSource[indexPath.section][indexPath.row];
    __weak typeof(self) weakSelf = self;
    cell.indexPath = indexPath;
    cell.didClicked = ^(NSIndexPath *indexPath) {
        [weakSelf collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CxyCarPlateNumberKeyBoardModel *model = self.viewModel.dataSource[indexPath.section][indexPath.row];
    if (model.changeKeyBoardType) {
        self.viewModel.showProvinceKeyType = !self.viewModel.showProvinceKeyType;
        [collectionView reloadData];
        return;
    }
    if (self.viewModel.showProvinceKeyType && !model.deleteTextType) {
        self.viewModel.showProvinceKeyType = NO;
        [collectionView reloadData];
    }
    if (self.keyBoardEditing) {
        self.keyBoardEditing(model.deleteTextType, model.text);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
