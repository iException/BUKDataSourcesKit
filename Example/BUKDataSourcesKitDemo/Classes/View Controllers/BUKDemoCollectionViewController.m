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
    flowLayout.itemSize = CGSizeMake(100.0f, 60.0f);
    flowLayout.headerReferenceSize = CGSizeMake(0, 30.0f);
    return [super initWithCollectionViewLayout:flowLayout];
}


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Collection View";
    self.collectionView.backgroundColor = [UIColor whiteColor];

    BUKCollectionViewCellFactory *cellFactory = [[BUKCollectionViewCellFactory alloc] initWithCellClass:[BUKDemoSubtitleCollectionViewCell class] configurator:^( BUKDemoSubtitleCollectionViewCell *cell, BUKCollectionViewItem *item, UICollectionView *collectionView, NSIndexPath *indexPath) {
        BUKDemoTextViewModel *viewModel = item.object;
        cell.titleLabel.text = viewModel.title;
        cell.subtitleLabel.text = viewModel.subtitle;
    }];

    BUKCollectionViewSupplementaryViewFactory *supplementaryViewFactory = [[BUKCollectionViewSupplementaryViewFactory alloc] initWithSupplementaryViewClass:[BUKDemoCollectionViewSectionHeaderView class] kind:UICollectionElementKindSectionHeader configurator:^(BUKDemoCollectionViewSectionHeaderView *view, BUKCollectionViewItem *item, NSString *kind, UICollectionView *collectionView, NSIndexPath *indexPath) {
        view.titleLabel.text = [NSString stringWithFormat:@"Section Header %ld", (long)indexPath.section];
    }];

    NSMutableArray<BUKCollectionViewItem *> *items = [NSMutableArray array];
    for (NSInteger i = 0; i < 100; i++) {
        BUKDemoTextViewModel *viewModel = [BUKDemoTextViewModel viewModelWithTitle:[NSString stringWithFormat:@"Item %ld", (long)i] subtitle:@"Subtitle"];
        BUKCollectionViewItem *item = [[BUKCollectionViewItem alloc] initWithObject:viewModel];
        [items addObject:item];
    }

    BUKCollectionViewFlowLayoutSection *section = [[BUKCollectionViewFlowLayoutSection alloc] initWithItems:items];

    self.dataSourceProvider.cellFactory = cellFactory;
    self.dataSourceProvider.supplementaryViewFactory = supplementaryViewFactory;
    self.dataSourceProvider.sections = @[section];
}

@end
