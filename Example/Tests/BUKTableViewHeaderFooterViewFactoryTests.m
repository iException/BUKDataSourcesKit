//
//  BUKTableViewHeaderFooterViewFactoryTests.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 5/12/16.
//  Copyright © 2016 Yiming Tang. All rights reserved.
//

SpecBegin(BUKTableViewHeaderFooterViewFactory)

describe(@"BUKTableViewHeaderFooterViewFactory", ^{

    __block BUKTableViewHeaderFooterViewFactory *factory;

    beforeAll(^{
        factory = [[BUKTableViewHeaderFooterViewFactory alloc] initWithViewClass:[UITableViewHeaderFooterView class] configurator:^(__kindof UITableViewHeaderFooterView *view, BUKTableViewSection *section, UITableView *tableView, NSInteger index) {
            view.textLabel.text = [NSString stringWithFormat:@"section: %ld", (long)index];
        }];
    });

    it(@"should have all properties set correctly", ^{
        expect(factory.viewClass).to.equal([UITableViewHeaderFooterView class]);
        expect(factory.reuseIdentifier).to.equal(@"UITableViewHeaderFooterView");
        expect(factory.viewConfigurator).notTo.beNil();
    });

    describe(@"BUKTableViewHeaderFooterViewFactoryProtocol", ^{

        it(@"should return correct view class", ^{
            Class viewClass = [factory headerFooterViewClassForSection:[BUKTableViewSection new] atIndex:0];
            expect(viewClass).to.equal([UITableViewHeaderFooterView class]);
        });

        it(@"should return correct reuse identifier", ^{
            NSString *reuseIdentifier = [factory reuseIdentifierForSection:[BUKTableViewSection new] atIndex:0];
            expect(reuseIdentifier).to.equal(@"UITableViewHeaderFooterView");
        });

        it(@"should configure header footer view correctly", ^{
            UITableViewHeaderFooterView *view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"UITableViewHeaderFooterView"];
            [factory configureView:view withSection:[BUKTableViewSection new] inTableView:[UITableView new] atIndex:2];
            expect(view.textLabel.text).to.equal(@"section: 2");
        });
    });

    afterAll(^{
        factory = nil;
    });
});

SpecEnd
