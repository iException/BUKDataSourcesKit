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
@property (nonatomic, readonly) BUKCollectionViewDataSourceProvider *dataSourceProvider;

- (instancetype)initWithLayout:(UICollectionViewLayout *)layout;

@end
