//
//  BUKTableViewSelection.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/26/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKTableViewSelection.h"


@implementation BUKTableViewSelection

#pragma mark - Class Methods

+ (instancetype)selectionWithSelectionHandler:(BUKTableViewSelectionHandler)selectionHandler deselectionHandler:(BUKTableViewSelectionHandler)deselectionHandler {
    return [[self alloc] initWithSelectionHandler:selectionHandler deselectionHandler:deselectionHandler];
}


#pragma mark - Accessors

- (BOOL)isSelectable {
    return self.selectionHandler != nil;
}


#pragma mark - Initializer

- (instancetype)initWithSelectionHandler:(BUKTableViewSelectionHandler)selectionHandler deselectionHandler:(BUKTableViewSelectionHandler)deselectionHandler {
    if ((self = [super init])) {
        _selectionHandler = [selectionHandler copy];
        _deselectionHandler = [deselectionHandler copy];
    }

    return self;
}


#pragma mark - BUKTableViewSelectionProtocol

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRow:(BUKTableViewRow *)row atIndexPath:(NSIndexPath *)indexPath {
    return self.isSelectable;
}


- (void)tableView:(UITableView *)tableView didSelectRow:(BUKTableViewRow *)row atIndexPath:(NSIndexPath *)indexPath {
    if (self.selectionHandler) {
        self.selectionHandler(tableView, row, indexPath);
    }
}


- (void)tableView:(UITableView *)tableView didDeselectRow:(BUKTableViewRow *)row atIndexPath:(NSIndexPath *)indexPath {
    if (self.deselectionHandler) {
        self.deselectionHandler(tableView, row, indexPath);
    }
}

@end
