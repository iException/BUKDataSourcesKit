//
//  BUKTableViewSectionHeaderFooterHeightInfoTests.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 5/12/16.
//  Copyright © 2016 Yiming Tang. All rights reserved.
//

SpecBegin(BUKTableViewSectionHeaderFooterHeightInfo)

__block BUKTableViewSectionHeaderFooterHeightInfo *heightInfo;

beforeEach(^{
    heightInfo = [[BUKTableViewSectionHeaderFooterHeightInfo alloc] init];
});

it(@"should have correct default values", ^{
    expect(heightInfo.defaultHeight).to.equal(20.0f);
    expect(heightInfo.usesCache).to.beFalsy();
    expect(heightInfo.heightCalculator).to.beNil();
});


describe(@"height", ^{

    it(@"should return default height if no calculator is provided", ^{
        heightInfo.defaultHeight = 30.0f;
        CGFloat height = [heightInfo headerFooterHeightForSection:nil atIndex:0];

        expect(height).to.equal(30.0f);
    });

    it(@"should return calculated height if calculator is provided", ^{
        heightInfo.defaultHeight = 30.0f;
        heightInfo.heightCalculator = ^CGFloat (BUKTableViewSection *section, NSInteger index) {
            return 40.0f;
        };

        CGFloat height = [heightInfo headerFooterHeightForSection:nil atIndex:0];

        expect(height).to.equal(40.0f);
    });
});


describe(@"cache", ^{

    __block NSInteger number;
    __block NSInteger index;

    beforeEach(^{
        number = 0;
        heightInfo.heightCalculator = ^CGFloat (BUKTableViewSection *section, NSInteger index) {
            number++;
            return 40.0f;
        };
        index = 1;
    });

    describe(@"if enabled", ^{
        beforeEach(^{
            heightInfo.usesCache = YES;
        });

        it(@"should hit cache", ^{
            CGFloat height = [heightInfo headerFooterHeightForSection:nil atIndex:index];

            expect(height).to.equal(40.0f);
            expect(number).to.equal(1);

            height = [heightInfo headerFooterHeightForSection:nil atIndex:index];

            expect(height).to.equal(40.0f);
            expect(number).to.equal(1);
        });

        it(@"should not hit the cache after cache was cleared", ^{
            CGFloat height = [heightInfo headerFooterHeightForSection:nil atIndex:index];
            expect(height).to.equal(40.0f);
            expect(number).to.equal(1);

            [heightInfo clearCache];

            height = [heightInfo headerFooterHeightForSection:nil atIndex:index];
            expect(height).to.equal(40.0f);
            expect(number).to.equal(2);
        });
    });

    describe(@"if disabled", ^{

        beforeEach(^{
            heightInfo.usesCache = NO;
        });

        it(@"should always invoke calculator", ^{
            [heightInfo headerFooterHeightForSection:nil atIndex:index];
            expect(number).to.equal(1);

            [heightInfo headerFooterHeightForSection:nil atIndex:index];
            expect(number).to.equal(2);

            [heightInfo headerFooterHeightForSection:nil atIndex:index];
            expect(number).to.equal(3);
        });
    });
});

afterEach(^{
    heightInfo = nil;
});

SpecEnd
