//
//  BUKCollectionViewSection.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKCollectionViewSection.h"
#import "BUKCollectionViewSectionProtocol.h"

@implementation BUKCollectionViewSection

#pragma mark - Class Methods

+ (instancetype)section {
    return [[self alloc] init];
}


+ (instancetype)sectionWithItems:(NSArray<__kindof BUKCollectionViewItem *> *)items {
    return [[self alloc] initWithItems:items];
}


+ (instancetype)sectionWithItems:(NSArray<__kindof BUKCollectionViewItem *> *)items cellFactory:(id<BUKCollectionViewCellFactoryProtocol>)cellFactory supplementaryViewFactory:(id<BUKCollectionViewSupplementaryViewFactoryProtocol>)supplementaryViewFactory {
    return [[self alloc] initWithItems:items cellFactory:cellFactory supplementaryViewFactory:supplementaryViewFactory];
}


#pragma mark - Initializer

- (instancetype)initWithItems:(NSArray<__kindof BUKCollectionViewItem *> *)items cellFactory:(id<BUKCollectionViewCellFactoryProtocol>)cellFactory supplementaryViewFactory:(id<BUKCollectionViewSupplementaryViewFactoryProtocol>)supplementaryViewFactory {
    if ((self = [super init])) {
        _items = [items copy];
        _cellFactory = cellFactory;
        _supplementaryViewFactory = supplementaryViewFactory;
    }

    return self;
}


- (instancetype)initWithItems:(NSArray<BUKCollectionViewItem *> *)items {
    return [self initWithItems:items cellFactory:nil supplementaryViewFactory:nil];
}


- (instancetype)init {
    return [self initWithItems:nil];
}


#pragma mark - Public

- (BUKCollectionViewItem *)itemAtIndex:(NSInteger)index {
    if (0 <= index && index < self.items.count) {
        return self.items[index];
    }

    NSAssert1(NO, @"Invalid index: %ld in section", (long)index);
    return nil;
}

#pragma mark - Dynamics
// dynamics
- (void)insertItem:(BUKCollectionViewItem *)item index:(NSInteger)index
{
    if (index < 0 || index > self.items.count || !item) {
        return;
    }
    NSMutableArray *items = [[NSMutableArray alloc] initWithArray:self.items?:@[]];
    [items insertObject:item atIndex:index];
    _items = [items copy];
    [self reloadSection];
}

- (void)removeItemAtIndex:(NSInteger)index
{
    if (index < 0 || index >= self.items.count || !self.items.count) {
        return;
    }
    NSMutableArray *items = [[NSMutableArray alloc] initWithArray:self.items?:@[]];
    [items removeObjectAtIndex:index];
    _items = [items copy];
    [self reloadSection];
}

- (void)replaceItemsWithItems:(NSArray<__kindof BUKCollectionViewItem *> *)items
{
    _items = items;
    [self reloadSection];
}

- (void)reloadSection
{
    if ([self.modifyDelegate respondsToSelector:@selector(sectionNeedReload:)]) {
        [self.modifyDelegate sectionNeedReload:self];
    }
}
@end
