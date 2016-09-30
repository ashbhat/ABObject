//
//  ViewController.m
//  ABObject
//
//  Created by Ash Bhat on 9/30/16.
//  Copyright © 2016 Ash Bhat. All rights reserved.
//

#import "ViewController.h"
#import "ABUser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //this example has a generic ABObject. Add, retrieve, save are all demoed
    [self genericObjectExample];
    
    //here's an example of logging into an account and creating a user object
    [self loginUserExample];
    
    //once logged in, you can call [ABUser currentUser] anywhere to access your user :)
    ABUser *currentUser = [ABUser currentUser];
    
    //in addition the NSLogging of ABObjects is made so you can see what values you're working w/ as opposed to just the memory address
    NSLog(@"%@", currentUser);
    
}

-(void)genericObjectExample{
    ABObject *someObject = [ABObject objectWithClassName:@"Test" andSaveRoute:@"http://yourUrl.com/test"];
    someObject[@"foo"] = @"bar";
    someObject[@"har"] = @"ambe";
    NSLog(@"%@", someObject[@"foo"]);
    [someObject saveInBackground];
}

-(void)loginUserExample{
    [ABUser loginUserWithParams:@{@"username" : @"Chuck", @"password" : @"norris"} atUrl:@"http://yourUrl.com/user" withBlock:^(ABUser *user, NSError *error) {
        //stubbing the response and calling the private method with [self getExampleUser], your implementation wouldn't need this because you'd get a response from your server
        ABUser *exampleUser = [self getExampleUser];
        //works w/ a realUrl
        [exampleUser saveInBackground];
    }];
}


-(ABUser *)getExampleUser{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        ABUser *example = [[ABUser class] performSelector:@selector(setUpCurrentUserWithLoginResponse:andSaveRoute:) withObject:@{@"id" : @5,@"provider" : @"facebook", @"name" : @"Ash Bhat"} withObject:@"http://yourUrl.com/user"];
#pragma clang diagnostic pop
    return example;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
