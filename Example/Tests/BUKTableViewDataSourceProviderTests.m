//
//  BUKTableViewDataSourceProviderTests.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 5/12/16.
//  Copyright © 2016 Yiming Tang. All rights reserved.
//

@interface BUKExampleTableViewCell : UITableViewCell

@end


@implementation BUKExampleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    return [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
}

@end


@interface BUKExampleTableViewHeaderFooterView : UITableViewHeaderFooterView
@end

@implementation BUKExampleTableViewHeaderFooterView
@end


SpecBegin(BUKTableViewDataSourceProvider)

describe(@"initializer", ^{

    it(@"should have correct default properties", ^{
        BUKTableViewDataSourceProvider *dataSourceProvider = [[BUKTableViewDataSourceProvider alloc] init];
        expect(dataSourceProvider.sections).to.beNil();
        expect(dataSourceProvider.tableView).to.beNil();
        expect(dataSourceProvider.automaticallyDeselectRows).to.beTruthy();
        expect(dataSourceProvider.automaticallyRegisterCells).to.beTruthy();
        expect(dataSourceProvider.automaticallyRegisterSectionHeaderFooters).to.beTruthy();
        expect(dataSourceProvider.cellFactory).to.beNil();
        expect(dataSourceProvider.headerViewFactory).to.beNil();
        expect(dataSourceProvider.footerViewFactory).to.beNil();
        expect(dataSourceProvider.rowHeightInfo).to.beNil();
        expect(dataSourceProvider.sectionHeaderHeightInfo).to.beNil();
        expect(dataSourceProvider.sectionFooterHeightInfo).to.beNil();
        expect(dataSourceProvider.rowSelection).to.beNil();
    });
    
    it(@"should be the data source and delegate of the table view", ^{
        UITableView *tableView = [UITableView new];
        BUKTableViewDataSourceProvider *dataSourceProvider = [[BUKTableViewDataSourceProvider alloc] initWithTableView:tableView];

        expect(dataSourceProvider).to.beIdenticalTo(tableView.dataSource);
        expect(dataSourceProvider).to.beIdenticalTo(tableView.delegate);
    });

    it(@"should have valid sections", ^{
        UITableView *tableView = [UITableView new];
        NSArray<BUKTableViewSection *> *sections = @[[BUKTableViewSection section], [BUKTableViewSection section]];
        BUKTableViewDataSourceProvider *dataSourceProvider = [[BUKTableViewDataSourceProvider alloc] initWithTableView:tableView sections:sections];

        expect(dataSourceProvider.sections).to.haveCountOf(2);
        expect(dataSourceProvider.sections).to.beIdenticalTo(sections);
    });

    it(@"should have properties initialized correctly", ^{
        UITableView *tableView = [UITableView new];
        NSArray<BUKTableViewSection *> *sections = @[[BUKTableViewSection section], [BUKTableViewSection section]];
        BUKTableViewCellFactory *cellFactory = [BUKTableViewCellFactory factoryWithCellClass:[UITableViewCell class] configurator:nil];
        BUKTableViewHeaderFooterViewFactory *headerFactory = [BUKTableViewHeaderFooterViewFactory factoryWithViewClass:[UITableViewHeaderFooterView class] configurator:nil];
        BUKTableViewHeaderFooterViewFactory *footerFactory = [BUKTableViewHeaderFooterViewFactory factoryWithViewClass:[UITableViewHeaderFooterView class] configurator:nil];
        
        BUKTableViewDataSourceProvider *dataSourceProvider = [[BUKTableViewDataSourceProvider alloc] initWithTableView:tableView sections:sections cellFactory:cellFactory headerFactory:headerFactory footerFactory:footerFactory];

        expect(dataSourceProvider.tableView).to.beIdenticalTo(tableView);
        expect(dataSourceProvider.sections).to.haveCountOf(2);
        expect(dataSourceProvider.headerViewFactory).to.beIdenticalTo(headerFactory);
        expect(dataSourceProvider.footerViewFactory).to.beIdenticalTo(footerFactory);
        expect(dataSourceProvider.cellFactory).to.beIdenticalTo(cellFactory);
    });

});

describe(@"accessors", ^{
    
    __block BUKTableViewDataSourceProvider *dataSourceProvider;
    __block BUKTableViewSection *section;
    __block BUKTableViewRow *row;

    beforeAll(^{
        row = [BUKTableViewRow row];
        section = [BUKTableViewSection section];
        section.rows = @[row, [BUKTableViewRow row]];
        BUKTableViewSection *anotherSection = [BUKTableViewSection sectionWithRows:@[[BUKTableViewRow row], [BUKTableViewRow row], [BUKTableViewRow row]]];
        dataSourceProvider = [[BUKTableViewDataSourceProvider alloc] initWithTableView:[UITableView new] sections:@[section, anotherSection]];
    });

    it(@"should return correct section when index is valid", ^{
        expect([dataSourceProvider sectionAtIndex:0]).to.beIdenticalTo(section);
    });

    it(@"should raise an exception when section index is out of bounds", ^{
        expect(^{ [dataSourceProvider sectionAtIndex:3]; }).to.raiseAny();
    });

    it(@"should return correct row when index path is valid", ^{
        expect([dataSourceProvider rowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).to.beIdenticalTo(row);
    });

    it(@"should raise an exception when row index path is not valid", ^{
        expect(^{ [dataSourceProvider rowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]]; }).to.raiseAny();
    });

    it(@"should update table view correctly", ^{
        UITableView *oldTableView = dataSourceProvider.tableView;
        UITableView *newTableView = [UITableView new];

        dataSourceProvider.tableView = newTableView;

        expect(oldTableView.dataSource).to.beNil();
        expect(oldTableView.delegate).to.beNil();
        expect(newTableView.dataSource).to.beIdenticalTo(dataSourceProvider);
        expect(newTableView.delegate).to.beIdenticalTo(dataSourceProvider);
    });

    afterAll(^{
        dataSourceProvider = nil;
        section = nil;
        row = nil;
    });
});

describe(@"number of things", ^{
    __block BUKTableViewDataSourceProvider *dataSourceProvider;
    __block UITableView *tableView;

    beforeAll(^{
        tableView = [UITableView new];
    });

    beforeEach(^{
        dataSourceProvider = [BUKTableViewDataSourceProvider providerWithTableView:tableView];
    });

    it(@"should have correct number of sections", ^{
        expect([tableView numberOfSections]).to.equal(0);

        dataSourceProvider.sections = @[[BUKTableViewSection section], [BUKTableViewSection section]];
        expect([tableView numberOfSections]).to.equal(2);

        dataSourceProvider.sections = nil;
        expect([tableView numberOfSections]).to.equal(0);
    });

    it(@"should have correct number of rows in each section", ^{
        dataSourceProvider.sections = @[
            [BUKTableViewSection sectionWithRows:@[
                [BUKTableViewRow row],
                [BUKTableViewRow row],
                [BUKTableViewRow row],
            ]],
            [BUKTableViewSection sectionWithRows:@[
                [BUKTableViewRow row],
                [BUKTableViewRow row],
            ]],
            [BUKTableViewSection sectionWithRows:@[
                [BUKTableViewRow row],
                [BUKTableViewRow row],
                [BUKTableViewRow row],
                [BUKTableViewRow row],
            ]],
            [BUKTableViewSection sectionWithRows:@[]],
        ];

        expect([tableView numberOfRowsInSection:0]).to.equal(3);
        expect([tableView numberOfRowsInSection:1]).to.equal(2);
        expect([tableView numberOfRowsInSection:2]).to.equal(4);
        expect([tableView numberOfRowsInSection:3]).to.equal(0);
    });

    afterEach(^{
        dataSourceProvider = nil;
    });

    afterAll(^{
        tableView = nil;
    });
});

describe(@"cells", ^{
    __block BUKTableViewDataSourceProvider *dataSourceProvider;
    __block UITableView *tableView;

    beforeAll(^{
        tableView = [UITableView new];
        dataSourceProvider = [BUKTableViewDataSourceProvider providerWithTableView:tableView];
        dataSourceProvider.cellFactory = [BUKTableViewCellFactory factoryWithCellClass:[UITableViewCell class] configurator:^(__kindof UITableViewCell *cell, BUKTableViewRow *row, UITableView *tableView, NSIndexPath *indexPath) {
            cell.textLabel.text = @"aaa";
        }];

        BUKTableViewCellFactory *rowCellFactory1 = [BUKTableViewCellFactory factoryWithCellClass:[BUKExampleTableViewCell class] configurator:^(__kindof UITableViewCell *cell, BUKTableViewRow *row, UITableView *tableView, NSIndexPath *indexPath) {
            cell.textLabel.text = @"bbb";
        }];

        BUKTableViewCellFactory *rowCellFactory2 = [BUKTableViewCellFactory factoryWithCellClass:[BUKExampleTableViewCell class] configurator:^(__kindof UITableViewCell *cell, BUKTableViewRow *row, UITableView *tableView, NSIndexPath *indexPath) {
            cell.textLabel.text = @"ccc";
        }];

        BUKTableViewCellFactory *sectionCellFactory1 = [BUKTableViewCellFactory factoryWithCellClass:[UITableViewCell class] configurator:^(__kindof UITableViewCell *cell, BUKTableViewRow *row, UITableView *tableView, NSIndexPath *indexPath) {
            cell.textLabel.text = @"sss";
        }];

        BUKTableViewCellFactory *sectionCellFactory2 = [BUKTableViewCellFactory factoryWithCellClass:[BUKExampleTableViewCell class] configurator:^(__kindof UITableViewCell *cell, BUKTableViewRow *row, UITableView *tableView, NSIndexPath *indexPath) {
            cell.textLabel.text = @"ttt";
        }];

        dataSourceProvider.sections = @[
            // Section 0
            [BUKTableViewSection sectionWithHeaderViewFactory:nil rows:@[
                [BUKTableViewRow row],
                [BUKTableViewRow rowWithObject:nil cellFactory:rowCellFactory1 selection:nil],
                [BUKTableViewRow row]
            ] footerViewFactory:nil cellFactory:sectionCellFactory1],

            // Section 1
            [BUKTableViewSection sectionWithHeaderViewFactory:nil rows:@[
                [BUKTableViewRow row],
                [BUKTableViewRow row],
            ] footerViewFactory:nil cellFactory:sectionCellFactory2],
            // Section 2
            [BUKTableViewSection sectionWithRows:@[
                [BUKTableViewRow row],
                [BUKTableViewRow rowWithObject:nil cellFactory:rowCellFactory2 selection:nil],
                [BUKTableViewRow row],
                [BUKTableViewRow row],
            ]],
        ];
    });

    it(@"should use provider's cell factory when neither of the row and its section has a cell factory", ^{
        UITableViewCell *cell = [dataSourceProvider tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
        
        expect(cell).to.beMemberOf([UITableViewCell class]);
        expect(cell.textLabel.text).to.equal(@"aaa");
    });

    it(@"should use the rows cell factory when the row has a cell factory", ^{
        UITableViewCell *cell = [dataSourceProvider tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        
        expect(cell).to.beMemberOf([BUKExampleTableViewCell class]);
        expect(cell.textLabel.text).to.equal(@"bbb");
        
        cell = [dataSourceProvider tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:2]];
        
        expect(cell).to.beMemberOf([BUKExampleTableViewCell class]);
        expect(cell.textLabel.text).to.equal(@"ccc");
    });

    it(@"should use the section's cell factory when row's is nil and section's cell factory exists", ^{
        UITableViewCell *cell = [dataSourceProvider tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];

        expect(cell).to.beMemberOf([BUKExampleTableViewCell class]);
        expect(cell.textLabel.text).to.equal(@"ttt");

        cell = [dataSourceProvider tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

        expect(cell).to.beMemberOf([UITableViewCell class]);
        expect(cell.textLabel.text).to.equal(@"sss");
    });

    afterAll(^{
        tableView = nil;
        dataSourceProvider = nil;
    });
});

describe(@"section header/footer titles", ^{
    __block BUKTableViewDataSourceProvider *dataSourceProvider;
    __block UITableView *tableView;

    beforeAll(^{
        tableView = [UITableView new];
        dataSourceProvider = [BUKTableViewDataSourceProvider providerWithTableView:tableView];
        BUKTableViewHeaderFooterViewFactory *viewFactory1 = [BUKTableViewHeaderFooterViewFactory factoryWithTitle:@"Header"];
        BUKTableViewHeaderFooterViewFactory *viewFactory2 = [BUKTableViewHeaderFooterViewFactory factoryWithTitle:@"Footer"];
        BUKTableViewHeaderFooterViewFactory *viewFactory3 = [BUKTableViewHeaderFooterViewFactory factoryWithTitle:@"Shoulder"];
        BUKTableViewHeaderFooterViewFactory *viewFactory4 = [BUKTableViewHeaderFooterViewFactory factoryWithViewClass:[UITableViewHeaderFooterView class] configurator:^(__kindof UITableViewHeaderFooterView *view, BUKTableViewSection *section, UITableView *tableView, NSInteger index) {
            view.textLabel.text = @"Toes";
        }];
        BUKTableViewHeaderFooterViewFactory *viewFactory5 = [BUKTableViewHeaderFooterViewFactory factoryWithTitle:@"Legs"];

        dataSourceProvider.sections = @[
            [BUKTableViewSection sectionWithHeaderViewFactory:viewFactory1 rows:@[[BUKTableViewRow row], [BUKTableViewRow row], [BUKTableViewRow row]] footerViewFactory:viewFactory2],
            [BUKTableViewSection sectionWithHeaderViewFactory:viewFactory3 rows:@[[BUKTableViewRow row], [BUKTableViewRow row]] footerViewFactory:viewFactory4],
            [BUKTableViewSection sectionWithHeaderViewFactory:viewFactory4 rows:@[[BUKTableViewRow row], [BUKTableViewRow row], [BUKTableViewRow row]] footerViewFactory:viewFactory5],
            [BUKTableViewSection sectionWithHeaderViewFactory:nil rows:@[[BUKTableViewRow row], [BUKTableViewRow row], [BUKTableViewRow row]] footerViewFactory:nil],
        ];

        dataSourceProvider.headerViewFactory = viewFactory1;
    });

    it(@"should return correct header titles", ^{
        expect([dataSourceProvider tableView:tableView titleForHeaderInSection:0]).to.equal(@"Header");
        expect([dataSourceProvider tableView:tableView titleForHeaderInSection:1]).to.equal(@"Shoulder");
        expect([dataSourceProvider tableView:tableView titleForHeaderInSection:2]).to.beNil();
        expect([dataSourceProvider tableView:tableView titleForHeaderInSection:3]).to.equal(@"Header");
    });

    it(@"should return correct footer titles", ^{
        expect([dataSourceProvider tableView:tableView titleForFooterInSection:0]).to.equal(@"Footer");
        expect([dataSourceProvider tableView:tableView titleForFooterInSection:1]).to.beNil();
        expect([dataSourceProvider tableView:tableView titleForFooterInSection:2]).to.equal(@"Legs");
        expect([dataSourceProvider tableView:tableView titleForFooterInSection:3]).to.beNil();
    });
});

describe(@"section header/footer views", ^{
    __block BUKTableViewDataSourceProvider *dataSourceProvider;
    __block UITableView *tableView;

    beforeAll(^{
        tableView = [UITableView new];
        dataSourceProvider = [BUKTableViewDataSourceProvider providerWithTableView:tableView];
        BUKTableViewHeaderFooterViewFactory *viewFactory1 = [BUKTableViewHeaderFooterViewFactory factoryWithViewClass:[UITableViewHeaderFooterView class] configurator:^(__kindof UITableViewHeaderFooterView *view, BUKTableViewSection *section, UITableView *tableView, NSInteger index) {
            view.textLabel.text = @"header";
        }];
        BUKTableViewHeaderFooterViewFactory *viewFactory2 = [BUKTableViewHeaderFooterViewFactory factoryWithViewClass:[BUKExampleTableViewHeaderFooterView class] configurator:^(__kindof UITableViewHeaderFooterView *view, BUKTableViewSection *section, UITableView *tableView, NSInteger index) {
            view.textLabel.text = @"another header";
        }];
        BUKTableViewHeaderFooterViewFactory *viewFactory3 = [BUKTableViewHeaderFooterViewFactory factoryWithViewClass:[UITableViewHeaderFooterView class] configurator:^(__kindof UITableViewHeaderFooterView *view, BUKTableViewSection *section, UITableView *tableView, NSInteger index) {
            view.textLabel.text = @"footer";
        }];
        BUKTableViewHeaderFooterViewFactory *viewFactory4 = [BUKTableViewHeaderFooterViewFactory factoryWithViewClass:[BUKExampleTableViewHeaderFooterView class] configurator:^(__kindof UITableViewHeaderFooterView *view, BUKTableViewSection *section, UITableView *tableView, NSInteger index) {
            view.textLabel.text = @"another footer";
        }];

        dataSourceProvider.sections = @[
            [BUKTableViewSection sectionWithHeaderViewFactory:viewFactory1 rows:@[[BUKTableViewRow row], [BUKTableViewRow row], [BUKTableViewRow row]] footerViewFactory:viewFactory3],
            [BUKTableViewSection sectionWithHeaderViewFactory:viewFactory2 rows:@[[BUKTableViewRow row], [BUKTableViewRow row]] footerViewFactory:viewFactory4],
            [BUKTableViewSection sectionWithHeaderViewFactory:viewFactory2 rows:@[[BUKTableViewRow row], [BUKTableViewRow row], [BUKTableViewRow row]] footerViewFactory:nil],
            [BUKTableViewSection sectionWithHeaderViewFactory:nil rows:@[[BUKTableViewRow row], [BUKTableViewRow row], [BUKTableViewRow row]] footerViewFactory:nil],
        ];
        
        dataSourceProvider.headerViewFactory = viewFactory1;
    });

    it(@"should return correct section header views", ^{
        UITableViewHeaderFooterView *view = (UITableViewHeaderFooterView *)[dataSourceProvider tableView:tableView viewForHeaderInSection:0];

        expect(view).to.beMemberOf([UITableViewHeaderFooterView class]);
        expect(view.textLabel.text).to.equal(@"header");

        view = (UITableViewHeaderFooterView *)[dataSourceProvider tableView:tableView viewForHeaderInSection:1];

        expect(view).to.beMemberOf([BUKExampleTableViewHeaderFooterView class]);
        expect(view.textLabel.text).to.equal(@"another header");

        view = (UITableViewHeaderFooterView *)[dataSourceProvider tableView:tableView viewForHeaderInSection:3];

        expect(view).to.beMemberOf([UITableViewHeaderFooterView class]);
        expect(view.textLabel.text).to.equal(@"header");
    });

    it(@"should return correct section footer views", ^{
        UITableViewHeaderFooterView *view = (UITableViewHeaderFooterView *)[dataSourceProvider tableView:tableView viewForFooterInSection:0];

        expect(view).to.beMemberOf([UITableViewHeaderFooterView class]);
        expect(view.textLabel.text).to.equal(@"footer");

        view = (UITableViewHeaderFooterView *)[dataSourceProvider tableView:tableView viewForFooterInSection:1];

        expect(view).to.beMemberOf([BUKExampleTableViewHeaderFooterView class]);
        expect(view.textLabel.text).to.equal(@"another footer");

        view = (UITableViewHeaderFooterView *)[dataSourceProvider tableView:tableView viewForFooterInSection:2];

        expect(view).to.beNil();
    });
});

SpecEnd
