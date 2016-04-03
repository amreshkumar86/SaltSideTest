//
//  ItemsTableCell.m
//  SaltSideTest
//
//  Created by Amresh on 4/2/16.
//  Copyright © 2016 Amresh. All rights reserved.
//

#import "ItemsTableCell.h"
#import "UIImageView+WebCache.h"
@interface ItemsTableCell()
{
    IBOutlet UIImageView *itemImage;
    IBOutlet UILabel *itemName, *itemDescription;
}

@end

@implementation ItemsTableCell

- (void)loadItem:(Item*)item {
    
    itemName.text = item.itemName;
    itemName.lineBreakMode = NSLineBreakByWordWrapping;
    itemName.numberOfLines = 0;
    itemDescription.text = item.itemDescription;
    [itemImage sd_setImageWithURL:[NSURL URLWithString:item.itemImageURL]];
}
@end
