//
//  ItemsTableCell.h
//  SaltSideTest
//
//  Created by Amresh on 4/2/16.
//  Copyright © 2016 Amresh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
@interface ItemsTableCell : UITableViewCell

- (void)loadItem:(Item*)item;
@end
