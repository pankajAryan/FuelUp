//
//  HomeMapStoreModelBaseClass.h
//
//  Created by   on 29/08/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HomeMapStoreModelBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *responseObject;
@property (nonatomic, strong) NSString *errorMessage;
@property (nonatomic, assign) double errorCode;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
