//
//  BUKCollectionViewItemFlowLayoutInfo.m
//  BUKDataSourcesKit 
//
//  Created by Yiming Tang on 4/25/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKCollectionViewItemFlowLayoutInfo.h"


@interface BUKCollectionViewItemFlowLayoutInfo ()

@property (nonatomic) NSCache *itemSizeCache;

@end


@implementation BUKCollectionViewItemFlowLayoutInfo

#pragma mark - Class Methods

+ (instancetype)layoutInfoWithDefaultItemSize:(CGSize)size calculator:(BUKCollectionViewItemSizeCalculator)calculator {
    return [[self alloc] initWithDefaultItemSize:size calculator:calculator];
}


#pragma mark - Accessors

- (void)setDefaultItemSize:(CGSize)defaultItemSize {
    NSAssert(defaultItemSize.width >= 0.0f && defaultItemSize.height >= 0.0f, @"Default item size must be non-negtive!");
    _defaultItemSize = defaultItemSize;
}


- (NSCache *)itemSizeCache {
    if (!_itemSizeCache) {
        _itemSizeCache = [[NSCache alloc] init];
    }
    return _itemSizeCache;
}


#pragma mark - Initializer

- (instancetype)init {
    return [self initWithDefaultItemSize:CGSizeMake(50.0f, 50.0f) calculator:nil];
}


- (instancetype)initWithDefaultItemSize:(CGSize)size calculator:(BUKCollectionViewItemSizeCalculator)calculator {
    NSAssert(size.width >= 0.0f && size.height >= 0.0f, @"Default item size must be non-negtive!");
    if ((self = [super init])) {
        _itemSizeCalculator = [calculator copy];
        _usesCache = NO;
        _defaultItemSize = size;
    }

    return self;
}


#pragma mark - Public

- (void)clearCache {
    [self.itemSizeCache removeAllObjects];
}


#pragma mark - BUKCollectionViewItemFlowLayoutInfoProtocol

- (CGSize)sizeForItem:(BUKCollectionViewItem *)item atIndexPath:(NSIndexPath *)indexPath inCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)layout {
    if (!self.usesCache) {
        if (!self.itemSizeCalculator) {
            return self.defaultItemSize;
        }
        return self.itemSizeCalculator(item, indexPath, collectionView, layout);
    }

    NSValue *sizeValue = [self.itemSizeCache objectForKey:indexPath];
    // Cached
    if (sizeValue) {
        return [sizeValue CGSizeValue];
    }

    // Not cached
    if (self.itemSizeCalculator) {
        CGSize size = self.itemSizeCalculator(item, indexPath, collectionView, layout);
        [self.itemSizeCache setObject:[NSValue valueWithCGSize:size] forKey:indexPath];
        return size;
    }

    // Won't cache this value
    return self.defaultItemSize;
}

@end
