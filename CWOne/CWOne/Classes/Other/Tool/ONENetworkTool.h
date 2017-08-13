//
//  ONENetworkTool.h
//  CWOne
//
//  Created by Coulson_Wang on 2017/8/1.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ONENetworkTool : NSObject

+ (instancetype)sharedInstance;

/* ********************************************* get请求 ********************************************* */
/// 请求主页数据
- (void)requestHomeDataWithDate:(NSString *)date cityName:(NSString *)cityName success:(void (^)(NSDictionary *dataDict))success failure:(void (^)(NSError *error))failure;

/// 获取当前电台状态数据
- (void)requestRadioStatusDataSuccess:(void (^)(NSDictionary *dataDict))success failure:(void (^)(NSError *error))failure;

/// 请求详情页数据
- (void)requestDetailDataOfType:(NSString *)typeName withItemId:(NSString *)item_id success:(void (^)(NSDictionary *dataDict))success failure:(void (^)(NSError *error))failure;

/// 请求某篇文章的关联列表
- (void)requestRelatedListDataOfType:(NSString *)typeName withItemId:(NSString *)item_id success:(void (^)(NSArray<NSDictionary *> *dataArray))success failure:(void (^)(NSError *error))failure;

/// 请求某篇文章的评论列表
- (void)requestCommentListOfType:(NSString *)typeName WithItemID:(NSString *)item_id lastID:(NSString *)lastID success:(void (^)(NSArray<NSDictionary *> *dataArray))success failure:(void (^)(NSError *error))failure;

/// 请求音乐的详情页数据
- (void)requestMusicDetailDataWithItemId:(NSString *)item_id success:(void (^)(NSDictionary *dataDict))success failure:(void (^)(NSError *error))failure;

/// 请求电影的详细信息
- (void)requestMovieDetailDataWithItemId:(NSString *)item_id success:(void (^)(NSDictionary *dataDict))success failure:(void (^)(NSError *error))failure;

/// 请求电影的故事数据
- (void)requestMovieStoryDataWithItemId:(NSString *)item_id success:(void (^)(NSDictionary *dataDict))success failure:(void (^)(NSError *error))failure;

/// 请求标题点击后展开的feeds列表数据
- (void)requestFeedsDataWithDateString:(NSString *)dateString success:(void (^)(NSArray *dataArray))success failure:(void (^)(NSError *error))failure;

/* ********************************************* post请求 ********************************************* */
/// 发送POST请求通知服务器某一条已点赞
- (void)postPraisedWithItemId:(NSString *)item_id typeName:(NSString *)typeName success:(void (^)())success failure:(void (^)(NSError *error))failure;

/// 发送POST请求通知服务器已给某一条评论点赞
- (void)postPraisedCommentWithType:(NSString *)typeName itemId:(NSString *)item_id commentId:(NSString *)commentId success:(void (^)())success failure:(void (^)(NSError *error))failure;

/// 发送POST请求通知服务器已取消某一条评论的赞
- (void)postUnpraisedCommentWithType:(NSString *)typeName item_id:(NSString *)item_id commentId:(NSString *)commentId success:(void (^)())success failure:(void (^)(NSError *error))failure;

@end
