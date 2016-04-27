//
//  BUKTableViewRowHeightInfoProtocol.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/27/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

@import UIKit;


@class BUKTableViewRow;

@protocol BUKTableViewRowHeightInfoProtocol <NSObject>

@required
- (CGFloat)heightForRow:(BUKTableViewRow *)row atIndexPath:(NSIndexPath *)indexPath;

@end
