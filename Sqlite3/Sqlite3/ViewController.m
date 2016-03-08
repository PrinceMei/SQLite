//
//  ViewController.m
//  Sqlite3
//
//  Created by apple on 8/3/16.
//  Copyright © 2016年 mark. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UISearchBarDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UISearchBar *search = [[UISearchBar alloc] init];
    search.placeholder = @"请输入想查询的内容";
    self.navigationItem.titleView = search;
    search.delegate = self;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(AddNewName)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)AddNewName{
    NSArray *array = @[@"张三",@"李四",@"王五",@"赵六"];
    
    



}


#pragma mark ---<UISearchBarDelegate>
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{



}







@end
