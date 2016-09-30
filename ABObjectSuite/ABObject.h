//
//  ABObject.h
//  ABObject
//
//  Created by Ash Bhat on 9/30/16.
//  Copyright © 2016 Ash Bhat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABObject : NSObject
@property (nonatomic, copy, readonly, getter=getDictionaryRepresentation)NSMutableDictionary *dictionaryRepresentation;
@property (nonatomic, copy, readonly, getter=getObjectId) NSString *objectId;

- (NSString *)getClassName;
- (NSDictionary *)getDictionaryRepresentation;
+ (instancetype)objectWithClassName:(NSString *)className;
+ (instancetype)objectWithClassName:(NSString *)className andSaveRoute:(NSString *)saveRoute;
- (instancetype)initObjectWithClassName:(NSString *)className andSaveRoute:(NSString *)saveRoute;
- (void)updateValuesWithProperties:(NSDictionary *)properties;
- (id)objectForKeyedSubscript:(NSString *)key;
- (void)setObject:(id)obj forKeyedSubscript:(NSString *)key;
-(void)setSaveRoute:(NSString *)saveRoute;
- (void)saveInBackground;
- (void)saveInBackgroundForRoute:(NSString *)route;
+(void)saveAllInBackground:(NSArray *)objects;
@end
