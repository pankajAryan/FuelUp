//
//  HomeMapStoreModelProductList.m
//
//  Created by   on 29/08/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "HomeMapStoreModelProductList.h"
#import "HomeMapStoreModelProduct.h"


NSString *const kHomeMapStoreModelProductListProduct = @"product";
NSString *const kHomeMapStoreModelProductListLastUpdated = @"lastUpdated";
NSString *const kHomeMapStoreModelProductListCost = @"cost";


@interface HomeMapStoreModelProductList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HomeMapStoreModelProductList

@synthesize product = _product;
@synthesize lastUpdated = _lastUpdated;
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
            self.product = [HomeMapStoreModelProduct modelObjectWithDictionary:[dict objectForKey:kHomeMapStoreModelProductListProduct]];
            self.lastUpdated = [self objectOrNilForKey:kHomeMapStoreModelProductListLastUpdated fromDictionary:dict];
            self.cost = [self objectOrNilForKey:kHomeMapStoreModelProductListCost fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.product dictionaryRepresentation] forKey:kHomeMapStoreModelProductListProduct];
    [mutableDict setValue:self.lastUpdated forKey:kHomeMapStoreModelProductListLastUpdated];
    [mutableDict setValue:self.cost forKey:kHomeMapStoreModelProductListCost];

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

    self.product = [aDecoder decodeObjectForKey:kHomeMapStoreModelProductListProduct];
    self.lastUpdated = [aDecoder decodeObjectForKey:kHomeMapStoreModelProductListLastUpdated];
    self.cost = [aDecoder decodeObjectForKey:kHomeMapStoreModelProductListCost];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_product forKey:kHomeMapStoreModelProductListProduct];
    [aCoder encodeObject:_lastUpdated forKey:kHomeMapStoreModelProductListLastUpdated];
    [aCoder encodeObject:_cost forKey:kHomeMapStoreModelProductListCost];
}

- (id)copyWithZone:(NSZone *)zone
{
    HomeMapStoreModelProductList *copy = [[HomeMapStoreModelProductList alloc] init];
    
    if (copy) {

        copy.product = [self.product copyWithZone:zone];
        copy.lastUpdated = [self.lastUpdated copyWithZone:zone];
        copy.cost = [self.cost copyWithZone:zone];
    }
    
    return copy;
}


@end
