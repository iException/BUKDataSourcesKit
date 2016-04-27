//
//  BUKCollectionViewItemFlowLayoutInfo.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/25/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved. 
//

#import "BUKCollectionViewFlowLayoutInfoProtocol.h"


typedef CGSize (^BUKCollectionViewItemSizeCalculator)(BUKCollectionViewItem *item, NSIndexPath *indexPath, UICollectionView *collectionView, UICollectionViewLayout *layout);


@interface BUKCollectionViewItemFlowLayoutInfo : NSObject <BUKCollectionViewItemFlowLayoutInfoProtocol>

@property (nonatomic) CGSize defaultItemSize;
@property (nonatomic, copy) BUKCollectionViewItemSizeCalculator itemSizeCalculator;
@property (nonatomic) BOOL usesCache;

+ (instancetype)layoutInfoWithDefaultItemSize:(CGSize)size calculator:(BUKCollectionViewItemSizeCalculator)calculator;

- (instancetype)initWithDefaultItemSize:(CGSize)size calculator:(BUKCollectionViewItemSizeCalculator)calculator NS_DESIGNATED_INITIALIZER;
- (void)clearCache;

@end
