//
//  StoreDetailProductList.h
//
//  Created by   on 29/08/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StoreDetailProduct;

@interface StoreDetailProductList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) StoreDetailProduct *product;
//@property (nonatomic, strong) NSString *lastUpdated;
@property (nonatomic, strong) NSString *cost;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
