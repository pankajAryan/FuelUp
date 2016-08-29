//
//  FuelStationProductList.h
//
//  Created by   on 28/08/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FuelStationProduct;

@interface FuelStationProductList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) FuelStationProduct *product;
@property (nonatomic, strong) NSString *lastUpdated;
@property (nonatomic, strong) NSString *cost;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
