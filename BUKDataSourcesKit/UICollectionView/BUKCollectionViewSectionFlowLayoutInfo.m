//
//  BUKCollectionViewSectionFlowLayoutInfo.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/22/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKCollectionViewSectionFlowLayoutInfo.h"


@implementation BUKCollectionViewSectionFlowLayoutInfo

#pragma mark - Initializer

- (instancetype)init {
    if ((self = [super init])) {
        _minimumLineSpacing = 0;
        _minimumInteritemSpacing = 0;
        _headerReferenceSize = CGSizeZero;
        _footerReferenceSize = CGSizeZero;
        _sectionInset = UIEdgeInsetsZero;
    }

    return self;
}


#pragma mark - BUKCollectionViewSectionFlowLayoutInfoProtocol

- (UIEdgeInsets)insetForSection:(BUKCollectionViewSection *)section atIndex:(NSInteger)index inCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)layout {
    return self.sectionInset;
}


- (CGFloat)minimumLineSpacingForSection:(BUKCollectionViewSection *)section atIndex:(NSInteger)index inCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)layout {
    return self.minimumLineSpacing;
}


- (CGFloat)minimumInteritemSpacingForSection:(BUKCollectionViewSection *)section atIndex:(NSInteger)index inCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout {
    return self.minimumInteritemSpacing;
}


- (CGSize)referenceSizeForHeaderInSection:(BUKCollectionViewSection *)section atIndex:(NSInteger)index inCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout {
    return self.headerReferenceSize;
}


- (CGSize)referenceSizeForFooterInSection:(BUKCollectionViewSection *)section atIndex:(NSInteger)index inCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout {
    return self.footerReferenceSize;
}

@end
