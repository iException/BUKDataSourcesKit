//
//  BUKDemoCollectionViewController.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/13/16.
//  Copyright © 2016 Yiming Tang. All rights reserved.
//

#import "BUKDemoCollectionViewController.h"
#import "BUKDemoSubtitleCollectionViewCell.h"
#import "BUKDemoCollectionViewSectionHeaderView.h"
#import "BUKDemoTextViewModel.h"


@interface BUKDemoCollectionViewController ()

@property (nonatomic, assign) BOOL isLong;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *insertButton;
@property (nonatomic, strong) UIButton *replaceButton;
@property (nonatomic, strong) BUKCollectionViewFlowLayoutSection *section;

@end


@implementation BUKDemoCollectionViewController

#pragma mark - Initializer

- (instancetype)init {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    return [super initWithCollectionViewLayout:flowLayout];
}


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.addButton];
    [self.view addSubview:self.insertButton];
    [self.view addSubview:self.replaceButton];
    self.title = @"Collection View";
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.contentInset = UIEdgeInsetsMake(40.0, 0, 0, 0);

    BUKCollectionViewCellFactory *cellFactory = [[BUKCollectionViewCellFactory alloc] initWithCellClass:[BUKDemoSubtitleCollectionViewCell class] configurator:^( BUKDemoSubtitleCollectionViewCell *cell, BUKCollectionViewItem *item, UICollectionView *collectionView, NSIndexPath *indexPath) {
        BUKDemoTextViewModel *viewModel = item.object;
        cell.titleLabel.text = viewModel.title;
        cell.subtitleLabel.text = viewModel.subtitle;
    }];

    BUKCollectionViewSupplementaryViewFactory *supplementaryViewFactory = [[BUKCollectionViewSupplementaryViewFactory alloc] initWithSupplementaryViewClass:[BUKDemoCollectionViewSectionHeaderView class] kind:UICollectionElementKindSectionHeader configurator:^(BUKDemoCollectionViewSectionHeaderView *view, BUKCollectionViewItem *item, NSString *kind, UICollectionView *collectionView, NSIndexPath *indexPath) {
        view.titleLabel.text = [NSString stringWithFormat:@"Section Header %ld, touch item to remove", (long)indexPath.section];
        view.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    }];

    BUKCollectionViewSelection *selection = [[BUKCollectionViewSelection alloc] initWithSelectionHandler:^(UICollectionView *collectionView, BUKCollectionViewItem *item, NSIndexPath *indexPath) {
        NSLog(@"Selected item at index path: %@", indexPath);
        [self removeIndexPath:indexPath];
    } deselectionHandler:^(UICollectionView *collectionView, BUKCollectionViewItem *item, NSIndexPath *indexPath) {
        NSLog(@"Deselected item at index path: %@", indexPath);
    }];

    NSMutableArray<BUKCollectionViewItem *> *items = [NSMutableArray array];
    for (NSInteger i = 0; i < 100; i++) {
        BUKDemoTextViewModel *viewModel = [BUKDemoTextViewModel viewModelWithTitle:[NSString stringWithFormat:@"%ld", (long)i] subtitle:@"Subtitle"];
        BUKCollectionViewItem *item = [[BUKCollectionViewItem alloc] initWithObject:viewModel cellFactory:nil supplementaryViewFactory:nil selection:selection];
        [items addObject:item];
    }

    self.section = [[BUKCollectionViewFlowLayoutSection alloc] initWithItems:items];

    BUKCollectionViewSectionFlowLayoutInfo *sectionFlowLayoutInfo = [BUKCollectionViewSectionFlowLayoutInfo layoutInfo];
    sectionFlowLayoutInfo.minimumLineSpacing = 10.0f;
    sectionFlowLayoutInfo.headerReferenceSize = CGSizeMake(0, 100.0f);
    self.section.sectionFlowLayoutInfo = sectionFlowLayoutInfo;

    BUKCollectionViewFlowLayoutDataSourceProvider *provider = [[BUKCollectionViewFlowLayoutDataSourceProvider alloc] initWithCollectionView:self.collectionView sections:@[ self.section ]];
    provider.itemFlowLayoutInfo = [BUKCollectionViewItemFlowLayoutInfo layoutInfoWithDefaultItemSize:CGSizeZero calculator:^CGSize(BUKCollectionViewItem *item, NSIndexPath *indexPath, UICollectionView *collectionView, UICollectionViewLayout *layout) {
        if (self.isLong) {
            return CGSizeMake(collectionView.bounds.size.width / 4.0f, 160.0f);
        } else {
            return CGSizeMake(collectionView.bounds.size.width / 4.0f, 80.0f);
        }
    }];
    provider.supplementaryViewFactory = supplementaryViewFactory;
    provider.cellFactory = cellFactory;

    self.dataSourceProvider = provider;
}

#pragma mark - action handler

- (void)addNew
{
    BUKDemoTextViewModel *viewModel = [BUKDemoTextViewModel viewModelWithTitle:@"NEW" subtitle:@"new"];
    BUKCollectionViewItem *item = [[BUKCollectionViewItem alloc] initWithObject:viewModel cellFactory:nil supplementaryViewFactory:nil selection: [[BUKCollectionViewSelection alloc] initWithSelectionHandler:^(UICollectionView *collectionView, BUKCollectionViewItem *item, NSIndexPath *indexPath) {
        [self removeIndexPath:indexPath];
    } deselectionHandler:nil]];
    [self.dataSourceProvider insertItem:item atIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
}

- (void)replace
{
    NSMutableArray<BUKCollectionViewItem *> *items = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i++) {
        BUKDemoTextViewModel *viewModel = [BUKDemoTextViewModel viewModelWithTitle:[NSString stringWithFormat:@"RPL%ld", (long)i] subtitle:@"Subtitle"];
        BUKCollectionViewItem *item = [[BUKCollectionViewItem alloc] initWithObject:viewModel cellFactory:nil supplementaryViewFactory:nil selection:nil];
        [items addObject:item];
    }
    self.section = [[BUKCollectionViewFlowLayoutSection alloc] initWithItems:items];
    [self.dataSourceProvider replaceSectionAtIndex:0 withSection:self.section];

}

- (void)insert
{
    NSMutableArray<BUKCollectionViewItem *> *items = [NSMutableArray array];
    NSMutableArray<NSIndexPath *> *indexPaths = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i++) {
        BUKDemoTextViewModel *viewModel = [BUKDemoTextViewModel viewModelWithTitle:[NSString stringWithFormat:@"INS %ld", (long)i] subtitle:@"Subtitle"];
        BUKCollectionViewItem *item = [[BUKCollectionViewItem alloc] initWithObject:viewModel cellFactory:nil supplementaryViewFactory:nil selection:nil];
        [items addObject:item];
        [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:0]];
    }
    [self.dataSourceProvider insertItems:items atIndexPaths:indexPaths];
}

- (void)removeIndexPath:(NSIndexPath *)indexPath
{
    [self.dataSourceProvider removeItemAtIndexPath:indexPath];
}

#pragma mark - getters
- (CGFloat)buttonWidth
{
    return CGRectGetWidth([UIScreen mainScreen].bounds) / 3.0;
}

- (UIButton *)addButton
{
    if (!_addButton) {
        _addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, -40.0, [self buttonWidth], 40.0)];
        _addButton.backgroundColor = [UIColor blackColor];
        [_addButton setTitle:@"add" forState:UIControlStateNormal];
        [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addNew) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

- (UIButton *)insertButton
{
    if (!_insertButton) {
        _insertButton = [[UIButton alloc] initWithFrame:CGRectMake([self buttonWidth], -40.0, [self buttonWidth], 40.0)];
        _insertButton.backgroundColor = [UIColor blackColor];
        [_insertButton setTitle:@"insert" forState:UIControlStateNormal];
        [_insertButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_insertButton addTarget:self action:@selector(insert) forControlEvents:UIControlEventTouchUpInside];
    }
    return _insertButton;
}

- (UIButton *)replaceButton
{
    if (!_replaceButton) {
        _replaceButton = [[UIButton alloc] initWithFrame:CGRectMake([self buttonWidth] * 2.0, -40.0, [self buttonWidth], 40.0)];
        _replaceButton.backgroundColor = [UIColor blackColor];
        [_replaceButton setTitle:@"replace" forState:UIControlStateNormal];
        [_replaceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_replaceButton addTarget:self action:@selector(replace) forControlEvents:UIControlEventTouchUpInside];
    }
    return _replaceButton;
}

@end
