//
//  HomeMapStoreModelResponseObject.m
//
//  Created by   on 29/08/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "HomeMapStoreModelResponseObject.h"
#import "HomeMapStoreModelProductList.h"


NSString *const kHomeMapStoreModelResponseObjectAddress = @"address";
NSString *const kHomeMapStoreModelResponseObjectProductList = @"productList";
NSString *const kHomeMapStoreModelResponseObjectId = @"id";
NSString *const kHomeMapStoreModelResponseObjectLon = @"lon";
NSString *const kHomeMapStoreModelResponseObjectBrand = @"brand";
NSString *const kHomeMapStoreModelResponseObjectLat = @"lat";
NSString *const kHomeMapStoreModelResponseObjectOfferList = @"offerList";
NSString *const kHomeMapStoreModelResponseObjectName = @"name";


@interface HomeMapStoreModelResponseObject ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HomeMapStoreModelResponseObject

@synthesize address = _address;
@synthesize productList = _productList;
@synthesize responseObjectIdentifier = _responseObjectIdentifier;
@synthesize lon = _lon;
@synthesize brand = _brand;
@synthesize lat = _lat;
@synthesize offerList = _offerList;
@synthesize name = _name;


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
            self.address = [self objectOrNilForKey:kHomeMapStoreModelResponseObjectAddress fromDictionary:dict];
    NSObject *receivedHomeMapStoreModelProductList = [dict objectForKey:kHomeMapStoreModelResponseObjectProductList];
    NSMutableArray *parsedHomeMapStoreModelProductList = [NSMutableArray array];
    if ([receivedHomeMapStoreModelProductList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedHomeMapStoreModelProductList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedHomeMapStoreModelProductList addObject:[HomeMapStoreModelProductList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedHomeMapStoreModelProductList isKindOfClass:[NSDictionary class]]) {
       [parsedHomeMapStoreModelProductList addObject:[HomeMapStoreModelProductList modelObjectWithDictionary:(NSDictionary *)receivedHomeMapStoreModelProductList]];
    }

    self.productList = [NSArray arrayWithArray:parsedHomeMapStoreModelProductList];
            self.responseObjectIdentifier = [self objectOrNilForKey:kHomeMapStoreModelResponseObjectId fromDictionary:dict];
            self.lon = [self objectOrNilForKey:kHomeMapStoreModelResponseObjectLon fromDictionary:dict];
            self.brand = [self objectOrNilForKey:kHomeMapStoreModelResponseObjectBrand fromDictionary:dict];
            self.lat = [self objectOrNilForKey:kHomeMapStoreModelResponseObjectLat fromDictionary:dict];
            self.offerList = [self objectOrNilForKey:kHomeMapStoreModelResponseObjectOfferList fromDictionary:dict];
            self.name = [self objectOrNilForKey:kHomeMapStoreModelResponseObjectName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.address forKey:kHomeMapStoreModelResponseObjectAddress];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForProductList] forKey:kHomeMapStoreModelResponseObjectProductList];
    [mutableDict setValue:self.responseObjectIdentifier forKey:kHomeMapStoreModelResponseObjectId];
    [mutableDict setValue:self.lon forKey:kHomeMapStoreModelResponseObjectLon];
    [mutableDict setValue:self.brand forKey:kHomeMapStoreModelResponseObjectBrand];
    [mutableDict setValue:self.lat forKey:kHomeMapStoreModelResponseObjectLat];
    [mutableDict setValue:self.offerList forKey:kHomeMapStoreModelResponseObjectOfferList];
    [mutableDict setValue:self.name forKey:kHomeMapStoreModelResponseObjectName];

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

    self.address = [aDecoder decodeObjectForKey:kHomeMapStoreModelResponseObjectAddress];
    self.productList = [aDecoder decodeObjectForKey:kHomeMapStoreModelResponseObjectProductList];
    self.responseObjectIdentifier = [aDecoder decodeObjectForKey:kHomeMapStoreModelResponseObjectId];
    self.lon = [aDecoder decodeObjectForKey:kHomeMapStoreModelResponseObjectLon];
    self.brand = [aDecoder decodeObjectForKey:kHomeMapStoreModelResponseObjectBrand];
    self.lat = [aDecoder decodeObjectForKey:kHomeMapStoreModelResponseObjectLat];
    self.offerList = [aDecoder decodeObjectForKey:kHomeMapStoreModelResponseObjectOfferList];
    self.name = [aDecoder decodeObjectForKey:kHomeMapStoreModelResponseObjectName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_address forKey:kHomeMapStoreModelResponseObjectAddress];
    [aCoder encodeObject:_productList forKey:kHomeMapStoreModelResponseObjectProductList];
    [aCoder encodeObject:_responseObjectIdentifier forKey:kHomeMapStoreModelResponseObjectId];
    [aCoder encodeObject:_lon forKey:kHomeMapStoreModelResponseObjectLon];
    [aCoder encodeObject:_brand forKey:kHomeMapStoreModelResponseObjectBrand];
    [aCoder encodeObject:_lat forKey:kHomeMapStoreModelResponseObjectLat];
    [aCoder encodeObject:_offerList forKey:kHomeMapStoreModelResponseObjectOfferList];
    [aCoder encodeObject:_name forKey:kHomeMapStoreModelResponseObjectName];
}

- (id)copyWithZone:(NSZone *)zone
{
    HomeMapStoreModelResponseObject *copy = [[HomeMapStoreModelResponseObject alloc] init];
    
    if (copy) {

        copy.address = [self.address copyWithZone:zone];
        copy.productList = [self.productList copyWithZone:zone];
        copy.responseObjectIdentifier = [self.responseObjectIdentifier copyWithZone:zone];
        copy.lon = [self.lon copyWithZone:zone];
        copy.brand = [self.brand copyWithZone:zone];
        copy.lat = [self.lat copyWithZone:zone];
        copy.offerList = [self.offerList copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
