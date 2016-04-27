//
//  BUKTableViewRowHeightInfo.h
//  BUKDataSourcesKit 
//
//  Created by Yiming Tang on 4/27/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKTableViewRowHeightInfoProtocol.h"


typedef CGFloat (^BUKTableViewRowHeightCalculator)(BUKTableViewRow *row, NSIndexPath *indexPath);


@interface BUKTableViewRowHeightInfo : NSObject <BUKTableViewRowHeightInfoProtocol>

@property (nonatomic) CGFloat defaultHeight;
@property (nonatomic, copy) BUKTableViewRowHeightCalculator heightCalculator;
@property (nonatomic) BOOL usesCache;

+ (instancetype)heightInfoWithDefaultHeight:(CGFloat)defaultHeight calculator:(BUKTableViewRowHeightCalculator)calculator;

- (instancetype)initWithDefaultHeight:(CGFloat)defaultHeight calculator:(BUKTableViewRowHeightCalculator)calculator NS_DESIGNATED_INITIALIZER;
- (void)clearCache;

@end
