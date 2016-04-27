//
//  BUKCollectionViewSelection.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/26/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved. 
//

#import "BUKCollectionViewSelectionProtocol.h"


typedef void (^BUKCollectionViewSelectionHandler)(UICollectionView *collectionView, BUKCollectionViewItem *item, NSIndexPath *indexPath);


@interface BUKCollectionViewSelection : NSObject <BUKCollectionViewSelectionProtocol>

@property (nonatomic, copy) BUKCollectionViewSelectionHandler selectionHandler;
@property (nonatomic, copy) BUKCollectionViewSelectionHandler deselectionHandler;
@property (nonatomic, readonly) BOOL isSelectable;

+ (instancetype)selectionWithSelectionHandler:(BUKCollectionViewSelectionHandler)selectionHandler deselectionHandler:(BUKCollectionViewSelectionHandler)deselectionHandler;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithSelectionHandler:(BUKCollectionViewSelectionHandler)selectionHandler deselectionHandler:(BUKCollectionViewSelectionHandler)deselectionHandler NS_DESIGNATED_INITIALIZER;

@end
