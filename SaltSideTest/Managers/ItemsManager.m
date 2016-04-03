//
//  ItemsManager.m
//  SaltSideTest
//
//  Created by Amresh on 4/2/16.
//  Copyright © 2016 Amresh. All rights reserved.
//

#import "ItemsManager.h"
#import "ItemsCache.h"
#import "JSONHTTPClient.h"
#import "Item.h"

#define apiEndpoint @"https://gist.githubusercontent.com/maclir/f715d78b49c3b4b3b77f/raw/8854ab2fe4cbe2a5919cea97d71b714ae5a4838d/items.json"

@implementation ItemsManager

+ (instancetype)sharedManager {
    static ItemsManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ItemsManager alloc] init];
    });
    
    return instance;
}

- (void)getItemsOnCompletion:(void(^)(NSError* error,NSArray* items))completionBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        //Code to execute on background thread
        
        //Check if a local cache exists or not.
        //If not then download the items list from RDS
        //If the local cache is present,
        //then check when was it created
        //If the local cache was created before a set expiry duration,
        //then re-download the data from RDS and overwrite the local cache,
        //else just read from the local file cache and return the data
        
        void (^gotItems)(NSError*, NSArray *) = ^(NSError* error, NSArray *items){
            dispatch_async(dispatch_get_main_queue(), ^{
                //Code to execute on main thread
                if(completionBlock) {
                    completionBlock(error, items);
                }
            });
        };
        
        if([ItemsCache cacheExists] && ![ItemsCache cacheExpired]) {
            return gotItems(nil, [ItemsCache getItemsFromCache]);
        }
                
        [JSONHTTPClient getJSONFromURLWithString:apiEndpoint completion:^(id json, JSONModelError *err) {
            NSMutableArray *items = @[].mutableCopy;
            [json enumerateObjectsUsingBlock:^(NSDictionary *eachItem, NSUInteger idx, BOOL * _Nonnull stop) {
                Item *item = [[Item alloc] initWithDictionary:eachItem error:nil];
                if(item) {
                    [items addObject:item];
                }
            }];
            [ItemsCache createCacheFor:items];
            return gotItems(err, items);
        }];
    
    });
}
@end
