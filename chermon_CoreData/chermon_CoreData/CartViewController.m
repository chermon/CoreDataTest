//
//  CartViewController.m
//  chermon_CoreData
//
//  Created by shuwang on 16/2/2.
//  Copyright © 2016年 chermon. All rights reserved.
//

#import "CartViewController.h"
#import "SortTableViewCell.h"
#import "DBUtil.h"
#import <CoreData/CoreData.h>
@interface CartViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *arrObj;
}
@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    arrObj = [NSMutableArray arrayWithArray:[[DBUtil shareDBUtil]selectDataFromTable:@"CartInfo" withPredicate:nil orderColumnValue:nil orderTypeBool:nil]] ;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if ([[DBUtil shareDBUtil]deleteDataFromTable:[arrObj objectAtIndex:indexPath.row]]) {
            NSLog(@"删除成功");
            [arrObj removeObject:[arrObj objectAtIndex:indexPath.row]];
            [tableView reloadData];
        }
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrObj.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = @"cell";
    SortTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        NSArray *arr = [[NSBundle mainBundle]loadNibNamed:@"SortTableViewCell" owner:self options:nil];
        cell = [arr objectAtIndex:0];
        
    }
    
    NSManagedObject *object = [arrObj objectAtIndex:indexPath.row];
    cell.lbPrice.text = [NSString stringWithFormat:@"%.2f",[[object valueForKeyPath:@"goodsInfo.goods_price"] doubleValue]];
    cell.lbTitle.text = [object valueForKeyPath:@"goodsInfo.goods_name"];
    [cell.imageLogo setImage:[UIImage imageNamed:[object valueForKeyPath:@"goodsInfo.goods_logo"]]];
   
    return cell;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
