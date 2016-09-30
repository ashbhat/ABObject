//
//  ABUser.h
//  ABObject
//
//  Created by Ash Bhat on 9/30/16.
//  Copyright © 2016 Ash Bhat. All rights reserved.
//

#import "ABObject.h"
#import <CoreLocation/CoreLocation.h>

@interface ABUser : ABObject
typedef void (^UserLoginResultCompletion)(ABUser *user, NSError * error);


@property (nonatomic, copy, readonly, getter=getUserId) NSString *userId;
@property (nonatomic, copy, readwrite, getter=getUserName) NSString *userName;
@property (nonatomic, getter=getProfilePicture)NSString *profilePicture;
@property (nonatomic, getter=isConsuming, setter=setConsuming:)BOOL consuming;

-(void)updateLocation:(CLLocation *)location;
+(ABUser *)currentUser;
+(void)loginUserWithParams:(NSDictionary *)params
                     atUrl:(NSString *)urlString
                 withBlock:(UserLoginResultCompletion)completion;

@end
