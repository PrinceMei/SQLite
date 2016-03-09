//
//  Contact.h
//  Sqlite3
//
//  Created by apple on 8/3/16.
//  Copyright © 2016年 mark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

@property (nonatomic, copy) NSString *name;

+ (instancetype)ContactWithName:(NSString *)name;

@end
