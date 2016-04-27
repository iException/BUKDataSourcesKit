//
//  BUKCollectionViewCellFactory.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/22/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKCollectionViewCellFactory.h"


@implementation BUKCollectionViewCellFactory

#pragma mark - Class Methods

+ (instancetype)factoryWithCellClass:(Class)cellClass configurator:(BUKCollectionViewCellConfigurationHandler)configurator {
    return [[self alloc] initWithCellClass:cellClass configurator:configurator];
}


#pragma mark - Initializer

- (instancetype)initWithCellClass:(Class)cellClass configurator:(BUKCollectionViewCellConfigurationHandler)configurator {
    NSParameterAssert([cellClass isSubclassOfClass:[UICollectionViewCell class]]);

    if ((self = [super init])) {
        _cellClass = cellClass;
        _reuseIdentifier = NSStringFromClass(cellClass);
        _cellConfigurator = [configurator copy];
    }

    return self;
}


#pragma mark - BUKCollectionViewCellFactoryProtocol

- (Class)cellClassForItem:(BUKCollectionViewItem *)item atIndexPath:(NSIndexPath *)indexPath {
    return self.cellClass;
}


- (NSString *)reuseIdentifierForItem:(BUKCollectionViewItem *)item atIndexPath:(NSIndexPath *)indexPath {
    return self.reuseIdentifier;
}


- (void)configureCell:(__kindof UICollectionViewCell *)cell withItem:(BUKCollectionViewItem *)item inCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    if (self.cellConfigurator) {
        self.cellConfigurator(cell, item, collectionView, indexPath);
    }
}

@end
