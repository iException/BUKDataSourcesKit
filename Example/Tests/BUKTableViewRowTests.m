//
//  BUKDataSourcesKitTests.m
//  BUKDataSourcesKitTests
//
//  Created by Yiming Tang on 12/15/2015.
//  Copyright (c) 2015 Yiming Tang. All rights reserved.
//

SpecBegin(BUKTableViewRow)

describe(@"initializer", ^{
    it(@"should return an instance with properties set correctly", ^{
        id object = [NSObject new];
        id<BUKTableViewCellFactoryProtocol> cellFactory = OCMProtocolMock(@protocol(BUKTableViewCellFactoryProtocol));
        id<BUKTableViewSelectionProtocol> selection = OCMProtocolMock(@protocol(BUKTableViewSelectionProtocol));
        BUKTableViewRow *row = [[BUKTableViewRow alloc] initWithObject:object cellFactory:cellFactory selection:selection];

        expect(row.cellFactory).notTo.beNil();
        expect(row.selection).notTo.beNil();
        expect(row.object).notTo.beNil();
    });
});

SpecEnd
