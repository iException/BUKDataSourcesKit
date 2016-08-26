//
//  BUKCollectionViewSectionProtocol.h
//  Pods
//
//  Created by Monzy Zhang on 26/08/2016.
//
//

@import UIKit;


@class BUKCollectionViewSection;

@protocol BUKCollectionViewSectionProtocol <NSObject>

@optional
- (void)section:(BUKCollectionViewSection *)section needReloadAtRange:(NSRange)indexRange;
- (void)sectionNeedReload:(BUKCollectionViewSection *)section;

@end
