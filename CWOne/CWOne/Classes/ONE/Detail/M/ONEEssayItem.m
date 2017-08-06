//
//  ONEEssayItem.m
//  CWOne
//
//  Created by Coulson_Wang on 2017/8/6.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "ONEEssayItem.h"

@implementation ONEEssayItem

+ (instancetype)essayItemWithDict:(NSDictionary *)dict {
    ONEEssayItem *item = [[ONEEssayItem alloc] init];
    
    [item setValuesForKeysWithDictionary:dict];
    
    NSArray *tag_list = dict[@"tag_list"];
    NSDictionary *tag = tag_list.firstObject;
    item.tagTitle = tag[@"title"];
    
    return item;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    // do nothing
}

@end