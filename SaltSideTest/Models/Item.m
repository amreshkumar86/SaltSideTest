//
//  Item.m
//  SaltSideTest
//
//  Created by Amresh on 4/2/16.
//  Copyright © 2016 Amresh. All rights reserved.
//

#import "Item.h"

@implementation Item

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"title": @"itemName",
                                                       @"description": @"itemDescription",
                                                       @"image": @"itemImageURL"
                                                       }];
}
@end
