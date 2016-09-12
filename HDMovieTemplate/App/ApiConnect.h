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
+(NSURLSessionDataTask * _Nullable)getTask:(NSString * _Nullable) token userId:(NSInteger)userId success:(nullable void (^)(NSURLSessionDataTask * _Nullable, id _Nullable))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nullable))failure;
+(NSURLSessionDataTask * _Nullable)getOrderOfTask:(NSString* _Nullable) token taskId:(NSInteger)taskId success:(nullable void (^)(NSURLSessionDataTask * _Nullable, id _Nullable))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nullable))failure;
+(NSURLSessionDataTask * _Nullable)login:(NSString * _Nullable)phone password:(NSString * _Nullable) password success:(nullable void (^)(NSURLSessionDataTask * _Nullable, id _Nullable))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nullable))failure;
+(NSURLSessionDataTask * _Nullable)updateLocation:(double) lat lng:(double) lng userId:(int)userId accessToken:(NSString * _Nullable) accessToken success:(nullable void (^)(NSURLSessionTask * _Nullable, id _Nullable))success failure:(nullable void (^)(NSURLSessionTask * _Nullable, NSError * _Nullable))failure;
+(NSURLSessionDataTask * _Nullable)updateStatus:(int) status oStatus:(int) oStatus  note:(NSString * _Nullable) note order:(int)orderId accessToken:(NSString * _Nullable) accessToken success:(nullable void (^)(NSURLSessionTask * _Nullable, id _Nullable))success failure:(nullable void (^)(NSURLSessionTask * _Nullable, NSError * _Nullable))failure;
+(NSURLSessionDataTask * _Nullable)updatePayment:(int) uID pMoney:(int) pMoney pShip:(int) pShip date:(NSString * _Nullable) date accessToken:(NSString * _Nullable) accessToken success:(nullable void (^)(NSURLSessionTask * _Nullable, id _Nullable))success failure:(nullable void (^)(NSURLSessionTask * _Nullable, NSError * _Nullable))failure;
+(NSURLSessionDataTask * _Nullable)uploadImageToImgur:(UIImage* _Nullable)image success:(nullable void (^)(NSURLSessionTask * _Nullable, id _Nullable))success failure:(nullable void (^)(NSURLSessionTask * _Nullable, NSError * _Nullable))failure;
+(NSURLSessionDataTask * _Nullable)uploadImage:(NSString* _Nullable) imageURL userId:(int) userId  customers:(NSString *_Nullable) customers dateCreates:(NSString* _Nullable)dateCreated accessToken:(NSString * _Nullable) accessToken success:(nullable void (^)(NSURLSessionTask * _Nullable, id _Nullable))success failure:(nullable void (^)(NSURLSessionTask * _Nullable, NSError * _Nullable))failure;
+(NSURLSessionDataTask *_Nullable)getUserInfo:(NSString*_Nullable)token userId:(NSInteger) userId success:(nullable void (^)(NSURLSessionDataTask *_Nullable, id _Nullable))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError *_Nullable))failure;
@end
