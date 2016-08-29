//
//  StoreDetailProduct.m
//
//  Created by   on 29/08/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "StoreDetailProduct.h"


NSString *const kStoreDetailProductStatus = @"status";
NSString *const kStoreDetailProductProductName = @"productName";
NSString *const kStoreDetailProductProductId = @"productId";


@interface StoreDetailProduct ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation StoreDetailProduct

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
            self.status = [self objectOrNilForKey:kStoreDetailProductStatus fromDictionary:dict];
            self.productName = [self objectOrNilForKey:kStoreDetailProductProductName fromDictionary:dict];
            self.productId = [self objectOrNilForKey:kStoreDetailProductProductId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kStoreDetailProductStatus];
    [mutableDict setValue:self.productName forKey:kStoreDetailProductProductName];
    [mutableDict setValue:self.productId forKey:kStoreDetailProductProductId];

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

    self.status = [aDecoder decodeObjectForKey:kStoreDetailProductStatus];
    self.productName = [aDecoder decodeObjectForKey:kStoreDetailProductProductName];
    self.productId = [aDecoder decodeObjectForKey:kStoreDetailProductProductId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kStoreDetailProductStatus];
    [aCoder encodeObject:_productName forKey:kStoreDetailProductProductName];
    [aCoder encodeObject:_productId forKey:kStoreDetailProductProductId];
}

- (id)copyWithZone:(NSZone *)zone
{
    StoreDetailProduct *copy = [[StoreDetailProduct alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.productName = [self.productName copyWithZone:zone];
        copy.productId = [self.productId copyWithZone:zone];
    }
    
    return copy;
}


@end
