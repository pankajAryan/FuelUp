//
//  StoreDetailOfferList.m
//
//  Created by   on 29/08/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "StoreDetailOfferList.h"


NSString *const kStoreDetailOfferListOfferName = @"offerName";
NSString *const kStoreDetailOfferListCondition = @"condition";
NSString *const kStoreDetailOfferListId = @"id";
NSString *const kStoreDetailOfferListStartDate = @"startDate";
NSString *const kStoreDetailOfferListEndDate = @"endDate";
NSString *const kStoreDetailOfferListDiscountOffer = @"discountOffer";
NSString *const kStoreDetailOfferListStoreId = @"storeId";


@interface StoreDetailOfferList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation StoreDetailOfferList

@synthesize offerName = _offerName;
@synthesize condition = _condition;
@synthesize offerListIdentifier = _offerListIdentifier;
@synthesize startDate = _startDate;
@synthesize endDate = _endDate;
@synthesize discountOffer = _discountOffer;
@synthesize storeId = _storeId;


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
            self.offerName = [self objectOrNilForKey:kStoreDetailOfferListOfferName fromDictionary:dict];
            self.condition = [self objectOrNilForKey:kStoreDetailOfferListCondition fromDictionary:dict];
            self.offerListIdentifier = [self objectOrNilForKey:kStoreDetailOfferListId fromDictionary:dict];
            self.startDate = [self objectOrNilForKey:kStoreDetailOfferListStartDate fromDictionary:dict];
            self.endDate = [self objectOrNilForKey:kStoreDetailOfferListEndDate fromDictionary:dict];
            self.discountOffer = [self objectOrNilForKey:kStoreDetailOfferListDiscountOffer fromDictionary:dict];
            self.storeId = [self objectOrNilForKey:kStoreDetailOfferListStoreId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.offerName forKey:kStoreDetailOfferListOfferName];
    [mutableDict setValue:self.condition forKey:kStoreDetailOfferListCondition];
    [mutableDict setValue:self.offerListIdentifier forKey:kStoreDetailOfferListId];
    [mutableDict setValue:self.startDate forKey:kStoreDetailOfferListStartDate];
    [mutableDict setValue:self.endDate forKey:kStoreDetailOfferListEndDate];
    [mutableDict setValue:self.discountOffer forKey:kStoreDetailOfferListDiscountOffer];
    [mutableDict setValue:self.storeId forKey:kStoreDetailOfferListStoreId];

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

    self.offerName = [aDecoder decodeObjectForKey:kStoreDetailOfferListOfferName];
    self.condition = [aDecoder decodeObjectForKey:kStoreDetailOfferListCondition];
    self.offerListIdentifier = [aDecoder decodeObjectForKey:kStoreDetailOfferListId];
    self.startDate = [aDecoder decodeObjectForKey:kStoreDetailOfferListStartDate];
    self.endDate = [aDecoder decodeObjectForKey:kStoreDetailOfferListEndDate];
    self.discountOffer = [aDecoder decodeObjectForKey:kStoreDetailOfferListDiscountOffer];
    self.storeId = [aDecoder decodeObjectForKey:kStoreDetailOfferListStoreId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_offerName forKey:kStoreDetailOfferListOfferName];
    [aCoder encodeObject:_condition forKey:kStoreDetailOfferListCondition];
    [aCoder encodeObject:_offerListIdentifier forKey:kStoreDetailOfferListId];
    [aCoder encodeObject:_startDate forKey:kStoreDetailOfferListStartDate];
    [aCoder encodeObject:_endDate forKey:kStoreDetailOfferListEndDate];
    [aCoder encodeObject:_discountOffer forKey:kStoreDetailOfferListDiscountOffer];
    [aCoder encodeObject:_storeId forKey:kStoreDetailOfferListStoreId];
}

- (id)copyWithZone:(NSZone *)zone
{
    StoreDetailOfferList *copy = [[StoreDetailOfferList alloc] init];
    
    if (copy) {

        copy.offerName = [self.offerName copyWithZone:zone];
        copy.condition = [self.condition copyWithZone:zone];
        copy.offerListIdentifier = [self.offerListIdentifier copyWithZone:zone];
        copy.startDate = [self.startDate copyWithZone:zone];
        copy.endDate = [self.endDate copyWithZone:zone];
        copy.discountOffer = [self.discountOffer copyWithZone:zone];
        copy.storeId = [self.storeId copyWithZone:zone];
    }
    
    return copy;
}


@end
