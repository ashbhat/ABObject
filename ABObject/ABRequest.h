//
//  ABRequest.h
//  Tetherball
//
//  Created by Ash Bhat on 3/18/15.
//  Copyright (c) 2015 Ash Bhat. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^ABSuccess)(id responseObject);
typedef void(^ABFailure)(NSError *error, id responseObject);

@interface ABRequest : NSObject

#pragma mark - POST

+(void)postWithParametersAndValuesDict:(NSDictionary *)parameters
                             URLString:(NSString *)URLString
                            andHeaders:(NSDictionary *)headers
                      withBlockSuccess:(ABSuccess)success
                             orFailure:(ABFailure)failure;

#pragma mark - PUT

+(void)putWithParametersAndValuesDict:(NSDictionary *)parameters
                            URLString:(NSString *)URLString
                           andHeaders:(NSDictionary *)headers
                     withBlockSuccess:(ABSuccess)success orFailure:(ABFailure)failure;

#pragma mark - GET

+(void)getWithURLString:(NSString *)URLString
             andHeaders:(NSDictionary *)headers
       withBlockSuccess:(ABSuccess)success
              orFailure:(ABFailure)failure;

@end
