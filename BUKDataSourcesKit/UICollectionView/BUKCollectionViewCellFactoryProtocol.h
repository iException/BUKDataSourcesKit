//
//  BUKCollectionViewCellFactoryProtocol.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/19/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

@import UIKit;


@class BUKCollectionViewItem;

@protocol BUKCollectionViewCellFactoryProtocol <NSObject>

@required
- (Class)cellClassForItem:(BUKCollectionViewItem *)item atIndexPath:(NSIndexPath *)indexPath;
- (NSString *)reuseIdentifierForItem:(BUKCollectionViewItem *)item atIndexPath:(NSIndexPath *)indexPath;
- (void)configureCell:(__kindof UICollectionViewCell *)cell withItem:(BUKCollectionViewItem *)item inCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@end
