//
//  AppDelegate.m
//  chermon_CoreData
//
//  Created by shuwang on 16/2/1.
//  Copyright © 2016年 chermon. All rights reserved.
//

#import "AppDelegate.h"
#import "DBUtil.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isSave"]) {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isSave"];
        [[DBUtil shareDBUtil]addDataToTable:@"GoodsInfo" withColumnValue:@{@"goods_logo":@"手机数码2logo.jpg",@"goods_name":@"Coolpad/酷派 大神Note3全网通5.5英寸8核指纹手机移动联通电信版",@"goods_price":@1099.00}];
        [[DBUtil shareDBUtil]addDataToTable:@"GoodsInfo" withColumnValue:@{@"goods_logo":@"手机数码3logo.jpg",@"goods_name":@"乐帆F1 PPT翻页笔 演讲演示器 电子教鞭 多媒体教学遥控笔 电子笔",@"goods_price":@99.00}];
        [[DBUtil shareDBUtil]addDataToTable:@"GoodsInfo" withColumnValue:@{@"goods_logo":@"手机数码1logo.jpg",@"goods_name":@"Apple/苹果 13 英寸:MacBook Air 256GB",@"goods_price":@4748.00}];
        
        
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
