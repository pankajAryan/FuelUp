//
//  HomeMapStoreModelProductList.h
//
//  Created by   on 29/08/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomeMapStoreModelProduct;

@interface HomeMapStoreModelProductList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) HomeMapStoreModelProduct *product;
@property (nonatomic, strong) NSString *lastUpdated;
@property (nonatomic, strong) NSString *cost;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
