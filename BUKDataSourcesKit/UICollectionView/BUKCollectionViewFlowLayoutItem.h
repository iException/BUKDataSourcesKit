//
//  BUKCollectionViewFlowLayoutItem.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/25/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.  
//

#import "BUKCollectionViewItem.h"


@protocol BUKCollectionViewItemFlowLayoutInfoProtocol;

@interface BUKCollectionViewFlowLayoutItem : BUKCollectionViewItem

@property (nonatomic) id<BUKCollectionViewItemFlowLayoutInfoProtocol> itemFlowLayoutInfo;

@end
