//
//  FuelStationResponseObject.m
//
//  Created by   on 28/08/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "FuelStationResponseObject.h"
#import "FuelStationProductList.h"


NSString *const kFuelStationResponseObjectAddress = @"address";
NSString *const kFuelStationResponseObjectProductList = @"productList";
NSString *const kFuelStationResponseObjectId = @"id";
NSString *const kFuelStationResponseObjectLon = @"lon";
NSString *const kFuelStationResponseObjectLat = @"lat";
NSString *const kFuelStationResponseObjectOfferList = @"offerList";
NSString *const kFuelStationResponseObjectName = @"name";
NSString *const kFuelStationResponseObjectPhoneNumber = @"phoneNumber";


@interface FuelStationResponseObject ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FuelStationResponseObject

@synthesize address = _address;
@synthesize productList = _productList;
@synthesize responseObjectIdentifier = _responseObjectIdentifier;
@synthesize lon = _lon;
@synthesize lat = _lat;
@synthesize offerList = _offerList;
@synthesize name = _name;
@synthesize phoneNumber = _phoneNumber;


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
            self.address = [self objectOrNilForKey:kFuelStationResponseObjectAddress fromDictionary:dict];
    NSObject *receivedFuelStationProductList = [dict objectForKey:kFuelStationResponseObjectProductList];
    NSMutableArray *parsedFuelStationProductList = [NSMutableArray array];
    if ([receivedFuelStationProductList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedFuelStationProductList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedFuelStationProductList addObject:[FuelStationProductList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedFuelStationProductList isKindOfClass:[NSDictionary class]]) {
       [parsedFuelStationProductList addObject:[FuelStationProductList modelObjectWithDictionary:(NSDictionary *)receivedFuelStationProductList]];
    }

    self.productList = [NSArray arrayWithArray:parsedFuelStationProductList];
            self.responseObjectIdentifier = [self objectOrNilForKey:kFuelStationResponseObjectId fromDictionary:dict];
            self.lon = [self objectOrNilForKey:kFuelStationResponseObjectLon fromDictionary:dict];
            self.lat = [self objectOrNilForKey:kFuelStationResponseObjectLat fromDictionary:dict];
            self.offerList = [self objectOrNilForKey:kFuelStationResponseObjectOfferList fromDictionary:dict];
            self.name = [self objectOrNilForKey:kFuelStationResponseObjectName fromDictionary:dict];
            self.phoneNumber = [self objectOrNilForKey:kFuelStationResponseObjectPhoneNumber fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.address forKey:kFuelStationResponseObjectAddress];
    NSMutableArray *tempArrayForProductList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.productList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForProductList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForProductList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForProductList] forKey:kFuelStationResponseObjectProductList];
    [mutableDict setValue:self.responseObjectIdentifier forKey:kFuelStationResponseObjectId];
    [mutableDict setValue:self.lon forKey:kFuelStationResponseObjectLon];
    [mutableDict setValue:self.lat forKey:kFuelStationResponseObjectLat];
    [mutableDict setValue:self.offerList forKey:kFuelStationResponseObjectOfferList];
    [mutableDict setValue:self.name forKey:kFuelStationResponseObjectName];
    [mutableDict setValue:self.phoneNumber forKey:kFuelStationResponseObjectPhoneNumber];

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

    self.address = [aDecoder decodeObjectForKey:kFuelStationResponseObjectAddress];
    self.productList = [aDecoder decodeObjectForKey:kFuelStationResponseObjectProductList];
    self.responseObjectIdentifier = [aDecoder decodeObjectForKey:kFuelStationResponseObjectId];
    self.lon = [aDecoder decodeObjectForKey:kFuelStationResponseObjectLon];
    self.lat = [aDecoder decodeObjectForKey:kFuelStationResponseObjectLat];
    self.offerList = [aDecoder decodeObjectForKey:kFuelStationResponseObjectOfferList];
    self.name = [aDecoder decodeObjectForKey:kFuelStationResponseObjectName];
    self.phoneNumber = [aDecoder decodeObjectForKey:kFuelStationResponseObjectPhoneNumber];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_address forKey:kFuelStationResponseObjectAddress];
    [aCoder encodeObject:_productList forKey:kFuelStationResponseObjectProductList];
    [aCoder encodeObject:_responseObjectIdentifier forKey:kFuelStationResponseObjectId];
    [aCoder encodeObject:_lon forKey:kFuelStationResponseObjectLon];
    [aCoder encodeObject:_lat forKey:kFuelStationResponseObjectLat];
    [aCoder encodeObject:_offerList forKey:kFuelStationResponseObjectOfferList];
    [aCoder encodeObject:_name forKey:kFuelStationResponseObjectName];
    [aCoder encodeObject:_phoneNumber forKey:kFuelStationResponseObjectPhoneNumber];
}

- (id)copyWithZone:(NSZone *)zone
{
    FuelStationResponseObject *copy = [[FuelStationResponseObject alloc] init];
    
    if (copy) {

        copy.address = [self.address copyWithZone:zone];
        copy.productList = [self.productList copyWithZone:zone];
        copy.responseObjectIdentifier = [self.responseObjectIdentifier copyWithZone:zone];
        copy.lon = [self.lon copyWithZone:zone];
        copy.lat = [self.lat copyWithZone:zone];
        copy.offerList = [self.offerList copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.phoneNumber = [self.phoneNumber copyWithZone:zone];
    }
    
    return copy;
}


@end
