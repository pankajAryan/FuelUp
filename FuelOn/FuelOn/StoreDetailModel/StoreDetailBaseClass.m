//
//  StoreDetailBaseClass.m
//
//  Created by   on 29/08/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "StoreDetailBaseClass.h"
#import "StoreDetailResponseObject.h"


NSString *const kStoreDetailBaseClassErrorCode = @"errorCode";
NSString *const kStoreDetailBaseClassErrorMessage = @"errorMessage";
NSString *const kStoreDetailBaseClassResponseObject = @"responseObject";


@interface StoreDetailBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation StoreDetailBaseClass

@synthesize errorCode = _errorCode;
@synthesize errorMessage = _errorMessage;
@synthesize responseObject = _responseObject;


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
            self.errorCode = [[self objectOrNilForKey:kStoreDetailBaseClassErrorCode fromDictionary:dict] doubleValue];
            self.errorMessage = [self objectOrNilForKey:kStoreDetailBaseClassErrorMessage fromDictionary:dict];
            self.responseObject = [StoreDetailResponseObject modelObjectWithDictionary:[dict objectForKey:kStoreDetailBaseClassResponseObject]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.errorCode] forKey:kStoreDetailBaseClassErrorCode];
    [mutableDict setValue:self.errorMessage forKey:kStoreDetailBaseClassErrorMessage];
    [mutableDict setValue:[self.responseObject dictionaryRepresentation] forKey:kStoreDetailBaseClassResponseObject];

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

    self.errorCode = [aDecoder decodeDoubleForKey:kStoreDetailBaseClassErrorCode];
    self.errorMessage = [aDecoder decodeObjectForKey:kStoreDetailBaseClassErrorMessage];
    self.responseObject = [aDecoder decodeObjectForKey:kStoreDetailBaseClassResponseObject];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_errorCode forKey:kStoreDetailBaseClassErrorCode];
    [aCoder encodeObject:_errorMessage forKey:kStoreDetailBaseClassErrorMessage];
    [aCoder encodeObject:_responseObject forKey:kStoreDetailBaseClassResponseObject];
}

- (id)copyWithZone:(NSZone *)zone
{
    StoreDetailBaseClass *copy = [[StoreDetailBaseClass alloc] init];
    
    if (copy) {

        copy.errorCode = self.errorCode;
        copy.errorMessage = [self.errorMessage copyWithZone:zone];
        copy.responseObject = [self.responseObject copyWithZone:zone];
    }
    
    return copy;
}


@end
