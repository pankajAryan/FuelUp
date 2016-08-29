//
//  FuelStationResponseObject.h
//
//  Created by   on 28/08/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface FuelStationResponseObject : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSArray *productList;
@property (nonatomic, strong) NSString *responseObjectIdentifier;
@property (nonatomic, strong) NSString *lon;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, assign) id offerList;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phoneNumber;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
