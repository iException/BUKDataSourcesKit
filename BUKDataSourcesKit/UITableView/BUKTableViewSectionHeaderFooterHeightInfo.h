//
//  BUKTableViewSectionHeaderFooterHeightInfo.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/27/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKTableViewSectionHeaderFooterHeightInfoProtocol.h"


typedef CGFloat (^BUKTableViewSectionHeaderFooterHeightCalculator)(BUKTableViewSection *section, NSInteger index);


@interface BUKTableViewSectionHeaderFooterHeightInfo : NSObject <BUKTableViewSectionHeaderFooterHeightInfoProtocol>

@property (nonatomic) CGFloat defaultHeight;
@property (nonatomic, copy) BUKTableViewSectionHeaderFooterHeightCalculator heightCalculator;
@property (nonatomic) BOOL usesCache;

+ (instancetype)heightInfoWithDefaultHeight:(CGFloat)defaultHeight calculator:(BUKTableViewSectionHeaderFooterHeightCalculator)calculator;

- (instancetype)initWithDefaultHeight:(CGFloat)defaultHeight calculator:(BUKTableViewSectionHeaderFooterHeightCalculator)calculator NS_DESIGNATED_INITIALIZER;
- (void)clearCache;

@end
