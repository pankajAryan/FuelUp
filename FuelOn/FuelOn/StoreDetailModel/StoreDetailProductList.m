//
//  StoreDetailProductList.m
//
//  Created by   on 29/08/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "StoreDetailProductList.h"
#import "StoreDetailProduct.h"


NSString *const kStoreDetailProductListProduct = @"product";
//NSString *const kStoreDetailProductListLastUpdated = @"lastUpdated";
NSString *const kStoreDetailProductListCost = @"cost";


@interface StoreDetailProductList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation StoreDetailProductList

@synthesize product = _product;
@synthesize cost = _cost;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.product = [StoreDetailProduct modelObjectWithDictionary:[dict objectForKey:kStoreDetailProductListProduct]];
//        self.lastUpdated = [self objectOrNilForKey:kStoreDetailProductListLastUpdated fromDictionary:dict];
        self.cost = [self objectOrNilForKey:kStoreDetailProductListCost fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.product dictionaryRepresentation] forKey:kStoreDetailProductListProduct];
//    [mutableDict setValue:self.lastUpdated forKey:kStoreDetailProductListLastUpdated];
    [mutableDict setValue:self.cost forKey:kStoreDetailProductListCost];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    self.product = [aDecoder decodeObjectForKey:kStoreDetailProductListProduct];
//    self.lastUpdated = [aDecoder decodeObjectForKey:kStoreDetailProductListLastUpdated];
    self.cost = [aDecoder decodeObjectForKey:kStoreDetailProductListCost];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_product forKey:kStoreDetailProductListProduct];
//    [aCoder encodeObject:_lastUpdated forKey:kStoreDetailProductListLastUpdated];
    [aCoder encodeObject:_cost forKey:kStoreDetailProductListCost];
}

- (id)copyWithZone:(NSZone *)zone
{
    StoreDetailProductList *copy = [[StoreDetailProductList alloc] init];
    
    if (copy) {
        
        copy.product = [self.product copyWithZone:zone];
//        copy.lastUpdated = [self.lastUpdated copyWithZone:zone];
        copy.cost = [self.cost copyWithZone:zone];
    }
    
    return copy;
}


@end
