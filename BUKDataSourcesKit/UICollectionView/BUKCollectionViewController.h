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

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)collectionViewLayout NS_DESIGNATED_INITIALIZER;

@end
