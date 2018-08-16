//
//  ZPModelTool.h
//  MoelToolDemo
//
//  Created by haozp on 2018/8/16.
//  Copyright © 2018年 haozp. All rights reserved.
//

/*
 该工具为模型文件创建助手，可以大大减少无脑工作（手写模型）。
 数据需要满足 key-value 才能正常处理。
 数组里放字典可正常处理。
 数组里存其他数据可能需要手动处理下（一般无需单独处理），视情况而定。不影响其他数据的处理。
 可以单独处理字典中某个以小部分字典 改变传入值即可。
 */


#import <Foundation/Foundation.h>

@interface ZPModelTool : NSObject

+ (instancetype) shareInstance ;

//用法如下 调用改方法
//1、传入对应的数据字典 和 将要命名的模型文件名（如：JustTestModel）运行Xcode
//2、复制Xcode的log日志到1中创建的文件（如：JustTestModel）.h和.m分别复制
/*
 dict: 需要转化的dict
 modelClassName 模型文件名
 */

- (void)createPropertyCodeWithDict:(NSDictionary *)dict with:(NSString *)modelCalssName;

@end
