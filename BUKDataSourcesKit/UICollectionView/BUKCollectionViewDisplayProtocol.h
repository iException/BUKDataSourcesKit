//
//  BUKCollectionViewDisplayProtocol.h
//  Pods
//
//  Created by Monzy Zhang on 03/09/2016.
//
//

@class UIKit;

@class BUKCollectionViewItem;

@protocol BUKCollectionViewDisplayProtocol <NSObject>

@optional
- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
         withModelItem:(BUKCollectionViewItem *)modelItem
    forItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView
  didEndDisplayingCell:(UICollectionViewCell *)cell
         withModelItem:(BUKCollectionViewItem *)modelItem
    forItemAtIndexPath:(NSIndexPath *)indexPath;

@end
