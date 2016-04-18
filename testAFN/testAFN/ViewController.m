//
//  ViewController.m
//  testAFN
//
//  Created by 李岩 on 15/12/16.
//  Copyright © 2015年 李岩. All rights reserved.
//

#import "ViewController.h"
//#import "AFNetworking.h"
#import "HttpRequestLib.h"
#import "Model.h"
#import "TableViewCell.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong)UITableView * tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataArray = [NSMutableArray array];
    [self createTableView];

    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 50);
    button.backgroundColor = [UIColor yellowColor];
    button.tag = 10;
    [button setTitle:@"清除缓存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(removeAllCached) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    NSLog(@"%@",NSHomeDirectory());
    [self startRequest];
    [self startRequest2];

//    [self AFN];
}

- (void)removeAllCached{
    NSString * url3 = @"http://123.57.222.109:4700/Control.aspx?M=map&GID=tjnk&PN=AQI";
    HttpRequestLib * request = [[HttpRequestLib alloc] init];
    [request reconnectWithUrlString:url3 requestMethod:HTTRequestGET];
//    NSURLCache * cache = [NSURLCache sharedURLCache];
//    [cache removeAllCachedResponses];
//    UIButton * button = (UIButton*)[self.view viewWithTag:10];
//    button.backgroundColor = [UIColor greenColor];
}

#pragma mark TableView相关
- (void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ID"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID" forIndexPath:indexPath];
    
    Model * model = self.dataArray[indexPath.row];
    
    cell.textLabel.text = model.nickName;
    
    return cell;
}

- (void)startRequest{
    NSString * url2 = @"http://api.cutet.cn/keatao/goods/getGoods?page=1";
    NSString * url1 = @"http://www.hczq.com/game/preferIndexLists.do?indexType=0&cp=1&ps=8&orderBy=rankValue&order=DESC";
//    NSString * url11 = [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * url3 = @"http://123.57.222.109:4700/Control.aspx?M=map&GID=tjnk&PN=AQI";
    HttpRequestLib * request = [[HttpRequestLib alloc] init];
    [request initWithUrlString:url3 paramers:nil requestMethod:HTTRequestGET];
    [request sendRequestWithSuccess:^(id successData) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:successData options:NSJSONReadingMutableContainers error:nil];
        NSArray * listArray = dic[@"list"];
//        NSLog(@"%@",dic);
        for (NSDictionary* listDict in listArray) {
            Model * model = [[Model alloc] init];
            [model setValuesForKeysWithDictionary:listDict];
            [_dataArray addObject:model];
        }
//        NSLog(@"%@",_dataArray);
        NSLog(@"加载成功");
        [_tableView reloadData];
    } failure:^(id failureData) {
        NSLog(@"加载失败");
    }];
    



}

- (void)startRequest2{
    NSString * url2 = @"http://api.cutet.cn/keatao/goods/getGoods?page=1";
    NSString * url1 = @"http://www.hczq.com/game/preferIndexLists.do?indexType=0&cp=1&ps=8&orderBy=rankValue&order=DESC";
    //    NSString * url11 = [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * url3 = @"http://123.57.222.109:4700/Control.aspx?M=map&GID=tjnk&PN=AQI";
    HttpRequestLib * request = [[HttpRequestLib alloc] init];
    [request initWithUrlString:url3 paramers:nil requestMethod:HTTRequestGET];
    [request sendSecondRequestWithSuccess:^(id successData) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:successData options:NSJSONReadingMutableContainers error:nil];
        NSArray * listArray = dic[@"list"];
        //        NSLog(@"%@",dic);
        for (NSDictionary* listDict in listArray) {
            Model * model = [[Model alloc] init];
            [model setValuesForKeysWithDictionary:listDict];
            [_dataArray addObject:model];
        }
        //        NSLog(@"%@",_dataArray);
        NSLog(@"加载成功");
        [_tableView reloadData];
    } failure:^(id failureData) {
        NSLog(@"加载失败");
    }];
    
    
    
    
}


- (void)AFN{
    NSString * url2 = @"http://api.cutet.cn/keatao/goods/getGoods?page=1";
    NSString * url1 = @"http://www.hczq.com/game/preferIndexLists.do?indexType=0&cp=1&ps=8&orderBy=rankValue&order=DESC";
    NSString * url11 = [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url11 parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"加载成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"加载失败");
    }];



}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
