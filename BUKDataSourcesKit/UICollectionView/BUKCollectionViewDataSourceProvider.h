//
//  BUKCollectionViewDataSourceProvider.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

@import UIKit;


@class BUKCollectionViewSection;
@class BUKCollectionViewItem;
@protocol BUKCollectionViewCellFactoryProtocol;
@protocol BUKCollectionViewSupplementaryViewFactoryProtocol;

@interface BUKCollectionViewDataSourceProvider : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, copy) NSArray<__kindof BUKCollectionViewSection *> *sections;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic) id<BUKCollectionViewCellFactoryProtocol> cellFactory;
@property (nonatomic) id<BUKCollectionViewSupplementaryViewFactoryProtocol> supplementaryViewFactory;
@property (nonatomic) BOOL automaticallyDeselectItems;
@property (nonatomic) BOOL automaticallyRegisterCells;
@property (nonatomic) BOOL automaticallyRegisterSupplementaryViews;

+ (instancetype)provider;
+ (instancetype)providerWithCollectionView:(UICollectionView *)collectionView;
+ (instancetype)providerWithCollectionView:(UICollectionView *)collectionView sections:(NSArray<__kindof BUKCollectionViewSection *> *)sections;
+ (instancetype)providerWithCollectionView:(UICollectionView *)collectionView sections:(NSArray<__kindof BUKCollectionViewSection *> *)sections cellFactory:(id<BUKCollectionViewCellFactoryProtocol>)cellFactory supplementaryViewFactory:(id<BUKCollectionViewSupplementaryViewFactoryProtocol>)supplementaryViewFactory;

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView sections:(NSArray<__kindof BUKCollectionViewSection *> *)sections;
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView sections:(NSArray<__kindof BUKCollectionViewSection *> *)sections cellFactory:(id<BUKCollectionViewCellFactoryProtocol>)cellFactory supplementaryViewFactory:(id<BUKCollectionViewSupplementaryViewFactoryProtocol>)supplementaryViewFactory NS_DESIGNATED_INITIALIZER;

- (__kindof BUKCollectionViewSection *)sectionAtIndex:(NSInteger)index;
- (__kindof BUKCollectionViewItem *)itemAtIndexPath:(NSIndexPath *)indexPath;
- (void)refresh;

@end
