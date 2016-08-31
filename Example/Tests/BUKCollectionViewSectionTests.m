//
//  BUKCollectionViewSectionTests.m
//  BUKDataSourcesKit
//
//  Created by Monzy Zhang on 29/08/2016.
//  Copyright © 2016 Yiming Tang. All rights reserved.
//

SpecBegin(BUKCollectionViewSectionTests)

describe(@"initializer", ^{
    it(@"should return an instance with properties set", ^{
        NSArray<BUKCollectionViewItem *> *items = @[ OCMClassMock([BUKCollectionViewItem class]), OCMClassMock([BUKCollectionViewItem class]) ];
        id<BUKCollectionViewCellFactoryProtocol> cellFactory = OCMProtocolMock(@protocol(BUKCollectionViewCellFactoryProtocol));
        id<BUKCollectionViewSupplementaryViewFactoryProtocol> supplementaryViewFactory = OCMProtocolMock(@protocol(BUKCollectionViewSupplementaryViewFactoryProtocol));
        BUKCollectionViewSection *section = [[BUKCollectionViewSection alloc] initWithItems:items cellFactory:cellFactory supplementaryViewFactory:supplementaryViewFactory];

        expect(section.items.count).to.equal(2);
        expect(section.supplementaryViewFactory).notTo.beNil();
        expect(section.cellFactory).notTo.beNil();
    });
});

describe(@"items", ^{

    __block BUKCollectionViewSection *section;

    beforeEach(^{
        section = [BUKCollectionViewSection new];
    });

    it(@"should start with empty items", ^{
        expect(section.items.count).to.equal(0);
    });

    it(@"should return a valid item if index is not out of bounds", ^{
        section.items = @[OCMClassMock([BUKCollectionViewItem class]), OCMClassMock([BUKCollectionViewItem class])];
        expect([section itemAtIndex:0]).notTo.beNil();
    });

    it(@"should raise an exception if index is out of bounds", ^{
        section.items = @[OCMClassMock([BUKCollectionViewItem class]), OCMClassMock([BUKCollectionViewItem class])];
        expect(^{ [section itemAtIndex:3]; }).to.raiseAny();
    });

    afterEach(^{
        section = nil;
    });
});

SpecEnd
