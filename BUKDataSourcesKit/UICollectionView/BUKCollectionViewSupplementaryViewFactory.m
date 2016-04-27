//
//  BUKCollectionViewSupplementaryViewFactory.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/22/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKCollectionViewSupplementaryViewFactory.h"


@implementation BUKCollectionViewSupplementaryViewFactory

#pragma mark - Class Methods

+ (instancetype)factoryWithSupplementaryViewClass:(Class)supplementaryViewClass kind:(NSString *)kind configurator:(BUKCollectionSupplementaryViewConfigurationHandler)configurator {
    return [[self alloc] initWithSupplementaryViewClass:supplementaryViewClass kind:kind configurator:configurator];
}


#pragma mark - Initializer

- (instancetype)initWithSupplementaryViewClass:(Class)supplementaryViewClass kind:(NSString *)kind configurator:(BUKCollectionSupplementaryViewConfigurationHandler)configurator {
    NSParameterAssert([supplementaryViewClass isSubclassOfClass:[UICollectionReusableView class]]);

    if ((self = [super init])) {
        _supplementaryViewClass = supplementaryViewClass;
        _supplementaryViewKind = [kind copy];
        _reuseIdentifier = NSStringFromClass(supplementaryViewClass);
        _viewConfigurator = [configurator copy];
    }

    return self;
}


#pragma mark - BUKCollectionViewSupplementaryViewFactoryProtocol

- (NSArray<NSString *> *)supplementaryViewKindsForItem:(BUKCollectionViewItem *)item atIndexPath:(NSIndexPath *)indexPath {
    return @[self.supplementaryViewKind];
}


- (Class)supplementaryViewClassForItem:(BUKCollectionViewItem *)item kind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return self.supplementaryViewClass;
}


- (NSString *)reuseIdentifierForItem:(BUKCollectionViewItem *)item kind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return self.reuseIdentifier;
}


- (void)configureSupplementaryView:(UICollectionReusableView *)view item:(BUKCollectionViewItem *)item kind:(NSString *)kind inCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    if (self.viewConfigurator) {
        self.viewConfigurator(view, item, kind, collectionView, indexPath);
    }
}

@end
