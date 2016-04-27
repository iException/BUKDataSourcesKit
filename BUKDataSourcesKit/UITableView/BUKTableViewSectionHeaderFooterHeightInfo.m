//
//  BUKTableViewSectionHeaderFooterHeightInfo.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/27/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKTableViewSectionHeaderFooterHeightInfo.h"


@implementation BUKTableViewSectionHeaderFooterHeightInfo

#pragma mark - Accessors

- (void)setHeight:(CGFloat)height {
    if (height < 0.0f) {
        return;
    }

    _height = height;
}


#pragma mark - BUKTableViewSectionHeaderFooterHeightInfoProtocol

- (CGFloat)headerFooterHeightForSection:(BUKTableViewSection *)section atIndex:(NSInteger)index {
    return self.height;
}

@end
