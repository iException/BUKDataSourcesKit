//
//  BUKTableViewRow.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

@import Foundation;


@protocol BUKTableViewCellFactoryProtocol;


@interface BUKTableViewRow : NSObject

@property (nonatomic) id<BUKTableViewCellFactoryProtocol> cellFactory;
@property (nonatomic) id object;

- (instancetype)initWithObject:(id)object cellFactory:(id<BUKTableViewCellFactoryProtocol>)cellFactory NS_DESIGNATED_INITIALIZER;

@end
