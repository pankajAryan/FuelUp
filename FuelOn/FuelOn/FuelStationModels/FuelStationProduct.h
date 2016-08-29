//
//  FuelStationProduct.h
//
//  Created by   on 28/08/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface FuelStationProduct : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) id status;
@property (nonatomic, assign) id productName;
@property (nonatomic, strong) NSString *productId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
