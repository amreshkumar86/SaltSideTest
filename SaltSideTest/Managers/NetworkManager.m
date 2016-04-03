//
//  NetworkManager.m
//  SaltSideTest
//
//  Created by Amresh on 4/2/16.
//  Copyright © 2016 Amresh. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

+ (instancetype)sharedManager {
    static NetworkManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NetworkManager alloc] init];
    });
    
    return instance;
}

- (void)downloadDataFromRemoteURL:(NSURL *)remoteURL onCompleted:(void (^)(NSError *, id))completionBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
       
        NSError *error = nil;
        NSData *responseData = [[NSData alloc] initWithContentsOfURL:remoteURL
                                                             options:NSDataReadingUncached
                                                               error:&error];
        
        //Code to execute on background thread
        dispatch_async(dispatch_get_main_queue(), ^{
            //Code to execute on main thread
            if(completionBlock) {
                completionBlock(error, responseData);
            }
        });
    });
}
@end
