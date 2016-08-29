//
//  FFConfiguration.h
//  FabFurnish
//
//  Created by Pankaj Yadav on 06/05/15.
//  Copyright (c) 2015 Bluerock eServices Pvt Ltd. All rights reserved.
//

#ifndef FabFurnish_FFConfiguration_h
#define FabFurnish_FFConfiguration_h

#define FB_ID_STAGING       "114447245421073"
#define FB_ID_LIVE          "494369847278857"

static NSString * const kClientId = @"497795036266-m9dkr2rteplki4qp3a4s78vvrm05hdik.apps.googleusercontent.com";

#pragma mark - Google analytics

//static NSString *const kGaPropertyId = @"UA-29649891-3";    //Live Key

static NSString *const kGaPropertyId = @"UA-29649891-8";  //Staging Key

//static NSString *const kGaPropertyId = @"UA-60600474-2";  //QA Key        //UA-71637986-1 for pankaj.yadav@fabfurnish

// |**** Other GA Configs *****|
static int const kGaDispatchPeriod = 30;
static BOOL const kGaDryRun = NO;


//TODO: For app store build :- AAad3a5676b6cfe8452565caae31371f9a239a3769 value needs to be added in new relic script as well in build phases.
#define NEW_RELIC_ID        @""

#define FF_ITUNES_APP_ID    @"1013752796"

static const DDLogLevel ddLogLevel = DDLogLevelDebug;

#endif
