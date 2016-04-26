//
//  BUKTableViewSelection.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/26/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKTableViewSelectionProtocol.h"


typedef void (^BUKTableViewSelectionHandler)(UITableView *tableView, BUKTableViewRow *row, NSIndexPath *indexPath);


@interface BUKTableViewSelection : NSObject <BUKTableViewSelectionProtocol>

@property (nonatomic, copy) BUKTableViewSelectionHandler selectionHandler;
@property (nonatomic, readonly) BOOL isSelectable;

+ (instancetype)selection;
+ (instancetype)selectionWithHandler:(BUKTableViewSelectionHandler)selectionHandler;

- (instancetype)initWithSelectionHandler:(BUKTableViewSelectionHandler)selectionHandler NS_DESIGNATED_INITIALIZER;

@end
