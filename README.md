# ABObjectSuite

ABUser / ABObject work similar to PFUser / PFObjects from Parse but w/ your own server

Best description / use instructions are in the ViewController.m - Copied below for your convenience
```objective-c
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
    /**
    === console log ===
    ABObject<user>:{
      id = 5;
      name = "Ash Bhat";
      provider = facebook;
    }
    **/
}

-(void)genericObjectExample{
    ABObject *someObject = [ABObject objectWithClassName:@"Test" andSaveRoute:@"http://yourUrl.com/test"];
    someObject[@"foo"] = @"bar";
    someObject[@"har"] = @"ambe";
    NSLog(@"%@", someObject[@"foo"]);
    /**
    === console log ===
    bar
    **/
    [someObject saveInBackground];
}

-(void)loginUserExample{
    [ABUser loginUserWithParams:@{@"username" : @"Chuck", @"password" : @"norris"} atUrl:@"http://yourUrl.com/user" withBlock:^(ABUser *user, NSError *error) {
        user[@"device"] = @"ios";
        [user saveInBackground];
    }];
}

```

TODOS: need to make cocoapod