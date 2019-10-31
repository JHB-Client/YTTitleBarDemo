//
//  YTHealthHeadListViewController.m
//  YTTitleBarDemo
//
//  Created by admin on 2019/10/28.
//  Copyright © 2019 admin. All rights reserved.
//

#import "YTHealthHeadListViewController.h"
#import "YTHealthHeadListCell.h"
#import "YTHealthHead.h"
@interface YTHealthHeadListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *topInforArr;
@end

@implementation YTHealthHeadListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
    self.topInforArr = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        YTHealthHead *healthHead = [YTHealthHead new];
        healthHead.title = [NSString stringWithFormat:@"我是标题-----%ld", self.vCtrTag];
        healthHead.hospital = @"我是医院名字";
        healthHead.time = @"2019-10-12 10:20:30";
        healthHead.img = @"test";
        [self.topInforArr addObject:healthHead];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.topInforArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YTHealthHead *healthHead = [self.topInforArr objectAtIndex:indexPath.row];
    if ([healthHead.title containsString:@"1"]) {
        return 300;
    }
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YTHealthHeadListCell *cell = [YTHealthHeadListCell  cellWithTableView:tableView];
     YTHealthHead *healthHead = [self.topInforArr objectAtIndex:indexPath.row];
    cell.healthHead = healthHead;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    YTHealthHeadListCell *cell = (YTHealthHeadListCell *)[tableView  cellForRowAtIndexPath:indexPath];
    [cell setShadeShadow];
}

@end
