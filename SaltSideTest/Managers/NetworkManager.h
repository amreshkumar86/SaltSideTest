//
//  NetworkManager.h
//  SaltSideTest
//
//  Created by Amresh on 4/2/16.
//  Copyright © 2016 Amresh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

+ (instancetype)sharedManager;

- (void)downloadDataFromRemoteURL:(NSURL*)remoteURL onCompleted:(void(^)(NSError* error,id response))completionBlock;
@end
