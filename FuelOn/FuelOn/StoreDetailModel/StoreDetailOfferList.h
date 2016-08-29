//
//  StoreDetailOfferList.h
//
//  Created by   on 29/08/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface StoreDetailOfferList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *offerName;
@property (nonatomic, strong) NSString *condition;
@property (nonatomic, strong) NSString *offerListIdentifier;
@property (nonatomic, strong) NSString *startDate;
@property (nonatomic, strong) NSString *endDate;
@property (nonatomic, strong) NSString *discountOffer;
@property (nonatomic, strong) NSString *storeId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
