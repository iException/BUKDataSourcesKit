//
//  BUKCollectionViewDataSourceProviderDelegate.h
//  Pods
//
//  Created by Monzy Zhang on 29/08/2016.
//
//

@import UIKit;


@class BUKCollectionViewDataSourceProvider;

@protocol BUKCollectionViewDataSourceProviderDelegate <NSObject>

@optional
- (void)provider:(BUKCollectionViewDataSourceProvider *)provider didInsertSection:(BUKCollectionViewSection *)section atIndex:(NSInteger)index;
- (void)provider:(BUKCollectionViewDataSourceProvider *)provider didRemoveSectionAtIndex:(NSInteger)index;
- (void)provider:(BUKCollectionViewDataSourceProvider *)provider didInsertItem:(BUKCollectionViewItem *)item atIndexPath:(NSIndexPath *)indexPath;
- (void)provider:(BUKCollectionViewDataSourceProvider *)provider didRemoveItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)provider:(BUKCollectionViewDataSourceProvider *)provider didInsertItems:(NSArray<__kindof BUKCollectionViewItem *> *)items atIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
- (void)provider:(BUKCollectionViewDataSourceProvider *)provider didReplaceSectionAtIndex:(NSInteger)index withSection:(BUKCollectionViewSection *)section;

@end
