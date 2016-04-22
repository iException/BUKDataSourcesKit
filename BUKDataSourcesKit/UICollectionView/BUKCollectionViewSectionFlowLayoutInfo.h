//
//  BUKCollectionViewSectionFlowLayoutInfo.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/22/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKCollectionViewSectionFlowLayoutInfoProtocol.h"


@interface BUKCollectionViewSectionFlowLayoutInfo : NSObject <BUKCollectionViewSectionFlowLayoutInfoProtocol>

@property (nonatomic) CGFloat minimumLineSpacing;
@property (nonatomic) CGFloat minimumInteritemSpacing;
@property (nonatomic) CGSize headerReferenceSize;
@property (nonatomic) CGSize footerReferenceSize;
@property (nonatomic) UIEdgeInsets sectionInset;

@end
