//
//  ItemsViewController.m
//  SaltSideTest
//
//  Created by Amresh on 4/2/16.
//  Copyright © 2016 Amresh. All rights reserved.
//

#import "ItemsViewController.h"
#import "ItemsManager.h"
#import "ItemsTableCell.h"
#import "ItemDetailViewController.h"

@interface ItemsViewController()
{
    NSArray *allItems;
}
@end

@implementation ItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    allItems = @[];
    [[ItemsManager sharedManager] getItemsOnCompletion:^(NSError *error, NSArray *items) {
        if(!error) {
            allItems = items;
            [self.tableView reloadData];
        }
    }];
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCellIdentifier"
                                                           forIndexPath:indexPath];
    
    [cell loadItem:allItems[indexPath.row]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return allItems.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ItemDetailViewController *detailVC = [[ItemDetailViewController alloc] init];
    detailVC.item = allItems[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}
@end
