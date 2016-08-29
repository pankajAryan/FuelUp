//
//  FuelStationBaseClass.h
//
//  Created by   on 28/08/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FuelStationBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double errorCode;
@property (nonatomic, strong) NSString *errorMessage;
@property (nonatomic, strong) NSArray *responseObject;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
