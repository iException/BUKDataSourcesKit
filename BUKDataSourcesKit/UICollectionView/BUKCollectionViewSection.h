//
//  BUKCollectionViewSection.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

@import Foundation;

@class BUKCollectionViewItem;


@interface BUKCollectionViewSection : NSObject

@property (nonatomic) NSArray<BUKCollectionViewItem *> *items;

@end
