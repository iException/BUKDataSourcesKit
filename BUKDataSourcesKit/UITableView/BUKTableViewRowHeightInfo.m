//
//  BUKTableViewRowHeightInfo.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/27/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKTableViewRowHeightInfo.h"

@interface BUKTableViewRowHeightInfo ()

@property (nonatomic) NSCache *heightCache;

@end


@implementation BUKTableViewRowHeightInfo

#pragma mark - Class Methods

+ (instancetype)heightInfoWithDefaultHeight:(CGFloat)defaultHeight calculator:(BUKTableViewRowHeightCalculator)calculator {
    return [[self alloc] initWithDefaultHeight:defaultHeight calculator:calculator];
}


#pragma mark - Accessors

- (void)setDefaultHeight:(CGFloat)defaultHeight {
    NSAssert(defaultHeight >= 0.0f, @"Default row height must be non-negtive!");
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
    return [self initWithDefaultHeight:40.0f calculator:nil];
}


- (instancetype)initWithDefaultHeight:(CGFloat)defaultHeight calculator:(BUKTableViewRowHeightCalculator)calculator {
    NSAssert(defaultHeight >= 0.0f, @"Default row height must be non-negtive!");
    if ((self = [super init])) {
        _heightCalculator = [calculator copy];
        _usesCache = NO;
        _defaultHeight = defaultHeight;
    }
    return self;
}


#pragma mark - Public

- (void)clearCache {
    [self.heightCache removeAllObjects];
}


#pragma mark - BUKTableViewRowHeightInfoProtocol

- (CGFloat)heightForRow:(BUKTableViewRow *)row atIndexPath:(NSIndexPath *)indexPath {
    if (!self.usesCache) {
        if (!self.heightCalculator) {
            return self.defaultHeight;
        }
        return self.heightCalculator(row, indexPath);
    }

    NSNumber *heightNumber = [self.heightCache objectForKey:indexPath];
    // Cached
    if (heightNumber) {
        return [heightNumber floatValue];
    }

    // Not cached
    if (self.heightCalculator) {
        CGFloat height = self.heightCalculator(row, indexPath);
        [self.heightCache setObject:@(height) forKey:indexPath];
        return height;
    }

    // Won't cache this value
    return self.defaultHeight;
}

@end
