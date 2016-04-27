//
//  BUKCollectionViewFlowLayoutDataSourceProvider.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/20/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKCollectionViewDataSourceProvider.h"


@class BUKCollectionViewFlowLayoutSection;
@protocol BUKCollectionViewSectionFlowLayoutInfoProtocol;
@protocol BUKCollectionViewItemFlowLayoutInfoProtocol;

@interface BUKCollectionViewFlowLayoutDataSourceProvider : BUKCollectionViewDataSourceProvider <UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy) NSArray<BUKCollectionViewFlowLayoutSection *> *flowLayoutSections;
@property (nonatomic) id<BUKCollectionViewSectionFlowLayoutInfoProtocol> sectionFlowLayoutInfo;
@property (nonatomic) id<BUKCollectionViewItemFlowLayoutInfoProtocol> itemFlowLayoutInfo;

@end
