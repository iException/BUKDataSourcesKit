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
#import "BUKCollectionViewCellFactoryProtocol.h"
#import "BUKCollectionViewSupplementaryViewFactoryProtocol.h"


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


- (void)setCollectionView:(UICollectionView *)collectionView {
    NSAssert([NSThread isMainThread], @"You must access BUKCollectionViewDataSourceProvider from the main thread.");

    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;

    [self.registeredCellIdentifiers removeAllObjects];
    [self.registeredSupplementaryViewIdentifiers removeAllObjects];

    _collectionView = collectionView;
    [self updateCollectionView];
}


- (void)setSections:(NSArray<BUKCollectionViewSection *> *)sections {
    NSAssert([NSThread isMainThread], @"You must access BUKCollectionViewDataSourceProvider from the main thread.");
    _sections = [sections copy];
    [self refresh];
}


- (void)setSupplementaryViewFactory:(id<BUKCollectionViewSupplementaryViewFactoryProtocol>)supplementaryViewFactory {
    NSAssert([NSThread isMainThread], @"You must access BUKCollectionViewDataSourceProvider from the main thread.");
    _supplementaryViewFactory = supplementaryViewFactory;
    [self refresh];
}


- (void)setCellFactory:(id<BUKCollectionViewCellFactoryProtocol>)cellFactory {
    NSAssert([NSThread isMainThread], @"You must access BUKCollectionViewDataSourceProvider from the main thread.");
    _cellFactory = cellFactory;
    [self refresh];
}


#pragma mark - Initializer

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView sections:(NSArray<BUKCollectionViewSection *> *)sections {
    if ((self = [super init])) {
        _collectionView = collectionView;
        _sections = sections;
        [self updateCollectionView];
    }

    return self;
}


- (instancetype)initWithCollectionView:(UICollectionView *)collectionView {
    return [self initWithCollectionView:collectionView sections:nil];
}


#pragma mark - Private

- (BUKCollectionViewSection *)sectionAtIndex:(NSInteger)index {
    if (self.sections.count <= index) {
        NSAssert1(NO, @"Invalid section index: %ld", (long)index);
        return nil;
    }

    return self.sections[index];
}


- (BUKCollectionViewItem *)itemAtIndexPath:(NSIndexPath *)indexPath {
    BUKCollectionViewSection *section = [self sectionAtIndex:indexPath.section];
    if (section) {
        return [section itemAtIndex:indexPath.item];
    }

    NSAssert1(NO, @"Invalid index path: %@", indexPath);
    return nil;
}


- (void)updateCollectionView {
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self refresh];
}


- (void)refresh {
    [self refreshRegisteredCellIdentifiers];
    [self refreshRegisteredSupplementaryViewIdentifiers];
    [self refreshCollectionSections];
}


- (void)refreshRegisteredCellIdentifiers {
    [self.sections enumerateObjectsUsingBlock:^(BUKCollectionViewSection * _Nonnull section, NSUInteger i, BOOL * _Nonnull stop) {
        [section.items enumerateObjectsUsingBlock:^(BUKCollectionViewItem * _Nonnull item, NSUInteger j, BOOL * _Nonnull stop) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            id<BUKCollectionViewCellFactoryProtocol> cellFactory = [self cellFactoryForItem:item inSection:section];
            [self registerCellIfNecessary:cellFactory item:item indexPath:indexPath];
        }];
    }];
}


- (void)registerCellIfNecessary:(id<BUKCollectionViewCellFactoryProtocol>)cellFactory item:(BUKCollectionViewItem *)item indexPath:(NSIndexPath *)indexPath {
    if (!cellFactory) {
        return;
    }

    NSString *reuseIdentifier = [cellFactory reuseIdentifierForItem:item atIndexPath:indexPath];
    if (!reuseIdentifier || [self.registeredCellIdentifiers containsObject:reuseIdentifier]) {
        return;
    }

    Class cellClass = [cellFactory cellClassForItem:item atIndexPath:indexPath];
    NSAssert1([cellClass isSubclassOfClass:[UICollectionViewCell class]], @"View class: %@ isn't subclass of UICollectionViewCell", NSStringFromClass(cellClass));
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:reuseIdentifier];
    [self.registeredCellIdentifiers addObject:reuseIdentifier];
}


- (id<BUKCollectionViewCellFactoryProtocol>)cellFactoryForItem:(BUKCollectionViewItem *)item inSection:(BUKCollectionViewSection *)section {
    if (item.cellFactory) {
        return item.cellFactory;
    }

    if (section.cellFactory) {
        return section.cellFactory;
    }

    return self.cellFactory;
}


- (void)refreshRegisteredSupplementaryViewIdentifiers {
    [self.sections enumerateObjectsUsingBlock:^(BUKCollectionViewSection * _Nonnull section, NSUInteger i, BOOL * _Nonnull stop) {
        [section.items enumerateObjectsUsingBlock:^(BUKCollectionViewItem * _Nonnull item, NSUInteger j, BOOL * _Nonnull stop) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            id<BUKCollectionViewSupplementaryViewFactoryProtocol> supplementaryViewFactory = [self supplementaryViewFactoryForItem:item inSection:section];
            [self registerSupplementaryViewIfNecessary:supplementaryViewFactory item:item indexPath:indexPath];
        }];
    }];
}


- (void)registerSupplementaryViewIfNecessary:(id<BUKCollectionViewSupplementaryViewFactoryProtocol>)supplementaryViewFactory item:(BUKCollectionViewItem *)item indexPath:(NSIndexPath *)indexPath {
    if (!supplementaryViewFactory) {
        return;
    }

    NSArray<NSString *> *viewKinds = [supplementaryViewFactory supplementaryViewKindsForItem:item atIndexPath:indexPath];
    if (viewKinds.count == 0) {
        return;
    }

    [viewKinds enumerateObjectsUsingBlock:^(NSString * _Nonnull kind, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *reuseIdentifier = [supplementaryViewFactory reuseIdentifierForItem:item kind:kind atIndexPath:indexPath];
        if (!reuseIdentifier) {
            return;
        }

        NSString *composedReuseIdentifier = [kind stringByAppendingFormat:@"-%@", reuseIdentifier];
        if ([self.registeredSupplementaryViewIdentifiers containsObject:composedReuseIdentifier]) {
            return;
        }

        Class supplementaryViewClass = [supplementaryViewFactory supplementaryViewClassForItem:item kind:kind atIndexPath:indexPath];
        NSAssert1([supplementaryViewClass isSubclassOfClass:[UICollectionReusableView class]], @"View class: %@ isn't subclass of UICollectionReusableView", NSStringFromClass(supplementaryViewClass));
        [self.collectionView registerClass:supplementaryViewClass forSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier];
        [self.registeredSupplementaryViewIdentifiers addObject:composedReuseIdentifier];
    }];
}


- (id<BUKCollectionViewSupplementaryViewFactoryProtocol>)supplementaryViewFactoryForItem:(BUKCollectionViewItem *)item inSection:(BUKCollectionViewSection *)section {
    if (item.supplementaryViewFactory) {
        return item.supplementaryViewFactory;
    }

    if (section.supplementaryViewFactory) {
        return section.supplementaryViewFactory;
    }

    return self.supplementaryViewFactory;
}


- (void)refreshCollectionSections {
    [self.collectionView reloadData];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sections.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self sectionAtIndex:section].items.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BUKCollectionViewSection *section = [self sectionAtIndex:indexPath.section];
    BUKCollectionViewItem *item = [self itemAtIndexPath:indexPath];
    id<BUKCollectionViewCellFactoryProtocol> cellFactory = [self cellFactoryForItem:item inSection:section];
    NSAssert(cellFactory != nil, @"Cell factory must exist!!!");
    NSString *reuseIdentifier = [cellFactory reuseIdentifierForItem:item atIndexPath:indexPath];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cellFactory configureCell:cell withItem:item inCollectionView:collectionView atIndexPath:indexPath];
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    BUKCollectionViewSection *section = [self sectionAtIndex:indexPath.section];
    BUKCollectionViewItem *item = [self itemAtIndexPath:indexPath];
    id<BUKCollectionViewSupplementaryViewFactoryProtocol> supplementaryViewFactory = [self supplementaryViewFactoryForItem:item inSection:section];
    NSAssert(supplementaryViewFactory != nil, @"Supplementary view factory must exist!!!");
    NSString *reuseIdentifier = [supplementaryViewFactory reuseIdentifierForItem:item kind:kind atIndexPath:indexPath];
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [supplementaryViewFactory configureSupplementaryView:view item:item kind:kind inCollectionView:collectionView atIndexPath:indexPath];
    return view;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}


@end
