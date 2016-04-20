//
//  BUKCollectionViewController.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKCollectionViewController.h"
#import "BUKCollectionViewDataSourceProvider.h"


@interface BUKCollectionViewController ()

@property (nonatomic) UICollectionViewLayout *layout;
@property (nonatomic, readwrite) BUKCollectionViewDataSourceProvider *dataSourceProvider;

@end


@implementation BUKCollectionViewController

#pragma mark - Initializer

- (instancetype)initWithLayout:(UICollectionViewLayout *)layout {
    if ((self = [super initWithNibName:nil bundle:nil])) {
        _layout = layout;
    }

    return self;
}


#pragma mark - UIViewController

- (void)loadView {
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view = _collectionView;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataSourceProvider = [[BUKCollectionViewDataSourceProvider alloc] initWithCollectionView:self.collectionView];
}

@end
