//
//  HomeMapStoreModelResponseObject.h
//
//  Created by   on 29/08/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HomeMapStoreModelResponseObject : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSArray *productList;
@property (nonatomic, strong) NSString *responseObjectIdentifier;
@property (nonatomic, strong) NSString *lon;
@property (nonatomic, strong) NSString *brand;
@property (nonatomic, strong) NSString *isPremium;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) id offerList;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
