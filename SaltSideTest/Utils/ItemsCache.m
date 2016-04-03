//
//  ItemsCache.m
//  SaltSideTest
//
//  Created by Amresh on 4/2/16.
//  Copyright © 2016 Amresh. All rights reserved.
//

#import "ItemsCache.h"
#import "JSONModel.h"
#import "Item.h"

const float cacheDuration = 24*60*60;

#define cacheTimeKey @"CACHE_TIME_KEY"

#define cacheFileName @"LocalItemCache"
#define cacheFileDirectory [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define cacheFilePath [cacheFileDirectory stringByAppendingPathComponent:cacheFileName]

@implementation ItemsCache


+ (BOOL)cacheExists {
    return [[NSFileManager defaultManager] fileExistsAtPath:cacheFilePath];
}

+ (BOOL)cacheExpired {
    long lastCacheTime = [[NSUserDefaults standardUserDefaults] valueForKey:cacheTimeKey] ? [[[NSUserDefaults standardUserDefaults] valueForKey:cacheTimeKey] longValue] : -1;
    return lastCacheTime > 0 ? ([[NSDate date] timeIntervalSince1970] - lastCacheTime) > cacheDuration: YES;
}

+ (BOOL)createCacheFor:(NSArray*)items {
    NSMutableArray *jsonRepresentation = @[].mutableCopy;
    [items enumerateObjectsUsingBlock:^(Item *eachItem, NSUInteger idx, BOOL * _Nonnull stop) {
        [jsonRepresentation addObject:[eachItem toDictionary]];
    }];
    BOOL success = [[NSJSONSerialization dataWithJSONObject:jsonRepresentation options:NSJSONWritingPrettyPrinted error:nil] writeToFile:cacheFilePath atomically:YES];
    
    if(success) {
        [[NSUserDefaults standardUserDefaults] setFloat:[[NSDate date] timeIntervalSince1970] forKey:cacheTimeKey];
    }
    
    return success;
}

+ (NSArray*)getItemsFromCache {
    NSError *error = nil;
    NSData *cacheFileContent = [[NSData alloc] initWithContentsOfFile:cacheFilePath];
    if(!error) {
        NSMutableArray *items = @[].mutableCopy;
        NSArray *itemsDict = [NSJSONSerialization JSONObjectWithData:cacheFileContent options:NSJSONReadingMutableContainers error:nil];
        [itemsDict enumerateObjectsUsingBlock:^(NSDictionary *eachItem, NSUInteger idx, BOOL * _Nonnull stop) {
            Item *item = [[Item alloc] initWithDictionary:eachItem error:nil];
            if(item) {
                [items addObject:item];
            }
        }];
        
        return items;
    }
    
    return nil;
}
@end
