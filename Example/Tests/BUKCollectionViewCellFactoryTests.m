//
//  BUKCollectionViewCellFactoryTests.m
//  BUKDataSourcesKit
//
//  Created by Monzy Zhang on 30/08/2016.
//  Copyright © 2016 Yiming Tang. All rights reserved.
//

#import "BUKDemoSubtitleCollectionViewCell.h"

SpecBegin(BUKCollectionViewCellFactoryTests)

__block BUKCollectionViewCellFactory *cellFactory;

beforeAll(^{
    cellFactory = [[BUKCollectionViewCellFactory alloc] initWithCellClass:[BUKDemoSubtitleCollectionViewCell class] configurator:^(__kindof BUKDemoSubtitleCollectionViewCell *cell, BUKCollectionViewItem *item, UICollectionView *collectionView, NSIndexPath *indexPath) {
        cell.titleLabel.text = item.object;
        cell.subtitleLabel.text = [NSString stringWithFormat:@"item: %ld - %ld", (long)indexPath.section, (long)indexPath.item];
    }];
});

it(@"should has correct properties", ^{
    expect(cellFactory.cellClass).to.equal([BUKDemoSubtitleCollectionViewCell class]);
    expect(cellFactory.reuseIdentifier).to.equal(NSStringFromClass([BUKDemoSubtitleCollectionViewCell class]));
    expect(cellFactory.cellConfigurator).notTo.beNil();
});

describe(@"BUKCollectionViewCellFactoryProtocol", ^{

    it(@"should return correct cell class", ^{
        BUKCollectionViewItem *item = [BUKCollectionViewItem item];
        Class cellClass = [cellFactory cellClassForItem:item atIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

        expect(cellClass).to.equal([BUKDemoSubtitleCollectionViewCell class]);
    });

    it(@"should return correct cell reuse identifier", ^{
        NSString *reuseIdentifier = [cellFactory reuseIdentifierForItem:[BUKCollectionViewItem item] atIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

        expect(reuseIdentifier).to.equal(NSStringFromClass([BUKDemoSubtitleCollectionViewCell class]));
    });

    it(@"should configure cell correctly", ^{
        BUKDemoSubtitleCollectionViewCell *cell = [[BUKDemoSubtitleCollectionViewCell alloc] init];
        BUKCollectionViewItem *item = OCMClassMock([BUKCollectionViewItem class]);
        OCMStub(item.object).andReturn(@"test");

        [cellFactory configureCell:cell withItem:item inCollectionView:[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]] atIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

        expect(cell.titleLabel.text).to.equal(@"test");
        expect(cell.subtitleLabel.text).to.equal(@"item: 0 - 0");
    });
});

afterAll(^{
    cellFactory = nil;
});

SpecEnd
