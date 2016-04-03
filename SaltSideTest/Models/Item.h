//
//  Item.h
//  SaltSideTest
//
//  Created by Amresh on 4/2/16.
//  Copyright © 2016 Amresh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Item : JSONModel

@property(nonatomic, copy)NSString *itemName;
@property(nonatomic, copy)NSString *itemDescription;
@property(nonatomic, copy)NSString *itemImageURL;
@end
