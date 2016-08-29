//
//  FuelStationBaseClass.m
//
//  Created by   on 28/08/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "FuelStationBaseClass.h"
#import "FuelStationResponseObject.h"


NSString *const kFuelStationBaseClassErrorCode = @"errorCode";
NSString *const kFuelStationBaseClassErrorMessage = @"errorMessage";
NSString *const kFuelStationBaseClassResponseObject = @"responseObject";


@interface FuelStationBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FuelStationBaseClass

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
            self.errorCode = [[self objectOrNilForKey:kFuelStationBaseClassErrorCode fromDictionary:dict] doubleValue];
            self.errorMessage = [self objectOrNilForKey:kFuelStationBaseClassErrorMessage fromDictionary:dict];
    NSObject *receivedFuelStationResponseObject = [dict objectForKey:kFuelStationBaseClassResponseObject];
    NSMutableArray *parsedFuelStationResponseObject = [NSMutableArray array];
    if ([receivedFuelStationResponseObject isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedFuelStationResponseObject) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedFuelStationResponseObject addObject:[FuelStationResponseObject modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedFuelStationResponseObject isKindOfClass:[NSDictionary class]]) {
       [parsedFuelStationResponseObject addObject:[FuelStationResponseObject modelObjectWithDictionary:(NSDictionary *)receivedFuelStationResponseObject]];
    }

    self.responseObject = [NSArray arrayWithArray:parsedFuelStationResponseObject];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.errorCode] forKey:kFuelStationBaseClassErrorCode];
    [mutableDict setValue:self.errorMessage forKey:kFuelStationBaseClassErrorMessage];
    NSMutableArray *tempArrayForResponseObject = [NSMutableArray array];
    for (NSObject *subArrayObject in self.responseObject) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForResponseObject addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForResponseObject addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForResponseObject] forKey:kFuelStationBaseClassResponseObject];

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

    self.errorCode = [aDecoder decodeDoubleForKey:kFuelStationBaseClassErrorCode];
    self.errorMessage = [aDecoder decodeObjectForKey:kFuelStationBaseClassErrorMessage];
    self.responseObject = [aDecoder decodeObjectForKey:kFuelStationBaseClassResponseObject];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_errorCode forKey:kFuelStationBaseClassErrorCode];
    [aCoder encodeObject:_errorMessage forKey:kFuelStationBaseClassErrorMessage];
    [aCoder encodeObject:_responseObject forKey:kFuelStationBaseClassResponseObject];
}

- (id)copyWithZone:(NSZone *)zone
{
    FuelStationBaseClass *copy = [[FuelStationBaseClass alloc] init];
    
    if (copy) {

        copy.errorCode = self.errorCode;
        copy.errorMessage = [self.errorMessage copyWithZone:zone];
        copy.responseObject = [self.responseObject copyWithZone:zone];
    }
    
    return copy;
}


@end
