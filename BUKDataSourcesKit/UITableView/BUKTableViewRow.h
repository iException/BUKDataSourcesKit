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

@interface BUKTableViewRow : NSObject

@property (nonatomic) id<BUKTableViewCellFactoryProtocol> cellFactory;
@property (nonatomic, copy) id<BUKTableViewSelectionProtocol> selection;
@property (nonatomic) id object;

- (instancetype)initWithObject:(id)object;
- (instancetype)initWithObject:(id)object cellFactory:(id<BUKTableViewCellFactoryProtocol>)cellFactory selection:(id<BUKTableViewSelectionProtocol>)selection NS_DESIGNATED_INITIALIZER;

@end
