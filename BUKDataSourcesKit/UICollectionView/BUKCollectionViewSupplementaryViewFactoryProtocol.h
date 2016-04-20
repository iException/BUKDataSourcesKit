//
//  BUKCollectionViewSupplementaryViewFactoryProtocol.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/19/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

@import UIKit;


@class BUKCollectionViewItem;

@protocol BUKCollectionViewSupplementaryViewFactoryProtocol <NSObject>

@required
- (NSArray<NSString *> *)supplementaryViewKindsForItem:(BUKCollectionViewItem *)item atIndexPath:(NSIndexPath *)indexPath;
- (Class)supplementaryViewClassForItem:(BUKCollectionViewItem *)item kind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;
- (NSString *)reuseIdentifierForItem:(BUKCollectionViewItem *)item kind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;
- (void)configureSupplementaryView:(UICollectionReusableView *)view item:(BUKCollectionViewItem *)item kind:(NSString *)kind inCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@end
