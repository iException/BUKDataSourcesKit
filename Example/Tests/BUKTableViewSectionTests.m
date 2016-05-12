//
//  BUKTableViewSectionTests.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 5/11/16.
//  Copyright © 2016 Yiming Tang. All rights reserved.
//

SpecBegin(BUKTableViewSection)

describe(@"initializer", ^{
    it(@"should return an instance with properties set", ^{
        NSArray<BUKTableViewRow *> *rows = @[OCMClassMock([BUKTableViewRow class]), OCMClassMock([BUKTableViewRow class])];
        id<BUKTableViewCellFactoryProtocol> cellFactory = OCMProtocolMock(@protocol(BUKTableViewCellFactoryProtocol));
        id<BUKTableViewHeaderFooterViewFactoryProtocol> headerFactory = OCMProtocolMock(@protocol(BUKTableViewHeaderFooterViewFactoryProtocol));
        id<BUKTableViewHeaderFooterViewFactoryProtocol> footerFactory = OCMProtocolMock(@protocol(BUKTableViewHeaderFooterViewFactoryProtocol));
        BUKTableViewSection *section = [[BUKTableViewSection alloc] initWithHeaderViewFactory:headerFactory rows:rows footerViewFactory:footerFactory cellFactory:cellFactory];

        expect(section.rows.count).to.equal(2);
        expect(section.headerViewFactory).notTo.beNil();
        expect(section.footerViewFactory).notTo.beNil();
        expect(section.cellFactory).notTo.beNil();
    });
});

describe(@"rows", ^{

    __block BUKTableViewSection *section;

    beforeEach(^{
        section = [[BUKTableViewSection alloc] init];
    });

    it(@"should start with empty rows", ^{
        expect(section.rows).to.beNil();
    });

    it(@"should return a valid row if index is not out of bounds", ^{
        section.rows = @[OCMClassMock([BUKTableViewRow class]), OCMClassMock([BUKTableViewRow class])];
        expect([section rowAtIndex:0]).notTo.beNil();
    });

    it(@"should raise an exception if index is out of bounds", ^{
        section.rows = @[OCMClassMock([BUKTableViewRow class]), OCMClassMock([BUKTableViewRow class])];
        expect(^{ [section rowAtIndex:3]; }).to.raiseAny();
    });

    afterEach(^{
        section = nil;
    });
});

SpecEnd
