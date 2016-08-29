//
//  FuelStationProductList.m
//
//  Created by   on 28/08/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "FuelStationProductList.h"
#import "FuelStationProduct.h"


NSString *const kFuelStationProductListProduct = @"product";
NSString *const kFuelStationProductListLastUpdated = @"lastUpdated";
NSString *const kFuelStationProductListCost = @"cost";


@interface FuelStationProductList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FuelStationProductList

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
            self.product = [FuelStationProduct modelObjectWithDictionary:[dict objectForKey:kFuelStationProductListProduct]];
            self.lastUpdated = [self objectOrNilForKey:kFuelStationProductListLastUpdated fromDictionary:dict];
            self.cost = [self objectOrNilForKey:kFuelStationProductListCost fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.product dictionaryRepresentation] forKey:kFuelStationProductListProduct];
    [mutableDict setValue:self.lastUpdated forKey:kFuelStationProductListLastUpdated];
    [mutableDict setValue:self.cost forKey:kFuelStationProductListCost];

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

    self.product = [aDecoder decodeObjectForKey:kFuelStationProductListProduct];
    self.lastUpdated = [aDecoder decodeObjectForKey:kFuelStationProductListLastUpdated];
    self.cost = [aDecoder decodeObjectForKey:kFuelStationProductListCost];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_product forKey:kFuelStationProductListProduct];
    [aCoder encodeObject:_lastUpdated forKey:kFuelStationProductListLastUpdated];
    [aCoder encodeObject:_cost forKey:kFuelStationProductListCost];
}

- (id)copyWithZone:(NSZone *)zone
{
    FuelStationProductList *copy = [[FuelStationProductList alloc] init];
    
    if (copy) {

        copy.product = [self.product copyWithZone:zone];
        copy.lastUpdated = [self.lastUpdated copyWithZone:zone];
        copy.cost = [self.cost copyWithZone:zone];
    }
    
    return copy;
}


@end
