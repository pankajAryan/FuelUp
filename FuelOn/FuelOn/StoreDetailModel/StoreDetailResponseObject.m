//
//  StoreDetailResponseObject.m
//
//  Created by   on 29/08/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "StoreDetailResponseObject.h"
#import "StoreDetailProductList.h"
#import "StoreDetailOfferList.h"


NSString *const kStoreDetailResponseObjectAddress = @"address";
NSString *const kStoreDetailResponseObjectProductList = @"productList";
NSString *const kStoreDetailResponseObjectId = @"id";
NSString *const kStoreDetailResponseObjectLon = @"lon";
NSString *const kStoreDetailResponseObjectLat = @"lat";
NSString *const kStoreDetailResponseObjectOfferList = @"offerList";
NSString *const kStoreDetailResponseObjectName = @"name";
NSString *const kStoreDetailResponseObjectPhoneNumber = @"phoneNumber";
NSString *const kStoreDetailResponseObjectBrand = @"brand";
NSString *const kStoreDetailResponseObjectPremium = @"isPremium";
NSString *const kStoreDetailResponseObjectLastUpdated = @"lastUpdated";


@interface StoreDetailResponseObject ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation StoreDetailResponseObject

@synthesize address = _address;
@synthesize productList = _productList;
@synthesize responseObjectIdentifier = _responseObjectIdentifier;
@synthesize lon = _lon;
@synthesize lat = _lat;
@synthesize offerList = _offerList;
@synthesize name = _name;
@synthesize phoneNumber = _phoneNumber;
@synthesize brand = _brand;


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
        self.address = [self objectOrNilForKey:kStoreDetailResponseObjectAddress fromDictionary:dict];
        self.isPremium = [self objectOrNilForKey:kStoreDetailResponseObjectPremium fromDictionary:dict];
        self.lastUpdated = [self objectOrNilForKey:kStoreDetailResponseObjectLastUpdated fromDictionary:dict];
        NSObject *receivedStoreDetailProductList = [dict objectForKey:kStoreDetailResponseObjectProductList];
        NSMutableArray *parsedStoreDetailProductList = [NSMutableArray array];
        if ([receivedStoreDetailProductList isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedStoreDetailProductList) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedStoreDetailProductList addObject:[StoreDetailProductList modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedStoreDetailProductList isKindOfClass:[NSDictionary class]]) {
            [parsedStoreDetailProductList addObject:[StoreDetailProductList modelObjectWithDictionary:(NSDictionary *)receivedStoreDetailProductList]];
        }
        
        self.productList = [NSArray arrayWithArray:parsedStoreDetailProductList];
        self.responseObjectIdentifier = [self objectOrNilForKey:kStoreDetailResponseObjectId fromDictionary:dict];
        self.lon = [self objectOrNilForKey:kStoreDetailResponseObjectLon fromDictionary:dict];
        self.lat = [self objectOrNilForKey:kStoreDetailResponseObjectLat fromDictionary:dict];
        NSObject *receivedStoreDetailOfferList = [dict objectForKey:kStoreDetailResponseObjectOfferList];
        NSMutableArray *parsedStoreDetailOfferList = [NSMutableArray array];
        if ([receivedStoreDetailOfferList isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedStoreDetailOfferList) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedStoreDetailOfferList addObject:[StoreDetailOfferList modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedStoreDetailOfferList isKindOfClass:[NSDictionary class]]) {
            [parsedStoreDetailOfferList addObject:[StoreDetailOfferList modelObjectWithDictionary:(NSDictionary *)receivedStoreDetailOfferList]];
        }
        
        self.offerList = [NSArray arrayWithArray:parsedStoreDetailOfferList];
        self.name = [self objectOrNilForKey:kStoreDetailResponseObjectName fromDictionary:dict];
        self.phoneNumber = [self objectOrNilForKey:kStoreDetailResponseObjectPhoneNumber fromDictionary:dict];
        self.brand = [self objectOrNilForKey:kStoreDetailResponseObjectBrand fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.address forKey:kStoreDetailResponseObjectAddress];
    [mutableDict setValue:self.isPremium forKey:kStoreDetailResponseObjectPremium];
    [mutableDict setValue:self.lastUpdated forKey:kStoreDetailResponseObjectLastUpdated];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForProductList] forKey:kStoreDetailResponseObjectProductList];
    [mutableDict setValue:self.responseObjectIdentifier forKey:kStoreDetailResponseObjectId];
    [mutableDict setValue:self.lon forKey:kStoreDetailResponseObjectLon];
    [mutableDict setValue:self.lat forKey:kStoreDetailResponseObjectLat];
    NSMutableArray *tempArrayForOfferList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.offerList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForOfferList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForOfferList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForOfferList] forKey:kStoreDetailResponseObjectOfferList];
    [mutableDict setValue:self.name forKey:kStoreDetailResponseObjectName];
    [mutableDict setValue:self.phoneNumber forKey:kStoreDetailResponseObjectPhoneNumber];
    [mutableDict setValue:self.brand forKey:kStoreDetailResponseObjectBrand];
    
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
    
    self.address = [aDecoder decodeObjectForKey:kStoreDetailResponseObjectAddress];
    self.isPremium = [aDecoder decodeObjectForKey:kStoreDetailResponseObjectPremium];
    self.lastUpdated = [aDecoder decodeObjectForKey:kStoreDetailResponseObjectLastUpdated];
    self.productList = [aDecoder decodeObjectForKey:kStoreDetailResponseObjectProductList];
    self.responseObjectIdentifier = [aDecoder decodeObjectForKey:kStoreDetailResponseObjectId];
    self.lon = [aDecoder decodeObjectForKey:kStoreDetailResponseObjectLon];
    self.lat = [aDecoder decodeObjectForKey:kStoreDetailResponseObjectLat];
    self.offerList = [aDecoder decodeObjectForKey:kStoreDetailResponseObjectOfferList];
    self.name = [aDecoder decodeObjectForKey:kStoreDetailResponseObjectName];
    self.phoneNumber = [aDecoder decodeObjectForKey:kStoreDetailResponseObjectPhoneNumber];
    self.brand = [aDecoder decodeObjectForKey:kStoreDetailResponseObjectBrand];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_isPremium forKey:kStoreDetailResponseObjectPremium];
    [aCoder encodeObject:_lastUpdated forKey:kStoreDetailResponseObjectLastUpdated];
    [aCoder encodeObject:_address forKey:kStoreDetailResponseObjectAddress];
    [aCoder encodeObject:_productList forKey:kStoreDetailResponseObjectProductList];
    [aCoder encodeObject:_responseObjectIdentifier forKey:kStoreDetailResponseObjectId];
    [aCoder encodeObject:_lon forKey:kStoreDetailResponseObjectLon];
    [aCoder encodeObject:_lat forKey:kStoreDetailResponseObjectLat];
    [aCoder encodeObject:_offerList forKey:kStoreDetailResponseObjectOfferList];
    [aCoder encodeObject:_name forKey:kStoreDetailResponseObjectName];
    [aCoder encodeObject:_phoneNumber forKey:kStoreDetailResponseObjectPhoneNumber];
    [aCoder encodeObject:_brand forKey:kStoreDetailResponseObjectBrand];
    
}

- (id)copyWithZone:(NSZone *)zone
{
    StoreDetailResponseObject *copy = [[StoreDetailResponseObject alloc] init];
    
    if (copy) {
        copy.isPremium = [self.isPremium copyWithZone:zone];
        copy.lastUpdated = [self.lastUpdated copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.productList = [self.productList copyWithZone:zone];
        copy.responseObjectIdentifier = [self.responseObjectIdentifier copyWithZone:zone];
        copy.lon = [self.lon copyWithZone:zone];
        copy.lat = [self.lat copyWithZone:zone];
        copy.offerList = [self.offerList copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.phoneNumber = [self.phoneNumber copyWithZone:zone];
        copy.brand = [self.brand copyWithZone:zone];
        
    }
    
    return copy;
}


@end
