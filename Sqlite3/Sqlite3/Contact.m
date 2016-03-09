//
//  Contact.m
//  Sqlite3
//
//  Created by apple on 8/3/16.
//  Copyright © 2016年 mark. All rights reserved.
//

#import "Contact.h"

@implementation Contact

+ (instancetype)ContactWithName:(NSString *)name{
    
    Contact *contact = [[Contact alloc] init];
    contact.name = name;
    
    return contact;
}



@end
