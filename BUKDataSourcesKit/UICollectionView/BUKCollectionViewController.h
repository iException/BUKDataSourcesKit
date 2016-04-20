//
//  BUKCollectionViewController.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

@import UIKit;


@class BUKCollectionViewDataSourceProvider;

@interface BUKCollectionViewController : UIViewController

@property (nonatomic, readonly) UICollectionView *collectionView;
@property (nonatomic, readonly) UICollectionViewLayout *collectionViewLayout;
@property (nonatomic) BUKCollectionViewDataSourceProvider *dataSourceProvider;
@property (nonatomic) BOOL clearsSelectionOnViewWillAppear;

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)collectionViewLayout;

@end
