//
//  ViewController.m
//  Sqlite3
//
//  Created by apple on 8/3/16.
//  Copyright © 2016年 mark. All rights reserved.
//

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#import "ViewController.h"
#import "Contact.h"
#import "DataManger1.h"

@interface ViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ViewController

//懒加载
//给没有接触过或者没用用过懒加载的童鞋们科普一下，懒加载跟tableView的cell复用作用相同
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenW, ScreenH - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UISearchBar *search = [[UISearchBar alloc] init];
    search.placeholder = @"请输入想查询的内容";
    self.navigationItem.titleView = search;
    search.delegate = self;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(AddNewName)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.view addSubview:self.tableView];
    
}
//随机生成模拟数据
- (void)AddNewName{
    
    NSArray *array = @[@"张三",@"李四",@"王五",@"赵六"];
    
    NSString *name = [NSString stringWithFormat:@"%d-%@-%d",arc4random_uniform(10000),array[arc4random()%array.count],arc4random_uniform(10000)];
    Contact *contact = [Contact ContactWithName:name];
    [DataManger1 saveDataWithContact:contact];
    [self.dataArray addObject:contact];
    [self.tableView reloadData];
}


#pragma mark ---<UISearchBarDelegate>
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
 
    NSString *sql = [NSString stringWithFormat:@"select * from t_contact where name like '%%%@%%';",searchText];
    self.dataArray = (NSMutableArray *)[DataManger1 contactSQL:sql];
    [self.tableView reloadData];

}

#pragma mark ---<UITableViewDataSource,UITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *CellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    Contact *c = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = c.name;
    return cell;
}


@end
