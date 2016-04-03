//
//  ItemDetailViewController.m
//  SaltSideTest
//
//  Created by Amresh on 4/2/16.
//  Copyright © 2016 Amresh. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "Item.h"
#import "UIImageView+WebCache.h"

@interface ItemDetailViewController()
{
    UILabel *dummyLabel;
    UIFont *font;
}
@end

@implementation ItemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    font = [UIFont systemFontOfSize:18];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.item ? 3 : 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    if(indexPath.row == 0) {
        //Image
        static NSString *cellIdentifier = @"itemImageCellIdentifier";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectInset(cell.bounds, 20, 20)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.item.itemImageURL]];
        [cell.contentView addSubview:imageView];
    }
    else if(indexPath.row == 1) {
        //Title
        static NSString *cellIdentifier = @"itemTitleCellIdentifier";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.textLabel.text = self.item.itemName;
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = font;
    }
    else if(indexPath.row == 2) {
        //Description
        static NSString *cellIdentifier = @"itemDescriptionCellIdentifier";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.textLabel.text = self.item.itemDescription;//[@"Description:\n" stringByAppendingString:self.item.itemDescription];
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = font;
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 44.0f;
    
    if(indexPath.row == 0) {
        height = 250;
    }
    else if(indexPath.row == 1) {
        height = [self getHeightForText:self.item.itemName withFont:font andWidth:self.tableView.bounds.size.width - 100];
    }
    else if(indexPath.row == 2) {
        height = [self getHeightForText:self.item.itemDescription withFont:font andWidth:self.tableView.bounds.size.width - 100];
    }
    return height;
}


-(float) getHeightForText:(NSString*) text withFont:(UIFont*) _font andWidth:(float) width{
    CGSize constraint = CGSizeMake(width , 20000.0f);
    CGSize title_size;
    float totalHeight;
    
    title_size = [text boundingRectWithSize:constraint
                                    options:NSStringDrawingUsesLineFragmentOrigin
                                 attributes:@{ NSFontAttributeName : font }
                                    context:nil].size;
    
    totalHeight = ceil(title_size.height);
    
    CGFloat height = MAX(totalHeight, 40.0f);
    return height;
}
@end
