//
//  BUKTableViewCellFactoryTests.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 5/12/16.
//  Copyright © 2016 Yiming Tang. All rights reserved.
//


SpecBegin(BUKTableViewCellFactory)

describe(@"BUKTableViewCellFactory", ^{

    __block BUKTableViewCellFactory *cellFactory;

    beforeAll(^{
       cellFactory = [[BUKTableViewCellFactory alloc] initWithCellClass:[UITableViewCell class] configurator:^(__kindof UITableViewCell *cell, BUKTableViewRow *row, UITableView *tableView, NSIndexPath *indexPath) {
           cell.textLabel.text = row.object;
           cell.detailTextLabel.text = [NSString stringWithFormat:@"row: %ld - %ld", (long)indexPath.section, (long)indexPath.row];
       }];
    });

    it(@"should has correct properties", ^{
        expect(cellFactory.cellClass).to.equal([UITableViewCell class]);
        expect(cellFactory.reuseIdentifier).to.equal(@"UITableViewCell");
        expect(cellFactory.cellConfigurator).notTo.beNil();
    });

    describe(@"BUKTableViewCellFactoryProtocol", ^{

        it(@"should return correct cell class", ^{
            BUKTableViewRow *row = [BUKTableViewRow row];
            Class cellClass = [cellFactory cellClassForRow:row atIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            expect(cellClass).to.equal([UITableViewCell class]);
        });

        it(@"should return correct cell reuse identifier", ^{
            NSString *reuseIdentifier = [cellFactory reuseIdentifierForRow:[BUKTableViewRow row] atIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            expect(reuseIdentifier).to.equal(@"UITableViewCell");
        });

        it(@"should configure cell correctly", ^{
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
            BUKTableViewRow *row = OCMClassMock([BUKTableViewRow class]);
            OCMStub(row.object).andReturn(@"test");

            [cellFactory configureCell:cell withRow:row inTableView:[UITableView new] atIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
            expect(cell.textLabel.text).to.equal(@"test");
            expect(cell.detailTextLabel.text).to.equal(@"row: 1 - 0");
        });
    });

    afterAll(^{
        cellFactory = nil;
    });
});

SpecEnd
