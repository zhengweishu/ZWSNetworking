//
//  ZWSViewController.m
//  ZWSNetworking
//
//  Created by zhengweishu on 05/13/2016.
//  Copyright (c) 2016 zhengweishu. All rights reserved.
//

#import "ZWSViewController.h"
#import "ZWSNetworking.h"
#import "Masonry.h"
#import "ZWSCaseFactory.h"

NSString * const kDataSourceItemKeyCaseType = @"kDataSourceItemKeyCaseType";
NSString * const kDataSourceItemKeyCaseTitle = @"kDataSourceItemKeyCaseTitle";

static NSString *const kCellIndentifier = @"kCellIndentifier";

@interface ZWSViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) ZWSCaseFactory *caseFactory;

@end

@implementation ZWSViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    [self layoutPageSubviews];
}

- (void)layoutPageSubviews {

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    CaseType caseType = [self.dataSource[indexPath.row][kDataSourceItemKeyCaseType] unsignedIntegerValue];
    
    UIViewController *aCase = [self.caseFactory caseWithType:caseType];
    [self.navigationController pushViewController:aCase animated:YES];
}


#pragma mark - table view datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIndentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataSource[indexPath.row][kDataSourceItemKeyCaseTitle];
    return cell;
}

#pragma mark - getters and setters

- (UITableView *)tableView {

    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIndentifier];
    }
    return _tableView;
}

- (NSArray *)dataSource {

    if (_dataSource == nil) {
        _dataSource = @[
                        @{
                            kDataSourceItemKeyCaseType :@(CaseTypeCoordinateTranslator),
                            kDataSourceItemKeyCaseTitle : @"coordinate translator"
                            }
                        ];
    }
    return _dataSource;
}

- (ZWSCaseFactory *)caseFactory {

    if (_caseFactory == nil) {
        _caseFactory = [[ZWSCaseFactory alloc] init];
    }
    return _caseFactory;
}


@end
