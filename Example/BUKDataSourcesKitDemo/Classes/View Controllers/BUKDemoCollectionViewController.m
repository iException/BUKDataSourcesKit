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
    self.title = @"Collection View";
    self.collectionView.backgroundColor = [UIColor whiteColor];

    BUKCollectionViewFlowLayoutDataSourceProvider *provider = [[BUKCollectionViewFlowLayoutDataSourceProvider alloc] initWithCollectionView:self.collectionView];

    BUKCollectionViewCellFactory *cellFactory = [[BUKCollectionViewCellFactory alloc] initWithCellClass:[BUKDemoSubtitleCollectionViewCell class] configurator:^( BUKDemoSubtitleCollectionViewCell *cell, BUKCollectionViewItem *item, UICollectionView *collectionView, NSIndexPath *indexPath) {
        BUKDemoTextViewModel *viewModel = item.object;
        cell.titleLabel.text = viewModel.title;
        cell.subtitleLabel.text = viewModel.subtitle;
    }];

    BUKCollectionViewSupplementaryViewFactory *supplementaryViewFactory = [[BUKCollectionViewSupplementaryViewFactory alloc] initWithSupplementaryViewClass:[BUKDemoCollectionViewSectionHeaderView class] kind:UICollectionElementKindSectionHeader configurator:^(BUKDemoCollectionViewSectionHeaderView *view, BUKCollectionViewItem *item, NSString *kind, UICollectionView *collectionView, NSIndexPath *indexPath) {
        view.titleLabel.text = [NSString stringWithFormat:@"Section Header %ld", (long)indexPath.section];
    }];

    BUKCollectionViewSelection *selection = [[BUKCollectionViewSelection alloc] initWithSelectionHandler:^(UICollectionView *collectionView, BUKCollectionViewItem *item, NSIndexPath *indexPath) {
        NSLog(@"Selected item at index path: %@", indexPath);
    } deselectionHandler:^(UICollectionView *collectionView, BUKCollectionViewItem *item, NSIndexPath *indexPath) {
        NSLog(@"Deselected item at index path: %@", indexPath);
    }];

    NSMutableArray<BUKCollectionViewItem *> *items = [NSMutableArray array];
    for (NSInteger i = 0; i < 100; i++) {
        BUKDemoTextViewModel *viewModel = [BUKDemoTextViewModel viewModelWithTitle:[NSString stringWithFormat:@"Item %ld", (long)i] subtitle:@"Subtitle"];
        BUKCollectionViewItem *item = [[BUKCollectionViewItem alloc] initWithObject:viewModel cellFactory:nil supplementaryViewFactory:nil selection:selection];
        [items addObject:item];
    }

    BUKCollectionViewFlowLayoutSection *section = [[BUKCollectionViewFlowLayoutSection alloc] initWithItems:items];

    BUKCollectionViewSectionFlowLayoutInfo *sectionFlowLayoutInfo = [BUKCollectionViewSectionFlowLayoutInfo layoutInfo];
    sectionFlowLayoutInfo.minimumLineSpacing = 10.0f;
    sectionFlowLayoutInfo.headerReferenceSize = CGSizeMake(0, 100.0f);
    section.sectionFlowLayoutInfo = sectionFlowLayoutInfo;

    provider.itemFlowLayoutInfo = [BUKCollectionViewItemFlowLayoutInfo layoutInfoWithDefaultItemSize:CGSizeZero calculator:^CGSize(BUKCollectionViewItem *item, NSIndexPath *indexPath, UICollectionView *collectionView, UICollectionViewLayout *layout) {
        return CGSizeMake(collectionView.bounds.size.width / 4.0f, 80.0f);
    }];
    provider.cellFactory = cellFactory;
    provider.supplementaryViewFactory = supplementaryViewFactory;
    provider.sections = @[section];

    self.dataSourceProvider = provider;
}

@end
