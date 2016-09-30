//
//  ABUser.m
//  ABObject
//
//  Created by Ash Bhat on 9/30/16.
//  Copyright © 2016 Ash Bhat. All rights reserved.
//

#import "ABUser.h"
#import "ABRequest.h"
@interface ABUser()

@end

@implementation ABUser

-(instancetype)init{
    self = [super initObjectWithClassName:@"user" andSaveRoute:[NSString stringWithFormat:@"%@/user/",@"https://yoururl.com"]];
    return self;
}

-(NSString*)getUserId{
    return self[@"id"];
}

-(NSString*)getUserName{
    return self[@"name"];
}

-(NSString*)getProfilePicture{
    return self.dictionaryRepresentation[@"profile_pic"];
}

-(void)updateLocation:(CLLocation *)location{
    //update user location
    self[@"latitude"] = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    self[@"longitude"] = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    [self saveInBackground];
}

+(ABUser *)currentUser{
    return [ABUser setUpCurrentUserWithLoginResponse:nil andSaveRoute:nil];
}

+(ABUser *)setUpCurrentUserWithLoginResponse:(NSDictionary *)response andSaveRoute:(NSString *)saveRoute{
    static dispatch_once_t p = 0;
    __strong static ABUser *_currentUser = nil;
        dispatch_once(&p, ^{
        _currentUser = [[self alloc] init];
    });
    if (response) {
        [_currentUser updateValuesWithProperties:response];
        [self storeUserValues:_currentUser.dictionaryRepresentation andSaveRoute:saveRoute];
    }
    else if([self getStoredUser]){
        [_currentUser updateValuesWithProperties:[self getStoredUser]];
        [_currentUser setSaveRoute:[self getStoredRoute]];
    }
    if ([_currentUser getUserId]) {
        return _currentUser;
    }
    NSLog(@"You haven't logged in yet. Please log in to be able to access current user");
    return nil;
}

+(void)storeUserValues:(NSDictionary *)userValues andSaveRoute:(NSString *)saveRoute {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userValues forKey:@"user"];
    [defaults setObject:saveRoute forKey:@"saveRoute"];
    [defaults synchronize];
}

+(NSDictionary *)getStoredUser {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"user"];
}

+(NSString *)getStoredRoute {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"saveRoute"];
}


+(void)loginUserWithParams:(NSDictionary *)params
                     atUrl:(NSString *)urlString
                 withBlock:(UserLoginResultCompletion)completion
{
    [ABRequest postWithParametersAndValuesDict:params
                                     URLString:urlString
                                    andHeaders:@{}
                              withBlockSuccess:^(id responseObject) {
                                  ABUser *currentUser = [ABUser setUpCurrentUserWithLoginResponse:responseObject andSaveRoute:urlString];
                                  [currentUser setSaveRoute:urlString];
                                  completion(currentUser, nil);
                              } orFailure:^(NSError *error, id responseObject) {
                                  completion(responseObject, error);
                              }];
}

@end
