//
//  BUKFlowLayoutCollectionViewDataSourceProvider.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/20/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKCollectionViewFlowLayoutDataSourceProvider.h"
#import "BUKCollectionViewFlowLayoutSection.h"
#import "BUKCollectionViewFlowLayoutItem.h"
#import "BUKCollectionViewFlowLayoutInfoProtocol.h"


@implementation BUKCollectionViewFlowLayoutDataSourceProvider

#pragma mark - Accessors

@dynamic flowLayoutSections;

- (void)setFlowLayoutSections:(NSArray<BUKCollectionViewFlowLayoutSection *> *)flowLayoutSections {
    self.sections = flowLayoutSections;
}


- (NSArray<BUKCollectionViewFlowLayoutSection *> *)flowLayoutSections {
    return self.sections;
}


#pragma mark - Private

- (BUKCollectionViewFlowLayoutSection *)flowLayoutSectionAtIndex:(NSInteger)index {
    BUKCollectionViewFlowLayoutSection *section = [self sectionAtIndex:index];
    if (![section isKindOfClass:[BUKCollectionViewFlowLayoutSection class]]) {
        return nil;
    }
    return section;
}


- (BUKCollectionViewFlowLayoutItem *)flowLayoutItemAtIndexPath:(NSIndexPath *)indexPath {
    BUKCollectionViewFlowLayoutItem *item = [self itemAtIndexPath:indexPath];
    if (![item isKindOfClass:[BUKCollectionViewFlowLayoutItem class]]) {
        return nil;
    }
    return item;
}


- (id<BUKCollectionViewSectionFlowLayoutInfoProtocol>)sectionFlowLayoutInfoForSection:(BUKCollectionViewFlowLayoutSection *)section {
    if (section.sectionFlowLayoutInfo) {
        return section.sectionFlowLayoutInfo;
    }
    return self.sectionFlowLayoutInfo;
}


- (id<BUKCollectionViewItemFlowLayoutInfoProtocol>)itemFlowLayoutInfoForItem:(BUKCollectionViewFlowLayoutItem *)item inSection:(BUKCollectionViewFlowLayoutSection *)section {
    if (item.itemFlowLayoutInfo) {
        return item.itemFlowLayoutInfo;
    }
    if (section.itemFlowLayoutInfo) {
        return section.itemFlowLayoutInfo;
    }
    return self.itemFlowLayoutInfo;
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    BUKCollectionViewFlowLayoutSection *section = [self flowLayoutSectionAtIndex:indexPath.section];
    BUKCollectionViewFlowLayoutItem *item = [self flowLayoutItemAtIndexPath:indexPath];
    id<BUKCollectionViewItemFlowLayoutInfoProtocol> itemFlowLayout = [self itemFlowLayoutInfoForItem:item inSection:section];
    if (!itemFlowLayout) {
        return collectionViewLayout.itemSize;
    }

    return [itemFlowLayout sizeForItem:item atIndexPath:indexPath inCollectionView:collectionView layout:collectionViewLayout];
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)index {
    BUKCollectionViewFlowLayoutSection *section = [self flowLayoutSectionAtIndex:index];
    id<BUKCollectionViewSectionFlowLayoutInfoProtocol> sectionFlowLayoutInfo = [self sectionFlowLayoutInfoForSection:section];
    if (!sectionFlowLayoutInfo) {
        return collectionViewLayout.sectionInset;
    }

    return [sectionFlowLayoutInfo insetForSection:section atIndex:index inCollectionView:collectionView layout:collectionViewLayout];
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)index {
    BUKCollectionViewFlowLayoutSection *section = [self flowLayoutSectionAtIndex:index];
    id<BUKCollectionViewSectionFlowLayoutInfoProtocol> sectionFlowLayoutInfo = [self sectionFlowLayoutInfoForSection:section];
    if (!sectionFlowLayoutInfo) {
        return collectionViewLayout.minimumLineSpacing;
    }

    return [sectionFlowLayoutInfo minimumLineSpacingForSection:section atIndex:index inCollectionView:collectionView layout:collectionViewLayout];
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)index {
    BUKCollectionViewFlowLayoutSection *section = [self flowLayoutSectionAtIndex:index];
    id<BUKCollectionViewSectionFlowLayoutInfoProtocol> sectionFlowLayoutInfo = [self sectionFlowLayoutInfoForSection:section];
    if (!sectionFlowLayoutInfo) {
        return collectionViewLayout.minimumInteritemSpacing;
    }

    return [sectionFlowLayoutInfo minimumInteritemSpacingForSection:sectionFlowLayoutInfo atIndex:index inCollectionView:collectionView layout:collectionViewLayout];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)index {
    BUKCollectionViewFlowLayoutSection *section = [self flowLayoutSectionAtIndex:index];
    id<BUKCollectionViewSectionFlowLayoutInfoProtocol> sectionFlowLayoutInfo = [self sectionFlowLayoutInfoForSection:section];
    if (!sectionFlowLayoutInfo) {
        return collectionViewLayout.headerReferenceSize;
    }

    return [sectionFlowLayoutInfo referenceSizeForHeaderInSection:section atIndex:index inCollectionView:collectionView layout:collectionViewLayout];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)index {
    BUKCollectionViewFlowLayoutSection *section = [self flowLayoutSectionAtIndex:index];
    id<BUKCollectionViewSectionFlowLayoutInfoProtocol> sectionFlowLayoutInfo = [self sectionFlowLayoutInfoForSection:section];
    if (!sectionFlowLayoutInfo) {
        return collectionViewLayout.footerReferenceSize;
    }

    return [sectionFlowLayoutInfo referenceSizeForFooterInSection:section atIndex:index inCollectionView:collectionView layout:collectionViewLayout];
}

@end
