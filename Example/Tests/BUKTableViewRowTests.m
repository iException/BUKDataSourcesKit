//
//  BUKDataSourcesKitTests.m
//  BUKDataSourcesKitTests
//
//  Created by Yiming Tang on 12/15/2015.
//  Copyright (c) 2015 Yiming Tang. All rights reserved.
//

SpecBegin(BUKTableViewRow)

describe(@"initializer", ^{

    it(@"should have correct default properties", ^{
        BUKTableViewRow *row = [[BUKTableViewRow alloc] init];

        expect(row.object).to.beNil();
        expect(row.selection).to.beNil();
        expect(row.cellFactory).to.beNil();
    });

    it(@"should own the object when an object is provided", ^{
        id object = [NSObject new];
        BUKTableViewRow *row = [[BUKTableViewRow alloc] initWithObject:object];

        expect(row.object).to.equal(object);
    });

    it(@"should have properties set correctly when they are all provided", ^{
        id object = [NSObject new];
        id<BUKTableViewCellFactoryProtocol> cellFactory = OCMProtocolMock(@protocol(BUKTableViewCellFactoryProtocol));
        id<BUKTableViewSelectionProtocol> selection = OCMProtocolMock(@protocol(BUKTableViewSelectionProtocol));
        BUKTableViewRow *row = [[BUKTableViewRow alloc] initWithObject:object cellFactory:cellFactory selection:selection];

        expect(row.object).to.equal(object);
        expect(row.selection).to.equal(selection);
        expect(row.cellFactory).to.equal(cellFactory);
    });
});

describe(@"creation", ^{

    it(@"should create an instance with default properties", ^{
        BUKTableViewRow *row = [BUKTableViewRow row];

        expect(row.object).to.beNil();
        expect(row.selection).to.beNil();
        expect(row.cellFactory).to.beNil();
    });

    it(@"should create an instance with correct properties", ^{
        id object = [NSObject new];
        id<BUKTableViewCellFactoryProtocol> cellFactory = OCMProtocolMock(@protocol(BUKTableViewCellFactoryProtocol));
        id<BUKTableViewSelectionProtocol> selection = OCMProtocolMock(@protocol(BUKTableViewSelectionProtocol));
        BUKTableViewRow *row = [BUKTableViewRow rowWithObject:object cellFactory:cellFactory selection:selection];

        expect(row.object).to.equal(object);
        expect(row.selection).to.equal(selection);
        expect(row.cellFactory).to.equal(cellFactory);
    });

    it(@"should create an instance with an object", ^{
        id object = [NSObject new];
        BUKTableViewRow *row = [BUKTableViewRow rowWithObject:object];

        expect(row.object).to.equal(object);
    });

});

SpecEnd
