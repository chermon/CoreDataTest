//
//  DBUtil.m
//  chermon_CoreData
//
//  Created by shuwang on 16/2/1.
//  Copyright © 2016年 chermon. All rights reserved.
//

#import "DBUtil.h"
#import <CoreData/CoreData.h>

static DBUtil *singInstance;
@interface DBUtil ()

@property (nonatomic , strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation DBUtil

+(DBUtil *)shareDBUtil{
    @synchronized(self) {
        if (singInstance == nil) {
            
            singInstance = [[DBUtil alloc]init];
            
            //获取document目录
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
            NSString *documentPath = [paths objectAtIndex:0];
            
            //从应用程序包中加载模型文件
            NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
            //初始化NSPersistentStoreCoordinator，传入模型对象
            NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
            //构建SQLite数据库文件的路径
            NSURL *url = [NSURL fileURLWithPath:[documentPath stringByAppendingString:@"test.data"]];
            
            NSError *error = nil;
            
            //增加持久化存储库，这里使用sqlite为存储库
            NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
            if (store == nil) {//直接抛出异常
                [NSException raise:@"访问数据库错误" format:@"%@",[error localizedDescription]];
            }
            //初始化上下文，设置persistentStoreCoredinator
            singInstance.managedObjectContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
            singInstance.managedObjectContext.persistentStoreCoordinator = psc;
            
        }
    }
    
    
    return singInstance;
}

/** 增加数据**/
-(BOOL)addDataToTable:(NSString *)tableName withColumnValue:(NSDictionary *)dic{
    //传入上下文，创建一个实体对象
    NSManagedObject *obj = [NSEntityDescription insertNewObjectForEntityForName:tableName inManagedObjectContext:_managedObjectContext];
    //设置实体对象的属性
    for (id key in dic) {
        [obj setValue:[dic objectForKey:key] forKey:key];
    }
    
    NSError *error = nil;
    
    //利用上下文将数据同步到持久化存储库
    BOOL success = [_managedObjectContext save:&error];
    if (!success) {
        [NSException raise:@"增加数据失败" format:@"%@",[error localizedDescription]];
    }
    return success;
}

/**删除数据**/
-(BOOL)deleteDataFromTable:(NSManagedObject *)object{
    //利用上下文删除对象
    [_managedObjectContext deleteObject:object];
    
    NSError *error = nil;
    
    BOOL success = [_managedObjectContext save:&error];
    if (!success) {
        [NSException raise:@"删除数据失败" format:@"%@",[error localizedDescription]];
        
    }
    return success;
}

/**更改数据**/
-(BOOL)updateDataFromTable:(NSDictionary *)dic{
    
    NSError *error = nil;
    
    BOOL success = [_managedObjectContext save:&error];
    if (!success) {
        [NSException raise:@"更新数据失败" format:@"%@",[error localizedDescription]];
    }
    return success;
}

-(NSArray *)selectDataFromTable:(NSString *)tableName withPredicate:(NSPredicate *)predicate orderColumnValue:(NSString*)columnValue orderTypeBool:(BOOL)isAscend{
    //初始化一个查询请求
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    //设置要查询的实体
    request.entity = [NSEntityDescription entityForName:tableName inManagedObjectContext:_managedObjectContext];
    //设置条件过滤
    request.predicate = predicate;
    
    //判断是否排序
    if (columnValue !=nil && ![columnValue isEqualToString:@""]) {
        //设置排序
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:columnValue ascending:isAscend];
        request.sortDescriptors = [NSArray arrayWithObject:sort];
    }
  
    NSError *error = nil;
    
    NSArray *objectArr = [_managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询数据失败" format:@"%@",[error localizedDescription]];
        return nil;
        
    }
    
    return objectArr;
    
}
@end
