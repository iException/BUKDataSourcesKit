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
        BUKTableViewDataSourceProvider *provider = [[BUKTableViewDataSourceProvider alloc] init];

        expect(provider.sections).notTo.beNil();
        expect(provider.sections).to.beEmpty();
        expect(provider.tableView).to.beNil();
        expect(provider.automaticallyDeselectRows).to.beTruthy();
        expect(provider.automaticallyRegisterCells).to.beTruthy();
        expect(provider.automaticallyRegisterSectionHeaderFooters).to.beTruthy();
        expect(provider.cellFactory).to.beNil();
        expect(provider.headerViewFactory).to.beNil();
        expect(provider.footerViewFactory).to.beNil();
        expect(provider.rowHeightInfo).to.beNil();
        expect(provider.sectionHeaderHeightInfo).to.beNil();
        expect(provider.sectionFooterHeightInfo).to.beNil();
        expect(provider.rowSelection).to.beNil();
    });
    
    it(@"should be the data source and delegate of the table view", ^{
        id tableViewMock = OCMClassMock([UITableView class]);
        BUKTableViewDataSourceProvider *provider = [[BUKTableViewDataSourceProvider alloc] initWithTableView:tableViewMock];

        OCMVerify([tableViewMock setDataSource:provider]);
        OCMVerify([tableViewMock setDelegate:provider]);
    });

    it(@"should have valid sections", ^{
        id sectionMock0 = OCMClassMock([BUKTableViewSection class]);
        id sectionMock1 = OCMClassMock([BUKTableViewSection class]);
        NSArray<BUKTableViewSection *> *sections = @[sectionMock0, sectionMock1];
        BUKTableViewDataSourceProvider *provider = [[BUKTableViewDataSourceProvider alloc] initWithTableView:nil sections:sections];

        expect(provider.sections).to.haveCountOf(2);
        expect(provider.sections[0]).to.equal(sectionMock0);
        expect(provider.sections[1]).to.equal(sectionMock1);
    });

    it(@"should have properties initialized correctly", ^{
        id tableViewMock = OCMClassMock([UITableView class]);
        NSArray *sectionMocks = @[OCMClassMock([BUKTableViewSection class]), OCMClassMock([BUKTableViewSection class])];
        id cellFactoryMock = OCMProtocolMock(@protocol(BUKTableViewCellFactoryProtocol));
        id headerFactoryMock = OCMProtocolMock(@protocol(BUKTableViewHeaderFooterViewFactoryProtocol));
        id footerFactoryMock = OCMProtocolMock(@protocol(BUKTableViewHeaderFooterViewFactoryProtocol));

        BUKTableViewDataSourceProvider *provider = [[BUKTableViewDataSourceProvider alloc] initWithTableView:tableViewMock sections:sectionMocks cellFactory:cellFactoryMock headerFactory:headerFactoryMock footerFactory:footerFactoryMock];

        expect(provider.tableView).to.beIdenticalTo(tableViewMock);
        expect(provider.sections).to.haveCountOf(2);
        expect(provider.headerViewFactory).to.beIdenticalTo(headerFactoryMock);
        expect(provider.footerViewFactory).to.beIdenticalTo(footerFactoryMock);
        expect(provider.cellFactory).to.beIdenticalTo(cellFactoryMock);
    });

});

describe(@"accessors", ^{
    
    __block BUKTableViewDataSourceProvider *provider;
    __block id sectionMock;
    __block id rowMock;

    beforeAll(^{
        rowMock = OCMClassMock([BUKTableViewRow class]);
        sectionMock = OCMClassMock([BUKTableViewSection class]);
        OCMStub([sectionMock rowAtIndex:0]).andReturn(rowMock);
        OCMStub([sectionMock rowAtIndex:3]).andThrow([NSException new]);
        id anotherSectionMock = OCMClassMock([BUKTableViewSection class]);

        provider = [[BUKTableViewDataSourceProvider alloc] initWithTableView:OCMClassMock([UITableView class]) sections:@[sectionMock, anotherSectionMock]];
    });

    it(@"should return correct section when index is valid", ^{
        expect([provider sectionAtIndex:0]).to.beIdenticalTo(sectionMock);
    });

    it(@"should raise an exception when section index is out of bounds", ^{
        expect(^{ [provider sectionAtIndex:3]; }).to.raiseAny();
    });

    it(@"should return correct row when index path is valid", ^{
        expect([provider rowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).to.beIdenticalTo(rowMock);
    });

    it(@"should raise an exception when row index path is not valid", ^{
        expect(^{ [provider rowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]]; }).to.raiseAny();
    });

    it(@"should update table view correctly", ^{
        id oldTableViewMock = provider.tableView;
        id newTableViewMock = OCMClassMock([UITableView class]);

        provider.tableView = newTableViewMock;

        OCMVerify([oldTableViewMock setDataSource:[OCMArg isNil]]);
        OCMVerify([oldTableViewMock setDelegate:[OCMArg isNil]]);
        OCMVerify([newTableViewMock setDataSource:provider]);
        OCMVerify([newTableViewMock setDelegate:provider]);
    });

    afterAll(^{
        provider = nil;
        sectionMock = nil;
        rowMock = nil;
    });
});

describe(@"number of things", ^{
    __block BUKTableViewDataSourceProvider *provider;
    __block id tableViewMock;

    beforeAll(^{
        tableViewMock = OCMClassMock([UITableView class]);
    });

    beforeEach(^{
        provider = [BUKTableViewDataSourceProvider providerWithTableView:tableViewMock];
    });

    it(@"should have correct number of sections", ^{
        expect([provider numberOfSectionsInTableView:tableViewMock]).to.equal(0);

        provider.sections = @[OCMClassMock([BUKTableViewSection class]), OCMClassMock([BUKTableViewSection class])];
        expect([provider numberOfSectionsInTableView:tableViewMock]).to.equal(2);

        provider.sections = nil;
        expect([provider numberOfSectionsInTableView:tableViewMock]).to.equal(0);
    });

    it(@"should have correct number of rows in each section", ^{
        id sectionMock0 = OCMClassMock([BUKTableViewSection class]);
        id sectionMock1 = OCMClassMock([BUKTableViewSection class]);
        id sectionMock2 = OCMClassMock([BUKTableViewSection class]);
        id sectionMock3 = OCMClassMock([BUKTableViewSection class]);

        [OCMStub([sectionMock0 rows]) andReturn:@[OCMClassMock([BUKTableViewRow class]), OCMClassMock([BUKTableViewRow class]), OCMClassMock([BUKTableViewRow class])]];
        [OCMStub([sectionMock1 rows]) andReturn:@[OCMClassMock([BUKTableViewRow class]), OCMClassMock([BUKTableViewRow class])]];
        [OCMStub([sectionMock2 rows]) andReturn:@[OCMClassMock([BUKTableViewRow class]), OCMClassMock([BUKTableViewRow class]), OCMClassMock([BUKTableViewRow class]), OCMClassMock([BUKTableViewRow class])]];
        OCMStub([sectionMock3 rows]).andReturn(@[]);

        provider.sections = @[sectionMock0, sectionMock1, sectionMock2, sectionMock3];

        expect([provider tableView:tableViewMock numberOfRowsInSection:0]).to.equal(3);
        expect([provider tableView:tableViewMock numberOfRowsInSection:1]).to.equal(2);
        expect([provider tableView:tableViewMock numberOfRowsInSection:2]).to.equal(4);
        expect([provider tableView:tableViewMock numberOfRowsInSection:3]).to.equal(0);
    });

    afterEach(^{
        provider = nil;
    });

    afterAll(^{
        tableViewMock = nil;
    });
});

describe(@"cells", ^{
    __block BUKTableViewDataSourceProvider *provider;
    __block UITableView *tableView;

    beforeAll(^{
        tableView = [UITableView new];
        provider = [BUKTableViewDataSourceProvider providerWithTableView:tableView];

        id globalCellFactoryMock = OCMProtocolMock(@protocol(BUKTableViewCellFactoryProtocol));
        OCMStub([globalCellFactoryMock cellClassForRow:OCMOCK_ANY atIndexPath:OCMOCK_ANY]).andReturn([UITableViewCell class]);
        OCMStub([globalCellFactoryMock reuseIdentifierForRow:OCMOCK_ANY atIndexPath:OCMOCK_ANY]).andReturn(@"UITableViewCell");
        OCMStub([globalCellFactoryMock configureCell:[OCMArg isKindOfClass:[UITableViewCell class]] withRow:OCMOCK_ANY inTableView:tableView atIndexPath:[OCMArg isKindOfClass:[NSIndexPath class]]]).andDo(^(NSInvocation *invocation) {
            UITableViewCell *cell;
            [invocation getArgument:&cell atIndex:2];
            cell.textLabel.text = @"aaa";
        });

        provider.cellFactory = globalCellFactoryMock;

        id rowCellFactoryMock0 = OCMProtocolMock(@protocol(BUKTableViewCellFactoryProtocol));
        OCMStub([rowCellFactoryMock0 cellClassForRow:OCMOCK_ANY atIndexPath:OCMOCK_ANY]).andReturn([BUKExampleTableViewCell class]);
        OCMStub([rowCellFactoryMock0 reuseIdentifierForRow:OCMOCK_ANY atIndexPath:OCMOCK_ANY]).andReturn(@"BUKExampleTableViewCell");
        OCMStub([rowCellFactoryMock0 configureCell:[OCMArg isKindOfClass:[UITableViewCell class]] withRow:OCMOCK_ANY inTableView:tableView atIndexPath:[OCMArg isKindOfClass:[NSIndexPath class]]]).andDo(^(NSInvocation *invocation) {
            BUKExampleTableViewCell *cell;
            [invocation getArgument:&cell atIndex:2];
            cell.textLabel.text = @"bbb";
        });

        id rowCellFactoryMock1 = OCMProtocolMock(@protocol(BUKTableViewCellFactoryProtocol));
        OCMStub([rowCellFactoryMock1 cellClassForRow:OCMOCK_ANY atIndexPath:OCMOCK_ANY]).andReturn([BUKExampleTableViewCell class]);
        OCMStub([rowCellFactoryMock1 reuseIdentifierForRow:OCMOCK_ANY atIndexPath:OCMOCK_ANY]).andReturn(@"BUKExampleTableViewCell");
        OCMStub([rowCellFactoryMock1 configureCell:[OCMArg isKindOfClass:[UITableViewCell class]] withRow:OCMOCK_ANY inTableView:tableView atIndexPath:[OCMArg isKindOfClass:[NSIndexPath class]]]).andDo(^(NSInvocation *invocation) {
            BUKExampleTableViewCell *cell;
            [invocation getArgument:&cell atIndex:2];
            cell.textLabel.text = @"ccc";
        });

        id sectionCellFactoryMock0 = OCMProtocolMock(@protocol(BUKTableViewCellFactoryProtocol));
        OCMStub([sectionCellFactoryMock0 cellClassForRow:OCMOCK_ANY atIndexPath:OCMOCK_ANY]).andReturn([UITableViewCell class]);
        OCMStub([sectionCellFactoryMock0 reuseIdentifierForRow:OCMOCK_ANY atIndexPath:OCMOCK_ANY]).andReturn(@"UITableViewCell");
        OCMStub([sectionCellFactoryMock0 configureCell:[OCMArg isKindOfClass:[UITableViewCell class]] withRow:OCMOCK_ANY inTableView:tableView atIndexPath:[OCMArg isKindOfClass:[NSIndexPath class]]]).andDo(^(NSInvocation *invocation) {
            UITableViewCell *cell;
            [invocation getArgument:&cell atIndex:2];
            cell.textLabel.text = @"sss";
        });

        id sectionCellFactoryMock1 = OCMProtocolMock(@protocol(BUKTableViewCellFactoryProtocol));
        OCMStub([sectionCellFactoryMock1 cellClassForRow:OCMOCK_ANY atIndexPath:OCMOCK_ANY]).andReturn([BUKExampleTableViewCell class]);
        OCMStub([sectionCellFactoryMock1 reuseIdentifierForRow:OCMOCK_ANY atIndexPath:OCMOCK_ANY]).andReturn(@"BUKExampleTableViewCell");
        OCMStub([sectionCellFactoryMock1 configureCell:[OCMArg isKindOfClass:[UITableViewCell class]] withRow:OCMOCK_ANY inTableView:tableView atIndexPath:[OCMArg isKindOfClass:[NSIndexPath class]]]).andDo(^(NSInvocation *invocation) {
            BUKExampleTableViewCell *cell;
            [invocation getArgument:&cell atIndex:2];
            cell.textLabel.text = @"ttt";
        });

        // NOTE: Should do mocking too.
        provider.sections = @[
            // Section 0
            [BUKTableViewSection sectionWithHeaderViewFactory:nil rows:@[
                [BUKTableViewRow row],
                [BUKTableViewRow rowWithObject:nil cellFactory:rowCellFactoryMock0 selection:nil],
                [BUKTableViewRow row]
            ] footerViewFactory:nil cellFactory:sectionCellFactoryMock0],

            // Section 1
            [BUKTableViewSection sectionWithHeaderViewFactory:nil rows:@[
                [BUKTableViewRow row],
                [BUKTableViewRow row],
            ] footerViewFactory:nil cellFactory:sectionCellFactoryMock1],

            // Section 2
            [BUKTableViewSection sectionWithRows:@[
                [BUKTableViewRow row],
                [BUKTableViewRow rowWithObject:nil cellFactory:rowCellFactoryMock1 selection:nil],
                [BUKTableViewRow row],
                [BUKTableViewRow row],
            ]],
        ];
    });

    it(@"should use provider's cell factory when neither of the row and its section has a cell factory", ^{
        UITableViewCell *cell = [provider tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
        
        expect(cell).to.beMemberOf([UITableViewCell class]);
        expect(cell.textLabel.text).to.equal(@"aaa");
    });

    it(@"should use the rows cell factory when the row has a cell factory", ^{
        UITableViewCell *cell = [provider tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        
        expect(cell).to.beMemberOf([BUKExampleTableViewCell class]);
        expect(cell.textLabel.text).to.equal(@"bbb");
        
        cell = [provider tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:2]];
        
        expect(cell).to.beMemberOf([BUKExampleTableViewCell class]);
        expect(cell.textLabel.text).to.equal(@"ccc");
    });

    it(@"should use the section's cell factory when row's is nil and section's cell factory exists", ^{
        UITableViewCell *cell = [provider tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];

        expect(cell).to.beMemberOf([BUKExampleTableViewCell class]);
        expect(cell.textLabel.text).to.equal(@"ttt");

        cell = [provider tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

        expect(cell).to.beMemberOf([UITableViewCell class]);
        expect(cell.textLabel.text).to.equal(@"sss");
    });

    afterAll(^{
        tableView = nil;
        provider = nil;
    });
});

describe(@"section header/footer titles", ^{
    __block BUKTableViewDataSourceProvider *provider;
    __block UITableView *tableView;

    beforeAll(^{
        tableView = [UITableView new];
        provider = [BUKTableViewDataSourceProvider providerWithTableView:tableView];

        id viewFactoryMock0 = OCMProtocolMock(@protocol(BUKTableViewHeaderFooterViewFactoryProtocol));
        [OCMStub([viewFactoryMock0 titleForSection:OCMOCK_ANY atIndex:0]).andReturn(@"Header") ignoringNonObjectArgs];

        id viewFactoryMock1 = OCMProtocolMock(@protocol(BUKTableViewHeaderFooterViewFactoryProtocol));
        [OCMStub([viewFactoryMock1 titleForSection:OCMOCK_ANY atIndex:0]).andReturn(@"Footer") ignoringNonObjectArgs];

        id viewFactoryMock2 = OCMProtocolMock(@protocol(BUKTableViewHeaderFooterViewFactoryProtocol));
        [OCMStub([viewFactoryMock2 titleForSection:OCMOCK_ANY atIndex:0]).andReturn(@"Shoulder") ignoringNonObjectArgs];

        id viewFactoryMock3 = OCMProtocolMock(@protocol(BUKTableViewHeaderFooterViewFactoryProtocol));
        [OCMStub([viewFactoryMock3 reuseIdentifierForSection:OCMOCK_ANY atIndex:0]).andReturn(@"UITableViewHeaderFooterView") ignoringNonObjectArgs];
        [OCMStub([viewFactoryMock3 headerFooterViewClassForSection:OCMOCK_ANY atIndex:0]).andReturn([UITableViewHeaderFooterView class]) ignoringNonObjectArgs];
        [OCMStub([viewFactoryMock3 configureView:[OCMArg isKindOfClass:[UITableViewHeaderFooterView class]] withSection:OCMOCK_ANY inTableView:tableView atIndex:0]).andDo(^(NSInvocation *invocation) {
            UITableViewHeaderFooterView *view;
            [invocation getArgument:&view atIndex:2];
            view.textLabel.text = @"Toes";
        }) ignoringNonObjectArgs];

        id viewFactoryMock4 = OCMProtocolMock(@protocol(BUKTableViewHeaderFooterViewFactoryProtocol));
        [OCMStub([viewFactoryMock4 titleForSection:OCMOCK_ANY atIndex:0]).andReturn(@"Legs") ignoringNonObjectArgs];

        provider.sections = @[
            [BUKTableViewSection sectionWithHeaderViewFactory:viewFactoryMock0 rows:nil footerViewFactory:viewFactoryMock1],
            [BUKTableViewSection sectionWithHeaderViewFactory:viewFactoryMock2 rows:nil footerViewFactory:viewFactoryMock3],
            [BUKTableViewSection sectionWithHeaderViewFactory:viewFactoryMock3 rows:nil footerViewFactory:viewFactoryMock4],
            [BUKTableViewSection sectionWithHeaderViewFactory:nil rows:nil footerViewFactory:nil],
        ];

        provider.headerViewFactory = viewFactoryMock0;
    });

    it(@"should return correct header titles", ^{
        expect([provider tableView:tableView titleForHeaderInSection:0]).to.equal(@"Header");
        expect([provider tableView:tableView titleForHeaderInSection:1]).to.equal(@"Shoulder");
        expect([provider tableView:tableView titleForHeaderInSection:2]).to.beNil();
        expect([provider tableView:tableView titleForHeaderInSection:3]).to.equal(@"Header");
    });

    it(@"should return correct footer titles", ^{
        expect([provider tableView:tableView titleForFooterInSection:0]).to.equal(@"Footer");
        expect([provider tableView:tableView titleForFooterInSection:1]).to.beNil();
        expect([provider tableView:tableView titleForFooterInSection:2]).to.equal(@"Legs");
        expect([provider tableView:tableView titleForFooterInSection:3]).to.beNil();
    });
});


describe(@"section header/footer views", ^{
    __block BUKTableViewDataSourceProvider *provider;
    __block UITableView *tableView;

    beforeAll(^{
        tableView = [UITableView new];
        provider = [BUKTableViewDataSourceProvider providerWithTableView:tableView];

        id viewFactoryMock0 = OCMProtocolMock(@protocol(BUKTableViewHeaderFooterViewFactoryProtocol));
        [OCMStub([viewFactoryMock0 reuseIdentifierForSection:OCMOCK_ANY atIndex:0]).andReturn(@"UITableViewHeaderFooterView") ignoringNonObjectArgs];
        [OCMStub([viewFactoryMock0 headerFooterViewClassForSection:OCMOCK_ANY atIndex:0]).andReturn([UITableViewHeaderFooterView class]) ignoringNonObjectArgs];
        [OCMStub([viewFactoryMock0 configureView:[OCMArg isKindOfClass:[UITableViewHeaderFooterView class]] withSection:OCMOCK_ANY inTableView:tableView atIndex:0]).andDo(^(NSInvocation *invocation) {
            UITableViewHeaderFooterView *view;
            [invocation getArgument:&view atIndex:2];
            view.textLabel.text = @"header";
        }) ignoringNonObjectArgs];

        id viewFactoryMock1 = OCMProtocolMock(@protocol(BUKTableViewHeaderFooterViewFactoryProtocol));
        [OCMStub([viewFactoryMock1 reuseIdentifierForSection:OCMOCK_ANY atIndex:0]).andReturn(@"BUKExampleTableViewHeaderFooterView") ignoringNonObjectArgs];
        [OCMStub([viewFactoryMock1 headerFooterViewClassForSection:OCMOCK_ANY atIndex:0]).andReturn([BUKExampleTableViewHeaderFooterView class]) ignoringNonObjectArgs];
        [OCMStub([viewFactoryMock1 configureView:[OCMArg isKindOfClass:[BUKExampleTableViewHeaderFooterView class]] withSection:OCMOCK_ANY inTableView:tableView atIndex:0]).andDo(^(NSInvocation *invocation) {
            UITableViewHeaderFooterView *view;
            [invocation getArgument:&view atIndex:2];
            view.textLabel.text = @"another header";
        }) ignoringNonObjectArgs];

        id viewFactoryMock2 = OCMProtocolMock(@protocol(BUKTableViewHeaderFooterViewFactoryProtocol));
        [OCMStub([viewFactoryMock2 reuseIdentifierForSection:OCMOCK_ANY atIndex:0]).andReturn(@"UITableViewHeaderFooterView") ignoringNonObjectArgs];
        [OCMStub([viewFactoryMock2 headerFooterViewClassForSection:OCMOCK_ANY atIndex:0]).andReturn([UITableViewHeaderFooterView class]) ignoringNonObjectArgs];
        [OCMStub([viewFactoryMock2 configureView:[OCMArg isKindOfClass:[UITableViewHeaderFooterView class]] withSection:OCMOCK_ANY inTableView:tableView atIndex:0]).andDo(^(NSInvocation *invocation) {
            UITableViewHeaderFooterView *view;
            [invocation getArgument:&view atIndex:2];
            view.textLabel.text = @"footer";
        }) ignoringNonObjectArgs];

        id viewFactoryMock3 = OCMProtocolMock(@protocol(BUKTableViewHeaderFooterViewFactoryProtocol));
        [OCMStub([viewFactoryMock3 reuseIdentifierForSection:OCMOCK_ANY atIndex:0]).andReturn(@"BUKExampleTableViewHeaderFooterView") ignoringNonObjectArgs];
        [OCMStub([viewFactoryMock3 headerFooterViewClassForSection:OCMOCK_ANY atIndex:0]).andReturn([BUKExampleTableViewHeaderFooterView class]) ignoringNonObjectArgs];
        [OCMStub([viewFactoryMock3 configureView:[OCMArg isKindOfClass:[BUKExampleTableViewHeaderFooterView class]] withSection:OCMOCK_ANY inTableView:tableView atIndex:0]).andDo(^(NSInvocation *invocation) {
            UITableViewHeaderFooterView *view;
            [invocation getArgument:&view atIndex:2];
            view.textLabel.text = @"another footer";
        }) ignoringNonObjectArgs];

        provider.sections = @[
            [BUKTableViewSection sectionWithHeaderViewFactory:viewFactoryMock0 rows:nil footerViewFactory:viewFactoryMock2],
            [BUKTableViewSection sectionWithHeaderViewFactory:viewFactoryMock1 rows:nil footerViewFactory:viewFactoryMock3],
            [BUKTableViewSection sectionWithHeaderViewFactory:viewFactoryMock1 rows:nil footerViewFactory:nil],
            [BUKTableViewSection sectionWithHeaderViewFactory:nil rows:nil footerViewFactory:nil],
        ];
        
        provider.headerViewFactory = viewFactoryMock0;
    });

    it(@"should return correct section header views", ^{
        UITableViewHeaderFooterView *view = (UITableViewHeaderFooterView *)[provider tableView:tableView viewForHeaderInSection:0];

        expect(view).to.beMemberOf([UITableViewHeaderFooterView class]);
        expect(view.textLabel.text).to.equal(@"header");

        view = (UITableViewHeaderFooterView *)[provider tableView:tableView viewForHeaderInSection:1];

        expect(view).to.beMemberOf([BUKExampleTableViewHeaderFooterView class]);
        expect(view.textLabel.text).to.equal(@"another header");

        view = (UITableViewHeaderFooterView *)[provider tableView:tableView viewForHeaderInSection:3];

        expect(view).to.beMemberOf([UITableViewHeaderFooterView class]);
        expect(view.textLabel.text).to.equal(@"header");
    });

    it(@"should return correct section footer views", ^{
        UITableViewHeaderFooterView *view = (UITableViewHeaderFooterView *)[provider tableView:tableView viewForFooterInSection:0];

        expect(view).to.beMemberOf([UITableViewHeaderFooterView class]);
        expect(view.textLabel.text).to.equal(@"footer");

        view = (UITableViewHeaderFooterView *)[provider tableView:tableView viewForFooterInSection:1];

        expect(view).to.beMemberOf([BUKExampleTableViewHeaderFooterView class]);
        expect(view.textLabel.text).to.equal(@"another footer");

        view = (UITableViewHeaderFooterView *)[provider tableView:tableView viewForFooterInSection:2];

        expect(view).to.beNil();
    });
});

SpecEnd
