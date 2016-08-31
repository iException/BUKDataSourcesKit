//
//  BUKCollectionViewItemTests.m
//  BUKDataSourcesKit
//
//  Created by Monzy Zhang on 29/08/2016.
//  Copyright © 2016 Yiming Tang. All rights reserved.
//

SpecBegin(BUKCollectionViewItemTests)

describe(@"initializer", ^{
    it(@"should return an instance with properties set correctly", ^{
        id object = [NSObject new];
        id<BUKCollectionViewSupplementaryViewFactoryProtocol> supplementaryViewFactory = OCMProtocolMock(@protocol(BUKCollectionViewSupplementaryViewFactoryProtocol));
        id<BUKCollectionViewCellFactoryProtocol> cellFactory = OCMProtocolMock(@protocol(BUKCollectionViewCellFactoryProtocol));
        id<BUKCollectionViewSelectionProtocol> selection = OCMProtocolMock(@protocol(BUKCollectionViewSelectionProtocol));

        BUKCollectionViewItem *item = [[BUKCollectionViewItem alloc] initWithObject:object cellFactory:cellFactory supplementaryViewFactory:supplementaryViewFactory selection:selection];

        expect(item.supplementaryViewFactory).notTo.beNil();
        expect(item.cellFactory).notTo.beNil();
        expect(item.selection).notTo.beNil();
        expect(item.object).notTo.beNil();
    });
});

SpecEnd
