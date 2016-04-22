//
//  BUKCollectionViewSectionFlowLayoutInfoProtocol.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/22/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

@import UIKit;


@class BUKCollectionViewSection;

@protocol BUKCollectionViewSectionFlowLayoutInfoProtocol <NSObject>

@optional
- (UIEdgeInsets)insetForSection:(BUKCollectionViewSection *)section atIndex:(NSInteger)index inCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)layout;
- (CGFloat)minimumLineSpacingForSection:(BUKCollectionViewSection *)section atIndex:(NSInteger)index inCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)layout;
- (CGFloat)minimumInteritemSpacingForSection:(BUKCollectionViewSection *)section atIndex:(NSInteger)index inCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout;
- (CGSize)referenceSizeForHeaderInSection:(BUKCollectionViewSection *)section atIndex:(NSInteger)index inCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout;
- (CGSize)referenceSizeForFooterInSection:(BUKCollectionViewSection *)section atIndex:(NSInteger)index inCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout;

@end
