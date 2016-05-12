//
//  BUKTableViewSelectionTests.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 5/12/16.
//  Copyright © 2016 Yiming Tang. All rights reserved.
//

SpecBegin(BUKTableViewSelection)

__block BUKTableViewSelection *selection;

beforeEach(^{
    selection = [[BUKTableViewSelection alloc] initWithSelectionHandler:nil deselectionHandler:nil];
});

describe(@"selectable", ^{

    it(@"should be selectable when it has selection handler",^{
        selection.selectionHandler = ^(UITableView *tableView, BUKTableViewRow *row, NSIndexPath *indexPath) {};
        expect(selection.isSelectable).to.beTruthy();
    });

    it(@"should not be selectable when it has no selection handler", ^{
        selection.selectionHandler = nil;
        expect(selection.isSelectable).to.beFalsy();
    });
});

describe(@"BUKTableViewSelectionProtocol", ^{

    __block BUKTableViewRow *row;
    __block NSIndexPath *indexPath;
    __block UITableView *tableView;

    beforeAll(^{
        row = [BUKTableViewRow row];
        indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        tableView = [UITableView new];
    });

    it(@"should hightlight row when it has a selection handler", ^{
        selection.selectionHandler = ^(UITableView *tableView, BUKTableViewRow *row, NSIndexPath *indexPath) {};
        BOOL result = [selection tableView:tableView shouldHighlightRow:row atIndexPath:indexPath];

        expect(result).to.beTruthy();
    });

    it(@"should not highlight row when it has no selection handler", ^{
        selection.selectionHandler = nil;
        BOOL result = [selection tableView:tableView shouldHighlightRow:row atIndexPath:indexPath];

        expect(result).to.beFalsy();
    });

    it(@"should invoke selection handler when item is selected", ^{
        __block NSInteger number = 0;
        selection.selectionHandler = ^(UITableView *tableView, BUKTableViewRow *row, NSIndexPath *indexPath) {
            number = 1;
        };

        [selection tableView:tableView didSelectRow:row atIndexPath:indexPath];

        expect(number).to.equal(1);
    });

    it(@"should invoke deselection handler when item is deselected", ^{
        __block NSInteger number = 0;
        selection.deselectionHandler = ^(UITableView *tableView, BUKTableViewRow *row, NSIndexPath *indexPath) {
            number = 1;
        };

        [selection tableView:tableView didDeselectRow:row atIndexPath:indexPath];

        expect(number).to.equal(1);
    });

    afterAll(^{
        row = nil;
        indexPath = nil;
        tableView = nil;
    });
});

afterEach(^{
    selection = nil;
});

SpecEnd
