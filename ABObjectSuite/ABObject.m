//
//  ABObject.m
//  ABObject
//
//  Created by Ash Bhat on 9/30/16.
//  Copyright © 2016 Ash Bhat. All rights reserved.
//

#import "ABObject.h"
#import "ABRequest.h"

@interface ABObject()

@property (nonatomic, copy, readwrite, getter=getObjectId) NSString *objectId;
@property (nonatomic, copy, readwrite) NSString *saveRoute;
@property (nonatomic, copy, readwrite, getter=getDictionaryRepresentation)NSMutableDictionary *dictionaryRepresentation;
@property (nonatomic, copy, readwrite, getter=getClassName)NSString *className;

@end

@implementation ABObject

-(instancetype)init{
    return [ABObject objectWithClassName:@"no_class_name" andSaveRoute:@""];
}

+ (instancetype)objectWithClassName:(NSString *)className{
    return [ABObject objectWithClassName:className andSaveRoute:@""];
}

+ (instancetype)objectWithClassName:(NSString *)className andSaveRoute:(NSString *)saveRoute{
    return [[ABObject alloc] initObjectWithClassName:className andSaveRoute:saveRoute];
}

-(void)setSaveRoute:(NSString *)saveRoute{
    _saveRoute = saveRoute;
}

- (instancetype)initObjectWithClassName:(NSString *)className andSaveRoute:(NSString *)saveRoute{
    if(self = [super init]){
        
    }
    _saveRoute = saveRoute;
    _className = className;
    _dictionaryRepresentation = [NSMutableDictionary new];
    return self;
}

-(NSString *)getClassName{
    return _className;
}

-(NSDictionary *)getDictionaryRepresentation{
    return _dictionaryRepresentation.copy;
}

- (id)objectForKeyedSubscript:(NSString *)key{
    return _dictionaryRepresentation[key];
}

- (void)setObject:(id)obj forKeyedSubscript:(NSString *)key{
    _dictionaryRepresentation[key] = obj;
}
- (void)updateValuesWithProperties:(NSDictionary *)properties{
    NSArray *keys = [properties allKeys];
    for (NSString *key in keys) {
        self[key] = properties[key];
    }
}

- (void)saveInBackground{
    [self saveInBackgroundForRoute:_saveRoute];
}

+(void)saveAllInBackground:(NSArray *)objects{
    for (ABObject *object in objects) {
        [object saveInBackground];
    }
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"ABObject<%@>:%@", self.className, self.dictionaryRepresentation];
}

- (void)saveInBackgroundForRoute:(NSString *)route{
    [ABRequest putWithParametersAndValuesDict:_dictionaryRepresentation URLString:_saveRoute andHeaders:@{} withBlockSuccess:^(id responseObject) {
        NSArray *keys = [responseObject allKeys];
        if (keys.count > 0) {
            NSString *key = keys[0];
            _objectId = responseObject[key][@"id"];
        }
        else{
            if (responseObject[@"id"]) {
                _objectId = responseObject[@"id"];
            }
        }
    } orFailure:^(NSError *error, id responseObject) {
        
    }];
}

@end
