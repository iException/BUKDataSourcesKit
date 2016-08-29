//
//  BUKCollectionViewSection.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKCollectionViewSection.h"

@interface BUKCollectionViewSection ()

@property (nonatomic, strong) NSMutableArray<__kindof BUKCollectionViewItem *> *mutableItems;

@end

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
        _mutableItems = [[NSMutableArray alloc] initWithArray:[items copy]];
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
- (void)insertItem:(BUKCollectionViewItem *)item atIndex:(NSInteger)index
{
    if (index < 0 || index > self.items.count || !item) {
        return;
    }
    [self.mutableItems insertObject:item atIndex:index];
}

- (void)removeItemAtIndex:(NSInteger)index
{
    if (index < 0 || index >= self.items.count || !self.items.count) {
        return;
    }
    [self.mutableItems removeObjectAtIndex:index];
}

#pragma mark - setters
- (void)setItems:(NSArray<__kindof BUKCollectionViewItem *> *)items
{
    _mutableItems = [[NSMutableArray alloc] initWithArray:items];
}

#pragma mark - getters
- (NSArray<BUKCollectionViewItem *> *)items
{
    return _mutableItems;
}
@end
