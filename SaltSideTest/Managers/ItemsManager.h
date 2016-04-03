//
//  ItemsManager.h
//  SaltSideTest
//
//  Created by Amresh on 4/2/16.
//  Copyright © 2016 Amresh. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ItemsManager : NSObject

+ (instancetype)sharedManager;

- (void)getItemsOnCompletion:(void(^)(NSError* error,NSArray* items))completionBlock;
@end
