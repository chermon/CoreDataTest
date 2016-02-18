//
//  ViewController.m
//  chermon_CoreData
//
//  Created by shuwang on 16/2/1.
//  Copyright © 2016年 chermon. All rights reserved.
//

#import "ViewController.h"
#import "SortTableViewCell.h"
#import "DBUtil.h"
#import <CoreData/CoreData.h>
#import "CartViewController.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *arrObj;
    double allPrice;
    int allGoodsNum;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    arrObj = [[DBUtil shareDBUtil]selectDataFromTable:@"GoodsInfo" withPredicate:nil orderColumnValue:nil orderTypeBool:nil];
    
    UIButton *btnEnterCart = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [btnEnterCart addTarget:self action:@selector(enterCartAction) forControlEvents:UIControlEventTouchUpInside ];
    [btnEnterCart setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal ];
    [btnEnterCart setTitle:@"购物车" forState:UIControlStateNormal];
    [btnEnterCart setBackgroundColor:[UIColor orangeColor]];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc]initWithCustomView:btnEnterCart];
    
    self.navigationItem.rightBarButtonItem = btnItem;
    
    
}

-(void)enterCartAction{
    CartViewController *cartController = [[CartViewController alloc]init];
    [self.navigationController pushViewController:cartController animated:YES];
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
    cell.lbPrice.text = [NSString stringWithFormat:@"%.2f",[[object valueForKey:@"goods_price"] doubleValue]];
    cell.lbTitle.text = [object valueForKey:@"goods_name"];
    [cell.imageLogo setImage:[UIImage imageNamed:[object valueForKey:@"goods_logo"]]];
    [cell.btnAdd addTarget:self action:@selector(addCartAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnAdd.tag = indexPath.row;
    return cell;
    
}

-(void)addCartAction:(UIButton *)sender{
    NSManagedObject *object = [arrObj objectAtIndex:sender.tag];
    allPrice = allPrice+[[object valueForKey:@"goods_price"] doubleValue];
    allGoodsNum += 1;
   
    if ( [[DBUtil shareDBUtil]addDataToTable:@"CartInfo" withColumnValue:@{@"cartPrice":[NSNumber numberWithDouble:allPrice],@"cartNum":[NSNumber numberWithInt:allGoodsNum],@"goodsInfo":object}]) {
        NSLog(@"加入购物车成功！");
    }else{
        NSLog(@"加入购物车失败！");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
