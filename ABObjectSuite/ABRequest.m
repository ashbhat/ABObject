
//  ABRequest.m
//  Tetherball
//
//  Created by Ash Bhat on 3/18/15.
//  Copyright (c) 2015 Ash Bhat. All rights reserved.
//

#import "ABRequest.h"

@implementation ABRequest
#pragma mark - POST

+(void)postWithParametersAndValuesDict:(NSDictionary *)parameters URLString:(NSString *)URLString andHeaders:(NSDictionary *)headers withBlockSuccess:(ABSuccess)success orFailure:(ABFailure)failure{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    NSURL * url = [NSURL URLWithString:URLString];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:parameters
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];

    for (NSString *key in [headers allKeys]) {
        [urlRequest setValue:headers[key] forHTTPHeaderField:key];
    }
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:jsondata];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                           if(error == nil)
                                                           {
                                                               id returnedObject = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableLeaves error:nil];
                                                               success(returnedObject);
                                                           }
                                                           else{
                                                               NSLog(@"error %@",error.description);
                                                               failure(error, nil);
                                                           }
                                                       }];
    [dataTask resume];

}

#pragma mark - PUT

+(void)putWithParametersAndValuesDict:(NSDictionary *)parameters URLString:(NSString *)URLString andHeaders:(NSDictionary *)headers withBlockSuccess:(ABSuccess)success orFailure:(ABFailure)failure{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    NSURL * url = [NSURL URLWithString:URLString];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:parameters
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    for (NSString *key in [headers allKeys]) {
        [urlRequest setValue:headers[key] forHTTPHeaderField:key];
    }
    
    [urlRequest setHTTPMethod:@"PUT"];
    [urlRequest setHTTPBody:jsondata];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                           if(error == nil)
                                                           {
                                                               id returnedObject = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableLeaves error:nil];
                                                               success(returnedObject);
                                                           }
                                                           else{
                                                               NSLog(@"error %@",error.description);
                                                               failure(error, nil);
                                                           }
                                                       }];
    [dataTask resume];
}

#pragma mark - GET

+(void)getWithURLString:(NSString *)URLString andHeaders:(NSDictionary *)headers withBlockSuccess:(ABSuccess)success orFailure:(ABFailure)failure{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    NSURL * url = [NSURL URLWithString:URLString];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    for (NSString *key in [headers allKeys]) {
        [urlRequest setValue:headers[key] forHTTPHeaderField:key];
    }
    
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                           if(error == nil)
                                                           {
                                                               id returnedObject = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableLeaves error:nil];
                                                               success(returnedObject);
                                                           }
                                                           else{
                                                               NSLog(@"error %@",error.description);
                                                               failure(error, nil);
                                                           }
                                                       }];
    [dataTask resume];
}


@end
