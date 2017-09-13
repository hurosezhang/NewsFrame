//
//  ZYKSociaViewController.m
//  网易新闻
//
//  Created by zhangyongkang on 2017/9/7.
//  Copyright © 2017年 JWHL.com. All rights reserved.
//

#import "ZYKSociaViewController.h"
@interface ZYKSociaViewController ()

@end

static NSString *ID = @"socaialCell";
@implementation ZYKSociaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    self.tableView.showsVerticalScrollIndicator = NO;
    
//    NSLog(@"%@viewDidLoad",self.title);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@--%ld",self.title,indexPath.row];
    // Configure the cell...
    
    return cell;
}


@end
