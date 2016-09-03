//
//  BUKCollectionViewDisplay.h
//  Pods
//
//  Created by Monzy Zhang on 03/09/2016.
//
//

#import "BUKCollectionViewDisplayProtocol.h"

typedef void (^BUKCollectionViewDisplayHandler) (UICollectionView *collectionView, UICollectionViewCell *cell, BUKCollectionViewItem *item, NSIndexPath *indexPath);

@interface BUKCollectionViewDisplay : NSObject <BUKCollectionViewDisplayProtocol>

@property (nonatomic, copy) BUKCollectionViewDisplayHandler willDisplayHandler;
@property (nonatomic, copy) BUKCollectionViewDisplayHandler didEndDisplayingHandler;

+ (instancetype)displayWithWillDisplayHandler:(BUKCollectionViewDisplayHandler)willDisplayHandler
                      didEndDisplayingHandler:(BUKCollectionViewDisplayHandler)didEndDisplayingHandler;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithWillDisplayHandler:(BUKCollectionViewDisplayHandler)willDisplayHandler
                      didEndDisplayingHandler:(BUKCollectionViewDisplayHandler)didEndDisplayingHandler NS_DESIGNATED_INITIALIZER;
@end
