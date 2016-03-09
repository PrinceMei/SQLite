//
//  DataManger1.h
//  Sqlite3
//
//  Created by apple on 8/3/16.
//  Copyright © 2016年 mark. All rights reserved.
//  原始的sqlite

#import <Foundation/Foundation.h>

@class Contact;
@interface DataManger1 : NSObject

/**
 *  添加到数据库
 *
 *  @param contact 数据模型(可根据自己的需求来建)
 */
+ (void)saveDataWithContact:(Contact *)contact;
/**
 *  查询所有的数据库数据
 *
 *  @return 返回一个模型数组
 */
+ (NSArray *)contact;
/**
 *  查询数据根据SQL
 *
 *  @param sql sql语句
 *
 *  @return 返回一个模型数组
 */
+(NSArray *)contactSQL:(NSString *)sql;



@end
