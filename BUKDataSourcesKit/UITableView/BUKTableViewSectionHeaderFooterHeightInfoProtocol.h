//
//  BUKTableViewSectionHeaderFooterHeightInfoProtocol.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/27/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

@import UIKit;


@class BUKTableViewSection;

@protocol BUKTableViewSectionHeaderFooterHeightInfoProtocol <NSObject>

@required
- (CGFloat)headerFooterHeightForSection:(BUKTableViewSection *)section atIndex:(NSInteger)index;

@end
