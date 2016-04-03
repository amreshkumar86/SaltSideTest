//
//  ItemsCache.h
//  SaltSideTest
//
//  Created by Amresh on 4/2/16.
//  Copyright © 2016 Amresh. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ItemsCache : NSObject


+ (BOOL)cacheExists;
+ (BOOL)cacheExpired;
+ (BOOL)createCacheFor:(NSArray*)items;
+ (NSArray*)getItemsFromCache;
@end
