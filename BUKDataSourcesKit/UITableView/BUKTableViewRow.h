//
//  BUKTableViewRow.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

@import Foundation;


@protocol BUKTableViewCellFactoryProtocol;
@protocol BUKTableViewSelectionProtocol;
@protocol BUKTableViewRowHeightInfoProtocol;

@interface BUKTableViewRow : NSObject

@property (nonatomic) id<BUKTableViewCellFactoryProtocol> cellFactory;
@property (nonatomic) id<BUKTableViewSelectionProtocol> selection;
@property (nonatomic) id<BUKTableViewRowHeightInfoProtocol> heightInfo;
@property (nonatomic) id object;

+ (instancetype)row;
+ (instancetype)rowWithObject:(id)object;
+ (instancetype)rowWithObject:(id)object cellFactory:(id<BUKTableViewCellFactoryProtocol>)cellFactory selection:(id<BUKTableViewSelectionProtocol>)selection;

- (instancetype)initWithObject:(id)object;
- (instancetype)initWithObject:(id)object cellFactory:(id<BUKTableViewCellFactoryProtocol>)cellFactory selection:(id<BUKTableViewSelectionProtocol>)selection NS_DESIGNATED_INITIALIZER;

@end
