//
//  ONENetworkTool.m
//  CWOne
//
//  Created by Coulson_Wang on 2017/8/1.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "ONENetworkTool.h"
#import <AFNetworking.h>

static ONENetworkTool *_instance;
@implementation ONENetworkTool

// 单例
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[ONENetworkTool alloc] init];
    });
    return _instance;
}

- (void)requestHomeDataWithDate:(NSString *)date cityName:(NSString *)cityName success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure {
    
    NSString *dateStr = (date == nil) ? @"0" : date;
    NSString *cityStr = (cityName == nil) ? @"0" : cityName;

    NSString *requestURL = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/channel/one/%@/%@",dateStr,cityStr];
    // 将中文进行转码
    requestURL = [requestURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSDictionary *parameters = @{
                                 @"version":@"v4.3.0",
                                 };
    
    [[AFHTTPSessionManager manager] GET:requestURL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        // 进度
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        if (success) {
            NSDictionary *dataDict = responseObject[@"data"];
            if (dataDict) {
                success(dataDict);
            } else {
                NSError *error = [NSError errorWithDomain:@"请求的日期有误" code:250 userInfo:nil];
                failure(error);
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)postPraisedWithItemId:(NSString *)item_id  typeName:(NSString *)typeName success:(void (^)())success failure:(void (^)(NSError *))failure {
    
    NSDictionary *parameters = @{
                                 @"deviceid":[[[UIDevice currentDevice] identifierForVendor] UUIDString],
                                 @"devicetype":@"ios",
                                 @"itemid":item_id,
                                 @"type":typeName,
                                 };
    
    [[AFHTTPSessionManager manager] POST:@"http://v3.wufazhuce.com:8000/api/praise/add" parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        // 进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)postPraisedCommentWithType:(NSString *)typeName itemId:(NSString *)item_id commentId:(NSString *)commentId success:(void (^)())success failure:(void (^)(NSError *))failure {
    NSString *postURL = @"http://v3.wufazhuce.com:8000/api/comment/praise";
    NSDictionary *parameters = @{
                                 @"cmtid":commentId,
                                 @"itemid":item_id,
                                 @"type":typeName,
                                 };
    [[AFHTTPSessionManager manager] POST:postURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)postUnpraisedCommentWithType:(NSString *)typeName item_id:(NSString *)item_id commentId:(NSString *)commentId success:(void (^)())success failure:(void (^)(NSError *))failure {
    NSString *postURL = @"http://v3.wufazhuce.com:8000/api/comment/unpraise";
    NSDictionary *parameters = @{
                                 @"cmtid":commentId,
                                 @"itemid":item_id,
                                 @"type":typeName,
                                 };
    [[AFHTTPSessionManager manager] POST:postURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)requestRadioStatusDataSuccess:(void (^)(NSDictionary *dataDict))success failure:(void (^)(NSError *))failure {
    NSString *requestURL = @"http://v3.wufazhuce.com:8000/api/radio/active";
    NSDictionary *parameters = @{};
    
    [[AFHTTPSessionManager manager] GET:requestURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *dataDict = responseObject[@"data"];
            success(dataDict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)requestDetailDataOfType:(NSString *)typeName withItemId:(NSString *)item_id success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure {
    if ([typeName isEqualToString:@"serial"]) {
        typeName = @"serialcontent";
    }
    NSString *requestURL = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/%@/htmlcontent/%@",typeName,item_id];
    
    NSDictionary *parameters = @{
                                 @"version":@"v4.3.0",
                                 };
    
    [[AFHTTPSessionManager manager] GET:requestURL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        // 进度
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        if (success) {
            NSDictionary *dataDict = responseObject[@"data"];
            success(dataDict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)requestCommentListOfType:(NSString *)typeName WithItemID:(NSString *)item_id lastID:(NSString *)lastID success:(void (^)(NSArray<NSDictionary *> *))success failure:(void (^)(NSError *))failure {
    NSString *lastCommentId = (lastID == nil) ? @"0" : lastID;
    NSString *requestURL = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/comment/praiseandtime/%@/%@/%@",typeName, item_id,lastCommentId];
    NSDictionary *parameters = @{
                                 @"version":@"v4.3.0",
                                 };
    
    [[AFHTTPSessionManager manager] GET:requestURL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        // 进度
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        if (success) {
            NSDictionary *dataDict = responseObject[@"data"];
            NSArray *dataArray = dataDict[@"data"];
            success(dataArray);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

}

- (void)requestRelatedListDataOfType:(NSString *)typeName withItemId:(NSString *)item_id success:(void (^)(NSArray<NSDictionary *> *))success failure:(void (^)(NSError *))failure {
    NSString *requestURL = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/relatedforwebview/%@/%@",typeName,item_id];
    NSDictionary *parameters = @{
                                 @"version":@"v4.3.0",
                                 };
    
    [[AFHTTPSessionManager manager] GET:requestURL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        // 进度
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        if (success) {
            NSArray *dataArray = responseObject[@"data"];
            success(dataArray);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)requestMusicDetailDataWithItemId:(NSString *)item_id success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure {
    NSString *requestURL = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/music/detail/%@",item_id];
    
    NSDictionary *parameters = @{
                                 @"version":@"v4.3.0",
                                 @"platform":@"ios",
                                 };
    
    [[AFHTTPSessionManager manager] GET:requestURL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        // 进度
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        if (success) {
            NSDictionary *dataDict = responseObject[@"data"];
            success(dataDict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)requestMovieDetailDataWithItemId:(NSString *)item_id success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure {
    NSString *requestURL = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/movie/detail/%@",item_id];
    
    NSDictionary *parameters = @{
                                 @"version":@"v4.3.0",
                                 };
    
    [[AFHTTPSessionManager manager] GET:requestURL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        // 进度
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        if (success) {
            NSDictionary *dataDict = responseObject[@"data"];
            success(dataDict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)requestMovieStoryDataWithItemId:(NSString *)item_id success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure {
    NSString *requestURL = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/movie/%@/story/1/0",item_id];
    
    NSDictionary *parameters = @{
                                 @"version":@"v4.3.0",
                                 };
    
    [[AFHTTPSessionManager manager] GET:requestURL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        // 进度
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        if (success) {
            NSDictionary *dataDict = responseObject[@"data"];
            NSArray *dataArray = dataDict[@"data"];
            NSDictionary *dict = dataArray.firstObject;
            success(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)requestFeedsDataWithDateString:(NSString *)dateString success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    NSString *requestURL = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/feeds/list/%@",dateString];
    
    [[AFHTTPSessionManager manager] GET:requestURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        // 进度
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        if (success) {
            NSArray *dataArray = responseObject[@"data"];
            success(dataArray);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)requestDiaryWeatherDataSuccess:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure {
    NSString *requestURL = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/weather/search"];
    
    NSString *cityName = [[NSUserDefaults standardUserDefaults] valueForKey:ONECityNameKey];
    if (cityName == nil) {
        cityName = @"0";
    }
    NSDictionary *parameters = @{
                                 @"version":@"v4.3.0",
                                 @"city_name":cityName,
                                 };
    
    [[AFHTTPSessionManager manager] GET:requestURL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        // 进度
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        if (success) {
            NSDictionary *dataDict = responseObject[@"data"];
            success(dataDict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

/// 请求作者信息数据
- (void)requestAuthorInfoDataWithAuthorId:(NSString *)authorId success:(void (^)(NSDictionary *dataDict))success failure:(void (^)(NSError *error))failure {
    NSString *requestURL = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/author/info"];
    
    NSDictionary *parameters = @{
                                 @"version":@"v4.3.0",
                                 @"author_id":authorId
                                 };
    
    [[AFHTTPSessionManager manager] GET:requestURL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        // 进度
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        if (success) {
            NSDictionary *dataDict = responseObject[@"data"];
            success(dataDict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

/// 请求作者作品列表数据
- (void)requestAuthorWorksListDataWithAuthorId:(NSString *)authorId pageNumber:(NSString *)pageNumber success:(void (^)(NSArray *dataArray))success failure:(void (^)(NSError *error))failure {
    NSString *requestURL = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/author/works"];
    NSDictionary *parameters = @{
                                 @"version":@"v4.3.0",
                                 @"author_id":authorId,
                                 @"page_num":pageNumber
                                 };
    
    [[AFHTTPSessionManager manager] GET:requestURL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        // 进度
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        if (success) {
            NSArray *dataArray = responseObject[@"data"];
            success(dataArray);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

/// 请求用户信息数据
- (void)requestUserInfoDataWithUserId:(NSString *)userId success:(void (^)(NSDictionary *dataDict))success failure:(void (^)(NSError *error))failure {
    NSString *requestURL = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/user/info/%@",userId];
    
    NSDictionary *parameters = @{
                                 @"version":@"v4.3.0",
                                 };
    
    [[AFHTTPSessionManager manager] GET:requestURL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        // 进度
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        if (success) {
            NSDictionary *dataDict = responseObject[@"data"];
            success(dataDict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

/// 请求用户关注列表数据
- (void)requestUserFollowListCountWithUserId:(NSString *)userId success:(void (^)(NSArray *dataArray))success failure:(void (^)(NSError *error))failure {
    NSString *requestURL = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/user/follow_list"];
    NSDictionary *parameters = @{
                                 @"version":@"v4.3.0",
                                 @"uid":userId,
                                 };
    
    [[AFHTTPSessionManager manager] GET:requestURL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        // 进度
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        if (success) {
            NSArray *dataArray = responseObject[@"data"];
            success(dataArray);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)requestRecAppListSuccess:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure {
    NSString *requestURL = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/recapplist/ios"];
    
    NSDictionary *parameters = @{
                                 @"version":@"v4.3.0",
                                 };
    
    [[AFHTTPSessionManager manager] GET:requestURL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        // 进度
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        if (success) {
            NSArray *dataArray = responseObject[@"data"];
            NSDictionary *dataDict = dataArray.firstObject;
            success(dataDict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
