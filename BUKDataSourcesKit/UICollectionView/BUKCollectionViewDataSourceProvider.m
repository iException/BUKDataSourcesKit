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
#import "BUKCollectionViewSelectionProtocol.h"
#import "BUKCollectionViewDisplayProtocol.h"


@interface BUKCollectionViewDataSourceProvider ()

@property (nonatomic, readonly) NSMutableSet<NSString *> *registeredCellIdentifiers;
@property (nonatomic, readonly) NSMutableSet<NSString *> *registeredSupplementaryViewIdentifiers;

@end


@implementation BUKCollectionViewDataSourceProvider

#pragma mark - Class Methods

+ (instancetype)provider {
    return [[self alloc] init];
}


+ (instancetype)providerWithCollectionView:(UICollectionView *)collectionView {
    return [[self alloc] initWithCollectionView:collectionView];
}


+ (instancetype)providerWithCollectionView:(UICollectionView *)collectionView sections:(NSArray<__kindof BUKCollectionViewSection *> *)sections {
    return [[self alloc] initWithCollectionView:collectionView sections:sections];
}


+ (instancetype)providerWithCollectionView:(UICollectionView *)collectionView sections:(NSArray<__kindof BUKCollectionViewSection *> *)sections cellFactory:(id<BUKCollectionViewCellFactoryProtocol>)cellFactory supplementaryViewFactory:(id<BUKCollectionViewSupplementaryViewFactoryProtocol>)supplementaryViewFactory {
    return [[self alloc] initWithCollectionView:collectionView sections:sections cellFactory:cellFactory supplementaryViewFactory:supplementaryViewFactory];
}


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

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView sections:(NSArray<__kindof BUKCollectionViewSection *> *)sections cellFactory:(id<BUKCollectionViewCellFactoryProtocol>)cellFactory supplementaryViewFactory:(id<BUKCollectionViewSupplementaryViewFactoryProtocol>)supplementaryViewFactory {
    if ((self = [super init])) {
        _automaticallyDeselectItems = YES;
        _automaticallyRegisterCells = YES;
        _automaticallyRegisterSupplementaryViews = YES;
        _collectionView = collectionView;
        _sections = sections;
        _cellFactory = cellFactory;
        _supplementaryViewFactory = supplementaryViewFactory;
        [self updateCollectionView];
    }
    return self;
}

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView sections:(NSArray<BUKCollectionViewSection *> *)sections {
    return [self initWithCollectionView:collectionView sections:sections cellFactory:nil supplementaryViewFactory:nil];
}


- (instancetype)initWithCollectionView:(UICollectionView *)collectionView {
    return [self initWithCollectionView:collectionView sections:nil];
}


- (instancetype)init {
    return [self initWithCollectionView:nil];
}


#pragma mark - Public

- (void)refresh {
    [self refreshRegisteredCellIdentifiers];
    [self refreshRegisteredSupplementaryViewIdentifiers];
    [self refreshCollectionSections];
}


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


#pragma mark - Private

- (void)updateCollectionView {
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self refresh];
}


- (void)refreshRegisteredCellIdentifiers {
    if (!self.automaticallyRegisterCells) {
        return;
    }

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
    if (!self.automaticallyRegisterSupplementaryViews) {
        return;
    }

    [self.sections enumerateObjectsUsingBlock:^(BUKCollectionViewSection * _Nonnull section, NSUInteger i, BOOL * _Nonnull stop) {
        // Should try to register supplementary view for every section even if there's no items in the section.
        // e.g. A flow layout section has a section header and no items.
        [self registerSupplementaryViewIfNecessary:[self supplementaryViewFactoryForItem:nil inSection:section] item:nil indexPath:[NSIndexPath indexPathWithIndex:0]];

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


- (id<BUKCollectionViewSelectionProtocol>)itemSelectionForItem:(BUKCollectionViewItem *)item inSection:(BUKCollectionViewSection *)section {
    if (item.selection) {
        return item.selection;
    }
    if (section.itemSelection) {
        return section.itemSelection;
    }
    return self.itemSelection;
}


- (id<BUKCollectionViewSelectionProtocol>)itemSelectionForItemAtIndexPath:(NSIndexPath *)indexPath {
    BUKCollectionViewSection *section = [self sectionAtIndex:indexPath.section];
    BUKCollectionViewItem *item = [section itemAtIndex:indexPath.item];
    return [self itemSelectionForItem:item inSection:section];
}

- (id<BUKCollectionViewDisplayProtocol>)itemDisplayForItem:(BUKCollectionViewItem *)item inSection:(BUKCollectionViewSection *)section {
    if (item.display) {
        return item.display;
    }
    if (section.itemDisplay) {
        return section.itemDisplay;
    }
    return self.itemDisplay;
}

- (id<BUKCollectionViewDisplayProtocol>)itemDisplayForItemAtIndexPath:(NSIndexPath *)indexPath {
    BUKCollectionViewSection *section = [self sectionAtIndex:indexPath.section];
    BUKCollectionViewItem *item = [section itemAtIndex:indexPath.item];
    return [self itemDisplayForItem:item inSection:section];
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

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    id<BUKCollectionViewDisplayProtocol> display = [self itemDisplayForItemAtIndexPath:indexPath];
    BUKCollectionViewItem *item = [self itemAtIndexPath:indexPath];
    if ([display respondsToSelector:@selector(collectionView:willDisplayCell:withModelItem:forItemAtIndexPath:)]) {
        [display collectionView:collectionView willDisplayCell:cell withModelItem:item forItemAtIndexPath:indexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    id<BUKCollectionViewDisplayProtocol> display = [self itemDisplayForItemAtIndexPath:indexPath];
    BUKCollectionViewItem *item = [self itemAtIndexPath:indexPath];
    if ([display respondsToSelector:@selector(collectionView:didEndDisplayingCell:withModelItem:forItemAtIndexPath:)]) {
        [display collectionView:collectionView didEndDisplayingCell:cell withModelItem:item forItemAtIndexPath:indexPath];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    BUKCollectionViewSection *section = [self sectionAtIndex:indexPath.section];
    BUKCollectionViewItem *item = nil;
    if (section.items.count > 0) {
        item = [self itemAtIndexPath:indexPath];
    }
    id<BUKCollectionViewSupplementaryViewFactoryProtocol> supplementaryViewFactory = [self supplementaryViewFactoryForItem:item inSection:section];
    NSAssert(supplementaryViewFactory != nil, @"Supplementary view factory must exist!!!");
    NSString *reuseIdentifier = [supplementaryViewFactory reuseIdentifierForItem:item kind:kind atIndexPath:indexPath];
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [supplementaryViewFactory configureSupplementaryView:view item:item kind:kind inCollectionView:collectionView atIndexPath:indexPath];
    return view;
}


#pragma mark - UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    id<BUKCollectionViewSelectionProtocol> selection = [self itemSelectionForItemAtIndexPath:indexPath];
    if ([selection respondsToSelector:@selector(collectionView:shouldHighlightItem:atIndexPath:)]) {
        return [selection collectionView:collectionView shouldHighlightItem:[self itemAtIndexPath:indexPath] atIndexPath:indexPath];
    } else {
        return YES;
    }
}


- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    id<BUKCollectionViewSelectionProtocol> selection = [self itemSelectionForItemAtIndexPath:indexPath];
    if ([selection respondsToSelector:@selector(collectionView:didHighlightItem:atIndexPath:)]) {
        [selection collectionView:collectionView didHighlightItem:[self itemAtIndexPath:indexPath] atIndexPath:indexPath];
    }
}


- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    id<BUKCollectionViewSelectionProtocol> selection = [self itemSelectionForItemAtIndexPath:indexPath];
    if ([selection respondsToSelector:@selector(collectionView:didUnhighlightItem:atIndexPath:)]) {
        [selection collectionView:collectionView didUnhighlightItem:[self itemAtIndexPath:indexPath] atIndexPath:indexPath];
    }
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    id<BUKCollectionViewSelectionProtocol> selection = [self itemSelectionForItemAtIndexPath:indexPath];
    if ([selection respondsToSelector:@selector(collectionView:shouldSelectItem:atIndexPath:)]) {
        return [selection collectionView:collectionView shouldSelectItem:[self itemAtIndexPath:indexPath] atIndexPath:indexPath];
    } else {
        return YES;
    }
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    id<BUKCollectionViewSelectionProtocol> selection = [self itemSelectionForItemAtIndexPath:indexPath];
    if ([selection respondsToSelector:@selector(collectionView:shouldDeselectItem:atIndexPath:)]) {
        return [selection collectionView:collectionView shouldDeselectItem:[self itemAtIndexPath:indexPath] atIndexPath:indexPath];
    } else {
        return YES;
    }
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.automaticallyDeselectItems) {
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    }

    id<BUKCollectionViewSelectionProtocol> selection = [self itemSelectionForItemAtIndexPath:indexPath];
    if ([selection respondsToSelector:@selector(collectionView:didSelectItem:atIndexPath:)]) {
        [selection collectionView:collectionView didSelectItem:[self itemAtIndexPath:indexPath] atIndexPath:indexPath];
    }
}


- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    id<BUKCollectionViewSelectionProtocol> selection = [self itemSelectionForItemAtIndexPath:indexPath];
    if ([selection respondsToSelector:@selector(collectionView:didDeselectItem:atIndexPath:)]) {
        [selection collectionView:collectionView didDeselectItem:[self itemAtIndexPath:indexPath] atIndexPath:indexPath];
    }
}

@end
