//
//  BUKCollectionViewFlowLayoutSection.h
//  BUKCollectionViewSection
//
//  Created by Yiming Tang on 4/25/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKCollectionViewSection.h"

@class BUKCollectionViewFlowLayoutItem;
@protocol BUKCollectionViewSectionFlowLayoutInfoProtocol;
@protocol BUKCollectionViewItemFlowLayoutInfoProtocol;

@interface BUKCollectionViewFlowLayoutSection : BUKCollectionViewSection

@property (nonatomic) NSArray<BUKCollectionViewFlowLayoutItem *> *flowLayoutItems;
@property (nonatomic) id<BUKCollectionViewSectionFlowLayoutInfoProtocol> sectionFlowLayoutInfo;
@property (nonatomic) id<BUKCollectionViewItemFlowLayoutInfoProtocol> itemFlowLayoutInfo;

- (BUKCollectionViewFlowLayoutItem *)flowLayoutItemAtIndex:(NSInteger)index;

@end
