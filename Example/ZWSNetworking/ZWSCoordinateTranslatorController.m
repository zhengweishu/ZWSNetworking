//
//  ZWSCoordinateTranslatorController.m
//  ZWSNetworking
//
//  Created by LOFT.LIFE.ZHENG on 16/6/30.
//  Copyright © 2016年 zhengweishu. All rights reserved.
//

#import "ZWSCoordinateTranslatorController.h"
#import "ZWSTranslatorAPIManager.h"
#import "Masonry.h"

@interface ZWSCoordinateTranslatorController () <ZWSAPIManagerParamSource, ZWSAPIManagerCallbackDelegate>

@property (nonatomic, strong) ZWSTranslatorAPIManager *translatorAPIManager;
@property (nonatomic, strong) UILabel *result;

@end

@implementation ZWSCoordinateTranslatorController

#pragma mark - life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.result];
    
    [self layoutPageSubviews];
}

- (void)layoutPageSubviews {

    [self.result mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self.translatorAPIManager loadData];
}

#pragma mark - table view delegate



#pragma mark - table view datasource



#pragma mark - api manager call back delegate

- (void)managerCallAPIDidSuccess:(ZWSAPIBaseManager *)manager {

    if (manager == self.translatorAPIManager) {
        self.result.text = @"success";
        NSLog(@"%@", [manager fetchDataWithReformer:nil]);
    }
}

- (void)managerCallAPIDidFailed:(ZWSAPIBaseManager *)manager {

    if (manager == self.translatorAPIManager) {
        self.result.text = @"fail";
        NSLog(@"%@", [manager fetchDataWithReformer:nil]);
    }
}


#pragma mark - api manager params source

- (NSDictionary *)paramsForApi:(ZWSAPIBaseManager *)manager {

    NSDictionary *params = @{};
    
    if (manager == self.translatorAPIManager) {
        params = @{
                   kTranslatorAPIManagerParamsKeyLatitude  : @(31.228000),
                   kTranslatorAPIManagerParamsKeyLongitude : @(121.454290)
                   };
    }
    
    return params;
}


#pragma mark - getters and setters

- (UILabel *)result {

    if (_result == nil) {
        _result = [[UILabel alloc] init];
        _result.font = [UIFont systemFontOfSize:16];
        _result.textColor = [UIColor blackColor];
        _result.textAlignment = NSTextAlignmentCenter;
        _result.text = @"transforming...";
    }
    return _result;
}

- (ZWSTranslatorAPIManager *)translatorAPIManager {

    if (_translatorAPIManager == nil) {
        _translatorAPIManager = [[ZWSTranslatorAPIManager alloc] init];
        _translatorAPIManager.delegate = self;
        _translatorAPIManager.paramSource = self;
    }
    return _translatorAPIManager;
}


@end
