//
//  BUKCollectionViewDataSourceProvider.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKCollectionViewDataSourceProvider.h"
#import "BUKCollectionViewSection.h"
#import "BUKCollectionViewItem.h"
#import "BUKCollectionViewCellFactory.h"
#import "BUKCollectionViewSupplementaryViewFactory.h"


@interface BUKCollectionViewDataSourceProvider ()

@property (nonatomic, readonly) NSMutableSet<NSString *> *registeredCellIdentifiers;
@property (nonatomic, readonly) NSMutableSet<NSString *> *registeredSupplementaryViewIdentifiers;

@end


@implementation BUKCollectionViewDataSourceProvider

#pragma mark - Accessors

@synthesize registeredCellIdentifiers = _registeredCellIdentifiers;
@synthesize registeredSupplementaryViewIdentifiers = _registeredSupplementaryViewIdentifiers;

- (NSMutableSet<NSString *> *)registeredCellIdentifiers {
    if (!_registeredCellIdentifiers) {
        _registeredCellIdentifiers = [[NSMutableSet alloc] init];
    }
    return _registeredCellIdentifiers;
}


- (NSMutableSet<NSString *> *)registeredSupplementaryViewIdentifiers {
    if (!_registeredSupplementaryViewIdentifiers) {
        _registeredSupplementaryViewIdentifiers = [[NSMutableSet alloc] init];
    }
    return _registeredSupplementaryViewIdentifiers;
}


#pragma mark - Initializer

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView sections:(NSArray<BUKCollectionViewSection *> *)sections {
    if ((self = [super init])) {
        _collectionView = collectionView;
        _sections = sections;
    }

    return self;
}


- (instancetype)initWithCollectionView:(UICollectionView *)collectionView {
    return [self initWithCollectionView:collectionView sections:nil];
}


#pragma mark - Private

- (BUKCollectionViewItem *)itemAtIndexPath:(NSIndexPath *)indexPath {
    return self.sections[indexPath.section].items[indexPath.item];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sections.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sections[section].items.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BUKCollectionViewItem *item = [self itemAtIndexPath:indexPath];
    id<BUKCollectionViewCellFactoryProtocol> cellFactory = item.cellFactory;
    if (cellFactory) {
        NSString *reuseIdentifier = [cellFactory reuseIdentifierForItem:item atIndexPath:indexPath];
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        [cellFactory configureCell:cell withItem:item inCollectionView:collectionView atIndexPath:indexPath];
        return cell;
    }

    return nil;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    BUKCollectionViewItem *item = [self itemAtIndexPath:indexPath];
    id<BUKCollectionViewSupplementaryViewFactoryProtocol> supplementaryViewFactory = item.supplementaryViewFactory;
    if (supplementaryViewFactory) {
        NSString *reuseIdentifier = [supplementaryViewFactory reuseIdentifierForItem:item kind:kind atIndexPath:indexPath];
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        [supplementaryViewFactory configureSupplementaryView:view item:item kind:kind inCollectionView:collectionView atIndexPath:indexPath];
        return view;
    }

    return nil;
}


#pragma mark - UICollectionViewDelegate


@end
