//
//  BUKCollectionViewSelection.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/26/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKCollectionViewSelection.h"


@implementation BUKCollectionViewSelection

#pragma mark - Class Methods

+ (instancetype)selectionWithSelectionHandler:(BUKCollectionViewSelectionHandler)selectionHandler deselectionHandler:(BUKCollectionViewSelectionHandler)deselectionHandler {
    return [[self alloc] initWithSelectionHandler:selectionHandler deselectionHandler:deselectionHandler];
}


#pragma mark - Accessors

- (BOOL)isSelectable {
    return self.selectionHandler != nil;
}


#pragma mark - Initializer

- (instancetype)initWithSelectionHandler:(BUKCollectionViewSelectionHandler)selectionHandler deselectionHandler:(BUKCollectionViewSelectionHandler)deselectionHandler {
    if ((self = [super init])) {
        _selectionHandler = [selectionHandler copy];
        _deselectionHandler = [deselectionHandler copy];
    }
    return self;
}


#pragma mark - BUKCollectionViewSelectionProtocol

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItem:(BUKCollectionViewItem *)item atIndexPath:(NSIndexPath *)indexPath {
    return self.isSelectable;
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItem:(BUKCollectionViewItem *)item atIndexPath:(NSIndexPath *)indexPath {
    return self.isSelectable;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItem:(BUKCollectionViewItem *)item atIndexPath:(NSIndexPath *)indexPath {
    if (self.selectionHandler) {
        self.selectionHandler(collectionView, item, indexPath);
    }
}


- (void)collectionView:(UICollectionView *)collectionView didDeselectItem:(BUKCollectionViewItem *)item atIndexPath:(NSIndexPath *)indexPath {
    if (self.deselectionHandler) {
        self.deselectionHandler(collectionView, item, indexPath);
    }
}

@end
