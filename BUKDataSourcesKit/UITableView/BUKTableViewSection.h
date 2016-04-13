//
//  BUKTableViewSection.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

@import Foundation;


@class BUKTableViewRow;

@interface BUKTableViewSection : NSObject

@property (nonatomic) NSArray<BUKTableViewRow *> *rows;

@end
