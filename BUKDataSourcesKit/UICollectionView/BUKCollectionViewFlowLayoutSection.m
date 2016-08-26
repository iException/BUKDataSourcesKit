//
//  BUKCollectionViewFlowLayoutSection.m
//  BUKCollectionViewSection
//
//  Created by Yiming Tang on 4/25/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKCollectionViewFlowLayoutSection.h"
#import "BUKCollectionViewFlowLayoutItem.h"

@implementation BUKCollectionViewFlowLayoutSection

#pragma mark - Accessors

@dynamic flowLayoutItems;

- (void)setFlowLayoutItems:(NSArray<BUKCollectionViewFlowLayoutItem *> *)flowLayoutItems {
    [self replaceItemsWithItems:flowLayoutItems];
}


- (NSArray<BUKCollectionViewFlowLayoutItem *> *)flowLayoutItems {
    return self.items;
}


#pragma mark - Public

- (BUKCollectionViewFlowLayoutItem *)flowLayoutItemAtIndex:(NSInteger)index {
    BUKCollectionViewFlowLayoutItem *item = [self flowLayoutItemAtIndex:index];
    if (![item isKindOfClass:[BUKCollectionViewFlowLayoutItem class]]) {
        return nil;
    }

    return item;
}

@end
