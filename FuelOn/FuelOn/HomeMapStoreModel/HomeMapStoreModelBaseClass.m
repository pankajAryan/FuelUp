//
//  HomeMapStoreModelBaseClass.m
//
//  Created by   on 29/08/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "HomeMapStoreModelBaseClass.h"
#import "HomeMapStoreModelResponseObject.h"


NSString *const kHomeMapStoreModelBaseClassResponseObject = @"responseObject";
NSString *const kHomeMapStoreModelBaseClassErrorMessage = @"errorMessage";
NSString *const kHomeMapStoreModelBaseClassErrorCode = @"errorCode";


@interface HomeMapStoreModelBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HomeMapStoreModelBaseClass

@synthesize responseObject = _responseObject;
@synthesize errorMessage = _errorMessage;
@synthesize errorCode = _errorCode;


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
    NSObject *receivedHomeMapStoreModelResponseObject = [dict objectForKey:kHomeMapStoreModelBaseClassResponseObject];
    NSMutableArray *parsedHomeMapStoreModelResponseObject = [NSMutableArray array];
    if ([receivedHomeMapStoreModelResponseObject isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedHomeMapStoreModelResponseObject) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedHomeMapStoreModelResponseObject addObject:[HomeMapStoreModelResponseObject modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedHomeMapStoreModelResponseObject isKindOfClass:[NSDictionary class]]) {
       [parsedHomeMapStoreModelResponseObject addObject:[HomeMapStoreModelResponseObject modelObjectWithDictionary:(NSDictionary *)receivedHomeMapStoreModelResponseObject]];
    }

    self.responseObject = [NSArray arrayWithArray:parsedHomeMapStoreModelResponseObject];
            self.errorMessage = [self objectOrNilForKey:kHomeMapStoreModelBaseClassErrorMessage fromDictionary:dict];
            self.errorCode = [[self objectOrNilForKey:kHomeMapStoreModelBaseClassErrorCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForResponseObject] forKey:kHomeMapStoreModelBaseClassResponseObject];
    [mutableDict setValue:self.errorMessage forKey:kHomeMapStoreModelBaseClassErrorMessage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.errorCode] forKey:kHomeMapStoreModelBaseClassErrorCode];

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

    self.responseObject = [aDecoder decodeObjectForKey:kHomeMapStoreModelBaseClassResponseObject];
    self.errorMessage = [aDecoder decodeObjectForKey:kHomeMapStoreModelBaseClassErrorMessage];
    self.errorCode = [aDecoder decodeDoubleForKey:kHomeMapStoreModelBaseClassErrorCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_responseObject forKey:kHomeMapStoreModelBaseClassResponseObject];
    [aCoder encodeObject:_errorMessage forKey:kHomeMapStoreModelBaseClassErrorMessage];
    [aCoder encodeDouble:_errorCode forKey:kHomeMapStoreModelBaseClassErrorCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    HomeMapStoreModelBaseClass *copy = [[HomeMapStoreModelBaseClass alloc] init];
    
    if (copy) {

        copy.responseObject = [self.responseObject copyWithZone:zone];
        copy.errorMessage = [self.errorMessage copyWithZone:zone];
        copy.errorCode = self.errorCode;
    }
    
    return copy;
}


@end
