//
//  BUKCollectionViewController.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKCollectionViewController.h"
#import "BUKCollectionViewDataSourceProvider.h"


@implementation BUKCollectionViewController

#pragma mark - Initializer

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)collectionViewLayout {
    if ((self = [super initWithNibName:nil bundle:nil])) {
        _collectionViewLayout = collectionViewLayout;
    }

    return self;
}


#pragma mark - UIViewController

- (void)loadView {
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view = _collectionView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSourceProvider = [[BUKCollectionViewDataSourceProvider alloc] initWithCollectionView:self.collectionView];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self performInitialLoad];
    [self clearSelectionsIfNecessary:animated];
}


#pragma mark - Private

- (void)performInitialLoad {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self.collectionView reloadData];
    });
}


- (void)clearSelectionsIfNecessary:(BOOL)animated {
    if (!self.clearsSelectionOnViewWillAppear) {
        return;
    }

    NSArray<NSIndexPath *> *selectedIndexPaths = [self.collectionView indexPathsForSelectedItems];
    if (!selectedIndexPaths) {
        return;
    }

    id<UIViewControllerTransitionCoordinator> transitionCoordinator = [self transitionCoordinator];
    if (!transitionCoordinator) {
        [self deselectRowsAtIndexPaths:selectedIndexPaths animated:animated];
        return;
    }

    __weak typeof(self)weakSelf = self;
    void (^animation)(id<UIViewControllerTransitionCoordinatorContext> context) = ^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [weakSelf deselectRowsAtIndexPaths:selectedIndexPaths animated:animated];
    };

    void (^completion)(id<UIViewControllerTransitionCoordinatorContext> context) = ^(id<UIViewControllerTransitionCoordinatorContext> context) {
        if ([context isCancelled]) {
            [weakSelf selectRowsAtIndexPaths:selectedIndexPaths animated:animated];
        }
    };

    [transitionCoordinator animateAlongsideTransition:animation completion:completion];
}


- (void)selectRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animated:(BOOL)animated {
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull indexPath, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.collectionView selectItemAtIndexPath:indexPath animated:animated scrollPosition:UICollectionViewScrollPositionNone];
    }];
}


- (void)deselectRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animated:(BOOL)animated {
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull indexPath, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.collectionView deselectItemAtIndexPath:indexPath animated:animated];
    }];
}

@end
