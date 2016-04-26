//
//  BUKTableViewSelection.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/26/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKTableViewSelection.h"


@implementation BUKTableViewSelection

#pragma mark - Accessors

- (BOOL)isSelectable {
    return self.selectionHandler != nil;
}


#pragma mark - Initializer

- (instancetype)initWithSelectionHandler:(BUKTableViewSelectionHandler)selectionHandler {
    if ((self = [super init])) {
        _selectionHandler = [selectionHandler copy];
    }

    return self;
}


#pragma mark - BUKTableViewSelectionProtocol

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRow:(BUKTableViewRow *)row atIndexPath:(NSIndexPath *)indexPath {
    return self.isSelectable;
}


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRow:(BUKTableViewRow *)row atIndexPath:(NSIndexPath *)indexPath {
    return self.isSelectable ? indexPath : nil;
}


- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRow:(BUKTableViewRow *)row atIndexPath:(NSIndexPath *)indexPath {
    return self.isSelectable ? indexPath : nil;
}


- (void)tableView:(UITableView *)tableView didSelectRow:(BUKTableViewRow *)row atIndexPath:(NSIndexPath *)indexPath {
    if (self.selectionHandler) {
        self.selectionHandler(tableView, row, indexPath);
    }
}

@end
