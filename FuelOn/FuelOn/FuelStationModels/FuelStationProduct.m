//
//  FuelStationProduct.m
//
//  Created by   on 28/08/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "FuelStationProduct.h"


NSString *const kFuelStationProductStatus = @"status";
NSString *const kFuelStationProductProductName = @"productName";
NSString *const kFuelStationProductProductId = @"productId";


@interface FuelStationProduct ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FuelStationProduct

@synthesize status = _status;
@synthesize productName = _productName;
@synthesize productId = _productId;


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
            self.status = [self objectOrNilForKey:kFuelStationProductStatus fromDictionary:dict];
            self.productName = [self objectOrNilForKey:kFuelStationProductProductName fromDictionary:dict];
            self.productId = [self objectOrNilForKey:kFuelStationProductProductId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kFuelStationProductStatus];
    [mutableDict setValue:self.productName forKey:kFuelStationProductProductName];
    [mutableDict setValue:self.productId forKey:kFuelStationProductProductId];

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

    self.status = [aDecoder decodeObjectForKey:kFuelStationProductStatus];
    self.productName = [aDecoder decodeObjectForKey:kFuelStationProductProductName];
    self.productId = [aDecoder decodeObjectForKey:kFuelStationProductProductId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kFuelStationProductStatus];
    [aCoder encodeObject:_productName forKey:kFuelStationProductProductName];
    [aCoder encodeObject:_productId forKey:kFuelStationProductProductId];
}

- (id)copyWithZone:(NSZone *)zone
{
    FuelStationProduct *copy = [[FuelStationProduct alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.productName = [self.productName copyWithZone:zone];
        copy.productId = [self.productId copyWithZone:zone];
    }
    
    return copy;
}


@end
