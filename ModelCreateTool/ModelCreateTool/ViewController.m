//
//  ViewController.m
//  ModelCreateTool
//
//  Created by haozp on 2018/8/16.
//  Copyright © 2018年 haozp. All rights reserved.
//

#import "ViewController.h"
#import "ZPModelTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //大部分数据是该形式
    NSString *fineNomal = @"moelToolTest";
    NSString *filePath = [[NSBundle mainBundle]pathForResource:fineNomal ofType:@"plist"];
    NSDictionary *normalDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    [[ZPModelTool shareInstance]createPropertyCodeWithDict:normalDict with:@"JustTestNormalModel"];
    
    NSString *fineUnNomalStrig = @"other-string";//数组是字符
    NSString *filePathString = [[NSBundle mainBundle]pathForResource:fineUnNomalStrig ofType:@"plist"];
    NSDictionary *dictString = [NSDictionary dictionaryWithContentsOfFile:filePathString];
    [[ZPModelTool shareInstance]createPropertyCodeWithDict:dictString with:@"JustTestStringModel"];
    
    NSString *fineUnNomalArray = @"other-array";//数组是数组
    NSString *filePathArray = [[NSBundle mainBundle]pathForResource:fineUnNomalArray ofType:@"plist"];
    NSDictionary *dictArray = [NSDictionary dictionaryWithContentsOfFile:filePathArray];
    [[ZPModelTool shareInstance]createPropertyCodeWithDict:dictArray with:@"JustTestArrayModel"];
    
    
    NSString *json = @"test";//json
    NSString *jsonPath = [[NSBundle mainBundle]pathForResource:json ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    NSDictionary *dictJson = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    [[ZPModelTool shareInstance]createPropertyCodeWithDict:dictJson with:@"JSONTestModel"];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
