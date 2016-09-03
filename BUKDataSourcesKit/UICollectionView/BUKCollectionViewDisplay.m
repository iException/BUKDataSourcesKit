//
//  BUKCollectionViewDisplay.m
//  Pods
//
//  Created by Monzy Zhang on 03/09/2016.
//
//

#import "BUKCollectionViewDisplay.h"

@implementation BUKCollectionViewDisplay
#pragma mark - class method
+ (instancetype)displayWithWillDisplayHandler:(BUKCollectionViewDisplayHandler)willDisplayHandler
                      didEndDisplayingHandler:(BUKCollectionViewDisplayHandler)didEndDisplayingHandler
{
    return [[BUKCollectionViewDisplay alloc] initWithWillDisplayHandler:willDisplayHandler
                                                                             didEndDisplayingHandler:didEndDisplayingHandler];
}

#pragma mark - init
- (instancetype)initWithWillDisplayHandler:(BUKCollectionViewDisplayHandler)willDisplayHandler
                   didEndDisplayingHandler:(BUKCollectionViewDisplayHandler)didEndDisplayingHandler
{
    self = [super init];
    if (self) {
        _willDisplayHandler = [willDisplayHandler copy];
        _didEndDisplayingHandler = [didEndDisplayingHandler copy];
    }
    return self;
}

#pragma mark - BUKCollectionViewDisplayProtocol
- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
         withModelItem:(BUKCollectionViewItem *)modelItem
    forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.willDisplayHandler) {
        self.willDisplayHandler(collectionView, cell, modelItem, indexPath);
    }
}

- (void)collectionView:(UICollectionView *)collectionView
  didEndDisplayingCell:(UICollectionViewCell *)cell
         withModelItem:(BUKCollectionViewItem *)modelItem
    forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.didEndDisplayingHandler) {
        self.didEndDisplayingHandler(collectionView, cell, modelItem, indexPath);
    }
}

@end
