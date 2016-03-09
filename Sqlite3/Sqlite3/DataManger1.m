//
//  DataManger1.m
//  Sqlite3
//
//  Created by apple on 8/3/16.
//  Copyright © 2016年 mark. All rights reserved.
//

#import "DataManger1.h"
#import "Contact.h"
#import <sqlite3.h>

static sqlite3 *_db;

@implementation DataManger1

/**
 *  创建数据库和表
 */
+ (void)initialize{
   
    //创建数据库
    
    //获取到Library下Cache文件夹的路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [path stringByAppendingPathComponent:@"contact.sqlite"];
    NSLog(@"%@",filePath);
    //打开数据库
    if (sqlite3_open(filePath.UTF8String, &_db) == SQLITE_OK) {
        NSLog(@"数据库打开成功");
    }else{
        NSLog(@"数据库打开失败");
    }
    //创建表
    NSString *sql = @"create table if not exists t_contact(id integer primary key autoincrement,name text);";
    char *err = nil;
    sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &err);
    
    if (err) {
        NSLog(@"创建表失败");
    }else{
        NSLog(@"创建表成功");
    }
}
//判断sql语句是否正确
+ (BOOL)execSql:(NSString *)sql
{
    BOOL flag;
    char *err;
    
    sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &err);
    if (err) {
        flag = NO;
        NSLog(@"%s",err);
    }else{
        flag = YES;
    }
    return flag;
}
//保存到数据库
+ (void)saveDataWithContact:(Contact *)contact{

    NSString *sql = [NSString stringWithFormat:@"insert into t_contact (name) values ('%@');",contact.name];
    BOOL flag = [self execSql:sql];
    if (flag) {
        NSLog(@"插入数据成功");
    }else{
        NSLog(@"插入数据失败");
    }

}
//查询所有的数据
+ (NSArray *)contact{

    return [self contactSQL:@"select *from t_contact"];
}

//查询
+ (NSArray *)contactSQL:(NSString *)sql
{
    NSMutableArray *array = [NSMutableArray array];
    sqlite3_stmt *stmt;//辅助数据结构类型
    //解析sql语句,解析完成以后放在辅助结构里
    if (sqlite3_prepare_v2(_db, sql.UTF8String, -1, &stmt, NULL) == SQLITE_OK) {
        //查询数据
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NSString *name = [NSString stringWithUTF8String:sqlite3_column_text(stmt, 1)];
            Contact *c = [Contact ContactWithName:name];
            [array addObject:c];
        }
    }
    return array;
}

//sqlite3_prepare_v2(
//                   sqlite3 *db,            /* Database handle */
//                   const char *zSql,       /* SQL statement, UTF-8 encoded */
//                   int nByte,              /* Maximum length of zSql in bytes. */ -1默认自动计算sql长度
//                   sqlite3_stmt **ppStmt,  /* OUT: Statement handle */
//                   const char **pzTail     /* OUT: Pointer to unused portion of zSql */
//);


//sqlite3_column_text(sqlite3_stmt*, int iCol) 字段什么类型，使用什么
//这个过程从执行sqlite3_step()执行一个准备语句得到的结果集的当前行中返回一个列
//第一个参数为从sqlite3_prepare返回来的prepared statement对象的指针，第二参数指定这一行中的想要被返回的列的索引




@end
