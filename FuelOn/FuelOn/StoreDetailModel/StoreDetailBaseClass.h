//
//  StoreDetailBaseClass.h
//
//  Created by   on 29/08/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StoreDetailResponseObject;

@interface StoreDetailBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double errorCode;
@property (nonatomic, strong) NSString *errorMessage;
@property (nonatomic, strong) StoreDetailResponseObject *responseObject;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
