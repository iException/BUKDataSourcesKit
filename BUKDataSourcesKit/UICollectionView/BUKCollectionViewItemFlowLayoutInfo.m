//
//  BUKCollectionViewFlowLayoutItem.m
//  BUKDataSourcesKit 
//
//  Created by Yiming Tang on 4/25/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKCollectionViewItemFlowLayoutInfo.h"


@implementation BUKCollectionViewItemFlowLayoutInfo

#pragma mark - BUKCollectionViewItemFlowLayoutInfoProtocol

- (CGSize)sizeForItem:(id)item atIndexPath:(NSIndexPath *)indexPath inCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)layout {
    return self.itemSize;
}

@end
