//
//  BUKTableViewRow.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

@import Foundation;


@protocol BUKTableViewCellFactoryProtocol;

@interface BUKTableViewRow : NSObject

typedef void (^BUKTableViewRowSelectionHandler)(BUKTableViewRow *row, UITableView *tableView, NSIndexPath *indexPath);

@property (nonatomic) id<BUKTableViewCellFactoryProtocol> cellFactory;
@property (nonatomic) id object;
@property (nonatomic, copy) BUKTableViewRowSelectionHandler selection;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithObject:(id)object cellFactory:(id<BUKTableViewCellFactoryProtocol>)cellFactory selection:(BUKTableViewRowSelectionHandler)selection NS_DESIGNATED_INITIALIZER;

@end
