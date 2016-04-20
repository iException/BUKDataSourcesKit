//
//  BUKCollectionViewDataSourceProvider.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

@import UIKit;


@class BUKCollectionViewSection;
@protocol BUKCollectionViewCellFactoryProtocol;
@protocol BUKCollectionViewSupplementaryViewFactoryProtocol;

@interface BUKCollectionViewDataSourceProvider : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, copy) NSArray<BUKCollectionViewSection *> *sections;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic) id<BUKCollectionViewCellFactoryProtocol> cellFactory;
@property (nonatomic) id<BUKCollectionViewSupplementaryViewFactoryProtocol> supplementaryViewFactory;

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView sections:(NSArray<BUKCollectionViewSection *> *)sections;

@end
