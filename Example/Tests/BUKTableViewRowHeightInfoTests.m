//
//  BUKTableViewRowHeightInfoTests.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 5/12/16.
//  Copyright © 2016 Yiming Tang. All rights reserved.
//

SpecBegin(BUKTableViewRowHeightInfo)

__block BUKTableViewRowHeightInfo *heightInfo;

beforeEach(^{
    heightInfo = [[BUKTableViewRowHeightInfo alloc] init];
});

it(@"should have correct default values", ^{
    expect(heightInfo.defaultHeight).to.equal(40.0f);
    expect(heightInfo.usesCache).to.beFalsy();
    expect(heightInfo.heightCalculator).to.beNil();
});


describe(@"height", ^{
    
    it(@"should return default height if no calculator is provided", ^{
        heightInfo.defaultHeight = 60.0f;
        CGFloat height = [heightInfo heightForRow:nil atIndexPath:nil];

        expect(height).to.equal(60.0f);
    });

    it(@"should return calculated height if calculator is provided", ^{
        heightInfo.defaultHeight = 60.0f;
        heightInfo.heightCalculator = ^CGFloat (BUKTableViewRow *row, NSIndexPath *indexPath) {
            return 40.0f;
        };

        CGFloat height = [heightInfo heightForRow:nil atIndexPath:nil];

        expect(height).to.equal(40.0f);
    });
});


describe(@"cache", ^{

    __block NSInteger number;
    __block NSIndexPath *indexPath;

    beforeEach(^{
        number = 0;
        heightInfo.heightCalculator = ^CGFloat (BUKTableViewRow *row, NSIndexPath *indexPath) {
            number++;
            return 40.0f;
        };
        indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    });

    describe(@"if enabled", ^{
        beforeEach(^{
            heightInfo.usesCache = YES;
        });

        it(@"should hit cache", ^{
            CGFloat height = [heightInfo heightForRow:nil atIndexPath:indexPath];

            expect(height).to.equal(40.0f);
            expect(number).to.equal(1);

            height = [heightInfo heightForRow:nil atIndexPath:indexPath];

            expect(height).to.equal(40.0f);
            expect(number).to.equal(1);
        });

        it(@"should not hit the cache after cache was cleared", ^{
            CGFloat height = [heightInfo heightForRow:nil atIndexPath:indexPath];
            expect(height).to.equal(40.0f);
            expect(number).to.equal(1);

            [heightInfo clearCache];

            height = [heightInfo heightForRow:nil atIndexPath:indexPath];
            expect(height).to.equal(40.0f);
            expect(number).to.equal(2);
        });
    });

    describe(@"if disabled", ^{

        beforeEach(^{
            heightInfo.usesCache = NO;
        });

        it(@"should always invoke calculator", ^{
            [heightInfo heightForRow:nil atIndexPath:indexPath];
            expect(number).to.equal(1);

            [heightInfo heightForRow:nil atIndexPath:indexPath];
            expect(number).to.equal(2);

            [heightInfo heightForRow:nil atIndexPath:indexPath];
            expect(number).to.equal(3);
        });
    });
});

afterEach(^{
    heightInfo = nil;
});


SpecEnd