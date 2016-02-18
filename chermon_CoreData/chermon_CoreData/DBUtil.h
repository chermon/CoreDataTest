//
//  DBUtil.h
//  chermon_CoreData
//
//  Created by shuwang on 16/2/1.
//  Copyright © 2016年 chermon. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NSManagedObject;
@interface DBUtil : NSObject

+(DBUtil *)shareDBUtil;
-(BOOL)addDataToTable:(NSString *)tableName withColumnValue:(NSDictionary *)dic;
-(BOOL)deleteDataFromTable:(NSManagedObject *)object;
-(BOOL)updateDataFromTable:(NSDictionary *)dic;
-(NSArray *)selectDataFromTable:(NSString *)tableName withPredicate:(NSPredicate *)predicate orderColumnValue:(NSString*)columnValue orderTypeBool:(BOOL)isAscend;
@end
