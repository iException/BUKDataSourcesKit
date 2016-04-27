//
//  BUKTableViewRowHeightInfo.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/27/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKTableViewRowHeightInfo.h"

@implementation BUKTableViewRowHeightInfo

#pragma mark - Accessors

- (void)setHeight:(CGFloat)height {
    if (height < 0.0f) {
        return;
    }

    _height = height;
}


#pragma mark - BUKTableViewRowHeightInfoProtocol

- (CGFloat)heightForRow:(BUKTableViewRow *)row atIndexPath:(NSIndexPath *)indexPath {
    return self.height;
}

@end
