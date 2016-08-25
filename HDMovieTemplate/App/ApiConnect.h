//
//  ApiConnect.h
//  HDMovie
//
//  Created by iService on 1/6/16.
//  Copyright © 2016 Vinhdn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "Define.h"
#import <AFNetworking.h>
#import <AFHTTPSessionManager.h>

@interface ApiConnect : NSObject{
    
}
+(NSDictionary * _Nullable)sendRequest:api method:(nullable NSString*)method params:(nullable NSMutableDictionary*)params;
+ (nullable NSURLSessionDataTask *)getHomePage:(nullable id)parameters
                              progress:(nullable void (^)( NSProgress * _Nullable downloadProgress)) downloadProgress
                               success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;
+(NSURLSessionDataTask *)getTask:(NSString*) token userId:(NSInteger)userId success:(void (^)(NSURLSessionDataTask *, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError *))failure;
+(NSURLSessionDataTask *)getOrderOfTask:(NSString*) token taskId:(NSInteger)taskId success:(void (^)(NSURLSessionDataTask *, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError *))failure;
+(NSURLSessionDataTask *)login:(NSString *)phone password:(NSString *) password success:(void (^)(NSURLSessionDataTask *, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError *))failure;
+(AFHTTPRequestOperation *)updateLocation:(double) lat lng:(double) lng userId:(int)userId accessToken:(NSString *) accessToken success:(void (^)(AFHTTPRequestOperation *, id _Nullable))success failure:(void (^)(AFHTTPRequestOperation * _Nullable, NSError *))failure;
+(AFHTTPRequestOperation *)updateStatus:(int) status oStatus:(int) oStatus  note:(NSString *) note order:(int)orderId accessToken:(NSString *) accessToken success:(void (^)(AFHTTPRequestOperation *, id _Nullable))success failure:(void (^)(AFHTTPRequestOperation * _Nullable, NSError *))failure;
+(AFHTTPRequestOperation *)updatePayment:(int) uID pMoney:(int) pMoney pShip:(int) pShip date:(NSString *) date accessToken:(NSString *) accessToken success:(void (^)(AFHTTPRequestOperation *, id _Nullable))success failure:(void (^)(AFHTTPRequestOperation * _Nullable, NSError *))failure;
+(AFHTTPRequestOperation *)uploadImageToImgur:(UIImage*)image success:(void (^)(AFHTTPRequestOperation *, id _Nullable))success failure:(void (^)(AFHTTPRequestOperation * _Nullable, NSError *))failure;
+(AFHTTPRequestOperation *)uploadImage:(NSString*) imageURL userId:(int) userId  customers:(NSString *) customers dateCreates:(NSString*)dateCreated accessToken:(NSString *) accessToken success:(void (^)(AFHTTPRequestOperation *, id _Nullable))success failure:(void (^)(AFHTTPRequestOperation * _Nullable, NSError *))failure;
+(NSURLSessionDataTask *)getUserInfo:(NSString*)token userId:(NSInteger) userId success:(void (^)(NSURLSessionDataTask *, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError *))failure;
@end
