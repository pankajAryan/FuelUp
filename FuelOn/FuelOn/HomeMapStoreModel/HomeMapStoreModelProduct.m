//
//  HomeMapStoreModelProduct.m
//
//  Created by   on 29/08/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "HomeMapStoreModelProduct.h"


NSString *const kHomeMapStoreModelProductStatus = @"status";
NSString *const kHomeMapStoreModelProductProductName = @"productName";
NSString *const kHomeMapStoreModelProductProductId = @"productId";


@interface HomeMapStoreModelProduct ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HomeMapStoreModelProduct

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
            self.status = [self objectOrNilForKey:kHomeMapStoreModelProductStatus fromDictionary:dict];
            self.productName = [self objectOrNilForKey:kHomeMapStoreModelProductProductName fromDictionary:dict];
            self.productId = [self objectOrNilForKey:kHomeMapStoreModelProductProductId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kHomeMapStoreModelProductStatus];
    [mutableDict setValue:self.productName forKey:kHomeMapStoreModelProductProductName];
    [mutableDict setValue:self.productId forKey:kHomeMapStoreModelProductProductId];

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

    self.status = [aDecoder decodeObjectForKey:kHomeMapStoreModelProductStatus];
    self.productName = [aDecoder decodeObjectForKey:kHomeMapStoreModelProductProductName];
    self.productId = [aDecoder decodeObjectForKey:kHomeMapStoreModelProductProductId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kHomeMapStoreModelProductStatus];
    [aCoder encodeObject:_productName forKey:kHomeMapStoreModelProductProductName];
    [aCoder encodeObject:_productId forKey:kHomeMapStoreModelProductProductId];
}

- (id)copyWithZone:(NSZone *)zone
{
    HomeMapStoreModelProduct *copy = [[HomeMapStoreModelProduct alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.productName = [self.productName copyWithZone:zone];
        copy.productId = [self.productId copyWithZone:zone];
    }
    
    return copy;
}


@end
