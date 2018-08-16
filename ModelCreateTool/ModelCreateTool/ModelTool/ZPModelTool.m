//
//  ZPModelTool.m
//  MoelToolDemo
//
//  Created by haozp on 2018/8/16.
//  Copyright © 2018年 haozp. All rights reserved.
//


#ifdef DEBUG
#define ZPModelToolLog( s, ... ) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(s), ##__VA_ARGS__] UTF8String] );
#else
#define ZPModelToolLog( s, ... )
#endif

#import "ZPModelTool.h"

@interface ZPModelTool()
//存 FileModel.h 内容
@property (strong,nonatomic) NSMutableArray *interfaceArry;
//存 FileModel.m 内容
@property (strong,nonatomic) NSMutableArray *implementationArry;

@end
@implementation ZPModelTool

static ZPModelTool* _instance = nil;

+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
    }) ;
    
    return _instance ;
}

- (void)createPropertyCodeWithDict:(NSDictionary *)dict with:(NSString *)modelCalssName{
    if (!dict) return;
    NSMutableSet *muSet = [NSMutableSet set];
    ZPModelTool *model = [[ZPModelTool alloc]init];
    [model createPropertyCodeWithDict:dict withProptyString:muSet];
    NSString *interfaceBegain = [NSString stringWithFormat:@"\n@interface %@ : NSObject\n",modelCalssName];
    NSString *end = @"@end\n";
    NSMutableArray *arry  = [NSMutableArray arrayWithArray:[muSet allObjects]];
    [arry insertObject:interfaceBegain atIndex:0];
    [arry addObject:end];
    [model.interfaceArry addObject:arry];
    
    NSMutableArray *imArry = [NSMutableArray array];
    NSString *implementationBegain = [NSString stringWithFormat:@"\n@implementation %@\n",modelCalssName];
    [imArry insertObject:implementationBegain atIndex:0];
    [imArry addObject:end];
    [model.implementationArry addObject:imArry];
    
    NSMutableArray *resultInterArrM = [NSMutableArray array];
    NSMutableArray *resultImArrM = [NSMutableArray array];
    NSMutableArray *logOutInterArry = [NSMutableArray array];
    NSMutableArray *logOutImArry = [NSMutableArray array];
    
    //.h 去重
    for (NSArray *obj in model.interfaceArry) {
        if (![resultInterArrM containsObject:obj]) {
            [resultInterArrM addObject:obj];
            [logOutInterArry addObjectsFromArray:obj];
        }
    }
    
    //.m 去重
    for (NSArray *obj in model.implementationArry) {
        if (![resultImArrM containsObject:obj]) {
            [resultImArrM addObject:obj];
            [logOutImArry addObjectsFromArray:obj];
        }
    }
    
    [logOutImArry insertObject:[NSString stringWithFormat:@"\n\n\n#import \"%@.h\"\n",modelCalssName] atIndex:0];
    
    [logOutInterArry insertObject:@"\n\n\n#import <Foundation/Foundation.h>\n" atIndex:0];
    
    ZPModelToolLog(@"\n\n-----------模型 %@.h 内容如下------------------------------\n\n%@\n\n-----------------------------------------------------------------------------------\n\n",modelCalssName,[logOutInterArry componentsJoinedByString:@""]);
    
    ZPModelToolLog(@"\n\n-----------模型 %@.m 内容如下------------------------------\n\n%@\n\n-----------------------------------------------------------------------------------\n\n",modelCalssName,[logOutImArry componentsJoinedByString:@""]);
    
    
}

//处理第一层字典
- (void)createPropertyCodeWithDict:(NSDictionary *)dict withProptyString:(NSMutableSet *)muSet{
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *pstring = [NSString stringWithFormat:@"@property (strong,nonatomic) NSString *%@;\n",key];
            [muSet addObject:pstring];
        }else if ([obj isKindOfClass:[NSArray class]]){
            NSArray *objArray = obj;
            if (objArray.count>0&&[objArray[0] isKindOfClass:[NSDictionary class]]){
                NSString *modelClassName = [NSString stringWithFormat:@"%@Model",[key capitalizedStringWithLocale:[NSLocale currentLocale]]];
                NSString *modelString = [NSString stringWithFormat:@"@property (strong,nonatomic) NSArray <%@ *> *%@;\n",modelClassName,key];
                [muSet addObject:modelString];
                NSMutableSet *set = [NSMutableSet set];
                [self createWithArry:obj arryKey:key set:set];
                NSMutableArray *arry  = [NSMutableArray arrayWithArray:[set allObjects]];
                NSString *begain = [NSString stringWithFormat:@"\n@interface %@ : NSObject\n",modelClassName];
                NSString *end = @"@end\n";
                [arry insertObject:begain atIndex:0];
                [arry addObject:end];
                [self.interfaceArry addObject:arry];
                
                NSMutableArray *imArry =[NSMutableArray array];
                NSString *implementationBegain = [NSString stringWithFormat:@"\n@implementation %@\n",modelClassName];
                [imArry insertObject:implementationBegain atIndex:0];
                [imArry addObject:end];
                [self.implementationArry addObject:imArry];
            }else{
                NSString *modelString = [NSString stringWithFormat:@"//#waring数组存的是非字典\n@property (strong,nonatomic) NSArray  *%@;\n",key];
                [muSet addObject:modelString];
            }
        }else if ([obj isKindOfClass:[NSDictionary class]]){
            NSString *modelClassName = [NSString stringWithFormat:@"%@Model",[key capitalizedStringWithLocale:[NSLocale currentLocale]]];
            NSString *modelString = [NSString stringWithFormat:@"@property (strong,nonatomic) %@ *%@;\n",modelClassName,key];
            [muSet addObject:modelString];
            NSMutableSet *set = [NSMutableSet set];
            [self createPropertyCodeWithDict:obj withProptyString:set];
            NSMutableArray *arry  = [NSMutableArray arrayWithArray:[set allObjects]];
            NSString *begain = [NSString stringWithFormat:@"\n@interface %@ : NSObject\n",modelClassName];
            NSString *end = @"@end\n";
            [arry insertObject:begain atIndex:0];
            [arry addObject:end];
            [self.interfaceArry addObject:arry];
            
            NSMutableArray *imArry =[NSMutableArray array];
            NSString *implementationBegain = [NSString stringWithFormat:@"\n@implementation %@\n",modelClassName];
            [imArry insertObject:implementationBegain atIndex:0];
            [imArry addObject:end];
            [self.implementationArry addObject:imArry];
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
            NSString *pstring = [NSString stringWithFormat:@"@property (assign,nonatomic) BOOL %@;\n",key];
            [muSet addObject:pstring];
        }else if ([obj isKindOfClass:[NSNumber class]]){
            NSString *pstring = [NSString stringWithFormat:@"@property (strong,nonatomic) NSNumber *%@;\n",key];
            [muSet addObject:pstring];
        }else if ([obj isKindOfClass:[NSDate class]]){
            NSString *pstring = [NSString stringWithFormat:@"@property (strong,nonatomic) NSDate *%@;\n",key];
            [muSet addObject:pstring];
        }else if ([obj isKindOfClass:[NSData class]]){
            NSString *pstring = [NSString stringWithFormat:@"@property (assign,nonatomic) NSData *%@;\n",key];
            [muSet addObject:pstring];
        }else {
            NSString *pstring = [NSString stringWithFormat:@"#waring unkonwn {key:%@ value:%@};\n",key,obj];
            [muSet addObject:pstring];
        }
        
    }];
}

//处理第二层字典里的数组
- (void)createWithArry:(NSArray *)arry arryKey:(NSString *)key set:(NSMutableSet *)set{
    
    [arry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]){
            [self createPropertyCodeWithDict:obj withProptyString:set];
        }else{
            //数组里放的是其他数据 字符或数组 需手动处理
        }
    }];
    
}

- (NSMutableArray *)interfaceArry{
    if(!_interfaceArry){
        _interfaceArry = [NSMutableArray array];
    }
    return _interfaceArry;
}

- (NSMutableArray *)implementationArry{
    if(!_implementationArry){
        _implementationArry = [NSMutableArray array];
    }
    return _implementationArry;
}

@end
