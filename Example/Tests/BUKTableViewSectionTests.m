//
//  BUKTableViewSectionTests.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 5/11/16.
//  Copyright © 2016 Yiming Tang. All rights reserved.
//

SpecBegin(BUKTableViewSection)

describe(@"initializer", ^{

    it(@"should set default properties", ^{
        BUKTableViewSection *section = [[BUKTableViewSection alloc] init];

        expect(section.headerViewFactory).to.beNil();
        expect(section.headerHeightInfo).to.beNil();
        expect(section.footerViewFactory).to.beNil();
        expect(section.footerHeightInfo).to.beNil();
        expect(section.cellFactory).to.beNil();
        expect(section.rowHeightInfo).to.beNil();
        expect(section.rowSelection).to.beNil();
        expect(section.rows).notTo.beNil();
        expect(section.rows).to.beEmpty();
        expect(section.object).to.beNil();
    });

    it(@"should initialize properties when they are provided", ^{
        NSArray<BUKTableViewRow *> *rows = @[OCMClassMock([BUKTableViewRow class]), OCMClassMock([BUKTableViewRow class])];
        id<BUKTableViewCellFactoryProtocol> cellFactory = OCMProtocolMock(@protocol(BUKTableViewCellFactoryProtocol));
        id<BUKTableViewHeaderFooterViewFactoryProtocol> headerFactory = OCMProtocolMock(@protocol(BUKTableViewHeaderFooterViewFactoryProtocol));
        id<BUKTableViewHeaderFooterViewFactoryProtocol> footerFactory = OCMProtocolMock(@protocol(BUKTableViewHeaderFooterViewFactoryProtocol));
        BUKTableViewSection *section = [[BUKTableViewSection alloc] initWithHeaderViewFactory:headerFactory rows:rows footerViewFactory:footerFactory cellFactory:cellFactory];

        expect(section.rows).to.haveACountOf(2);
        expect(section.headerViewFactory).to.equal(headerFactory);
        expect(section.footerViewFactory).to.equal(footerFactory);
        expect(section.cellFactory).to.equal(cellFactory);
    });

});


describe(@"rows", ^{

    __block BUKTableViewSection *section;

    describe(@"accessors", ^{

        beforeEach(^{
            section = [[BUKTableViewSection alloc] init];
        });

        it(@"should start with rows being empty", ^{
            expect(section.rows).notTo.beNil();
            expect(section.rows).to.beEmpty();
        });

        it(@"should set have correct count of rows after setting an array of rows", ^{
            section.rows = @[OCMClassMock([BUKTableViewRow class]), OCMClassMock([BUKTableViewRow class])];

            expect(section.rows).to.haveACountOf(2);
        });

        it(@"should be empty when given nil", ^{
            section.rows = nil;

            expect(section.rows).notTo.beNil();
            expect(section.rows).to.beEmpty();
        });

        afterEach(^{
            section = nil;
        });
    });

    describe(@"manipulation", ^{

        __block BUKTableViewRow *row0;
        __block BUKTableViewRow *row1;

        beforeAll(^{
            row0 = OCMClassMock([BUKTableViewRow class]);
            row1 = OCMClassMock([BUKTableViewRow class]);
        });

        beforeEach(^{
            section = [[BUKTableViewSection alloc] initWithRows:@[row0, row1]];
        });

        it(@"should return a row instance when index is valid", ^{
            BUKTableViewRow *row = [section rowAtIndex:0];

            expect(row).notTo.beNil();
            expect(row).to.equal(row0);
        });

        it(@"should raise an exception if index is out of bounds", ^{
            expect(^{ [section rowAtIndex:3]; }).to.raiseAny();
        });

        it(@"should increase count after adding a new row", ^{
            [section addRow:OCMClassMock([BUKTableViewRow class])];

            expect(section.rows).to.haveACountOf(3);
        });

        it(@"should decrease count after removing a row", ^{
            [section removeRowAtIndex:1];

            expect(section.rows).to.haveACountOf(1);
        });

        it(@"should raise an exception if removing a row at an out-of-bounds index", ^{
            expect(^{ [section rowAtIndex:3]; }).to.raiseAny();
        });

        it(@"should remove last row", ^{
            [section removeLastRow];

            expect(section.rows).to.haveACountOf(1);
            expect(section.rows.lastObject).toNot.equal(row1);
        });

        it(@"should replace row", ^{
            BUKTableViewRow *row = OCMClassMock([BUKTableViewRow class]);
            [section replaceRowAtIndex:0 withRow:row];

            expect(section.rows[0]).to.equal(row);
            expect(section.rows[1]).to.equal(row1);
            expect(section.rows).to.haveACountOf(2);
        });

        it(@"should inset a row", ^{
            BUKTableViewRow *row = OCMClassMock([BUKTableViewRow class]);
            [section insertRow:row atIndex:1];

            expect(section.rows[0]).to.equal(row0);
            expect(section.rows[1]).to.equal(row);
            expect(section.rows[2]).to.equal(row1);
            expect(section.rows).to.haveACountOf(3);
        });

        afterEach(^{
            section = nil;
        });

        afterAll(^{
            row0 = nil;
            row1 = nil;
        });

    });

});

SpecEnd
