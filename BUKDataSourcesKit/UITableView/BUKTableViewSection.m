//
//  BUKTableViewSection.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKTableViewSection.h"


@interface BUKTableViewSection ()

@property (nonatomic) NSMutableArray<BUKTableViewRow *> *mutableRows;

@end


@implementation BUKTableViewSection

@dynamic rows;


#pragma mark - Class Methods

+ (instancetype)section {
    return [[self alloc] init];
}


+ (instancetype)sectionWithRows:(NSArray<BUKTableViewRow *> *)rows {
    return [[self alloc] initWithRows:rows];
}


+ (instancetype)sectionWithHeaderViewFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)headerViewFactory rows:(NSArray<BUKTableViewRow *> *)rows footerViewFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)footerViewFactory {
    return [[self alloc] initWithHeaderViewFactory:headerViewFactory rows:rows footerViewFactory:footerViewFactory];
}


+ (instancetype)sectionWithHeaderViewFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)headerViewFactory rows:(NSArray<BUKTableViewRow *> *)rows footerViewFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)footerViewFactory cellFactory:(id<BUKTableViewCellFactoryProtocol>)cellFactory {
    return [[self alloc] initWithHeaderViewFactory:headerViewFactory rows:rows footerViewFactory:footerViewFactory cellFactory:cellFactory];
}


#pragma mark - Accessors

- (NSArray<BUKTableViewRow *> *)rows {
    return [self.mutableRows copy];
}


- (void)setRows:(NSArray<BUKTableViewRow *> *)rows {
    _mutableRows = [rows mutableCopy];
}


- (NSMutableArray<BUKTableViewRow *> *)mutableRows {
    if (!_mutableRows) {
        _mutableRows = [NSMutableArray new];
    }
    return _mutableRows;
}


#pragma mark - Initializer

- (instancetype)init {
    return [self initWithRows:nil];
}


- (instancetype)initWithRows:(NSArray<BUKTableViewRow *> *)rows {
    return [self initWithHeaderViewFactory:nil rows:rows footerViewFactory:nil];
}


- (instancetype)initWithHeaderViewFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)headerViewFactory rows:(NSArray<BUKTableViewRow *> *)rows footerViewFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)footerViewFactory {
    return [self initWithHeaderViewFactory:headerViewFactory rows:rows footerViewFactory:footerViewFactory cellFactory:nil];
}


- (instancetype)initWithHeaderViewFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)headerViewFactory rows:(NSArray<BUKTableViewRow *> *)rows footerViewFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)footerViewFactory cellFactory:(id<BUKTableViewCellFactoryProtocol>)cellFactory {
    if ((self = [super init])) {
        _mutableRows = [rows mutableCopy];
        _headerViewFactory = headerViewFactory;
        _footerViewFactory = footerViewFactory;
        _cellFactory = cellFactory;
    }

    return self;
}


#pragma mark - Public

- (BUKTableViewRow *)rowAtIndex:(NSInteger)index {
    if (0 <= index && index < self.rows.count) {
        return self.rows[index];
    }

    NSAssert1(NO, @"Invalid index: %ld in section", (long)index);
    return nil;
}


- (void)addRow:(BUKTableViewRow *)row {
    [self.mutableRows addObject:row];
}


- (void)insertRow:(BUKTableViewRow *)row atIndex:(NSUInteger)index {
    [self.mutableRows insertObject:row atIndex:index];
}


- (void)removeLastRow {
    [self.mutableRows removeLastObject];
}


- (void)removeRowAtIndex:(NSUInteger)index {
    [self.mutableRows removeObjectAtIndex:index];
}


- (void)replaceRowAtIndex:(NSUInteger)index withRow:(BUKTableViewRow *)row {
    [self.mutableRows replaceObjectAtIndex:index withObject:row];
}

@end
