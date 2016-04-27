//
//  BUKTableViewSectionHeaderFooterHeightInfo.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/27/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKTableViewSectionHeaderFooterHeightInfo.h"


@interface BUKTableViewSectionHeaderFooterHeightInfo ()

@property (nonatomic) NSCache *heightCache;

@end


@implementation BUKTableViewSectionHeaderFooterHeightInfo

#pragma mark - Class Methods

+ (instancetype)heightInfoWithDefaultHeight:(CGFloat)defaultHeight calculator:(BUKTableViewSectionHeaderFooterHeightCalculator)calculator {
    return [[self alloc] initWithDefaultHeight:defaultHeight calculator:calculator];
}


#pragma mark - Accessors

- (void)setDefaultHeight:(CGFloat)defaultHeight {
    if (defaultHeight < 0.0f) {
        return;
    }

    _defaultHeight = defaultHeight;
}


- (NSCache *)heightCache {
    if (!_heightCache) {
        _heightCache = [[NSCache alloc] init];
    }
    return _heightCache;
}


#pragma mark - Initializer

- (instancetype)init {
    return [self initWithDefaultHeight:UITableViewAutomaticDimension calculator:nil];
}


- (instancetype)initWithDefaultHeight:(CGFloat)defaultHeight calculator:(BUKTableViewSectionHeaderFooterHeightCalculator)calculator {
    if ((self = [super init])) {
        _defaultHeight = defaultHeight;
        _heightCalculator = [calculator copy];
        _usesCache = NO;
    }
    return self;
}


#pragma mark - Public

- (void)clearCache {
    [self.heightCache removeAllObjects];
}


#pragma mark - BUKTableViewSectionHeaderFooterHeightInfoProtocol

- (CGFloat)headerFooterHeightForSection:(BUKTableViewSection *)section atIndex:(NSInteger)index {
    if (!self.usesCache) {
        if (!self.heightCalculator) {
            return self.defaultHeight;
        }
        return self.heightCalculator(section, index);
    }

    NSNumber *heightNumber = [self.heightCache objectForKey:@(index)];
    // Cached
    if (heightNumber) {
        return [heightNumber floatValue];
    }

    // Not cached
    if (self.heightCalculator) {
        CGFloat height = self.heightCalculator(section, index);
        [self.heightCache setObject:@(height) forKey:@(index)];
        return height;
    }

    // Won't cache this value
    return self.defaultHeight;
}

@end
