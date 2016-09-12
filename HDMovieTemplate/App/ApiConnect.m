//
//  ApiConnect.m
//  HDMovie
//
//  Created by iService on 1/6/16.
//  Copyright © 2016 Vinhdn. All rights reserved.
//

#import "ApiConnect.h"
#import "AppDelegate.h"

@implementation ApiConnect
+(NSDictionary*)sendRequest:api method:(NSString*)method params:(NSMutableDictionary*)params{
    NSMutableURLRequest *request =nil;
    request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",[AppDelegate appLink],api]]];
    NSLog(@"request:%@/%@",[AppDelegate appLink],api);
    if(params==nil){
        params=[[NSMutableDictionary alloc] init];
    }
    NSLog(@"params:%@",params);
    // Specify that it will be a POST request
    request.HTTPMethod = method;
    
    // This is how we set header fields
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    // Convert your data and set your request's HTTPBody property
    if(![method isEqualToString:@"GET"]&&params!=nil){
        NSData* jsonDataPost = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
        
        request.HTTPBody = jsonDataPost;
    }
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&error];
    
    //NSLog(@"data:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    if(data==nil)return nil;
    NSDictionary *resultDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error == nil)
    {
        // Parse data here
        NSLog(@"data:%@",resultDict);
        int code=[[resultDict objectForKey:@"code"] intValue];
        if(code==200){
        }
        return resultDict;
    }else{
        NSLog(@"error:%@",error);
        
        NSLog(@"data:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        return nil;
    }
}
+(NSURLSessionDataTask *)getTask:(NSString *)token userId:(NSInteger)userId success:(void (^)(NSURLSessionDataTask *, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError *))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableString *urll = [[NSMutableString alloc] init];
    [urll appendString: @"http://api.finiex.vn/api/"];
    [urll appendString: @"task/"];
    [urll appendString: [NSString stringWithFormat:@"%i", userId]];
    NSDictionary *parameters = @{@"access_token" : token};
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    return [manager GET:urll parameters:parameters progress:nil success:success failure:failure];
}
+(NSURLSessionDataTask *)getOrderOfTask:(NSString *)token taskId:(NSInteger)taskId success:(void (^)(NSURLSessionDataTask *, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError *))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableString *urll = [[NSMutableString alloc] init];
    [urll appendString: @"http://api.finiex.vn/api/"];
    [urll appendString: @"ordertask/"];
    [urll appendString: [NSString stringWithFormat:@"%i", taskId]];
    NSDictionary *parameters = @{@"access_token" : token};
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    return [manager GET:urll parameters:parameters progress:nil success:success failure:failure];
}
+(NSURLSessionDataTask *)login:(NSString *)phone password:(NSString *)password success:(void (^)(NSURLSessionDataTask *, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError *))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableString *urll = [[NSMutableString alloc] init];
    [urll appendString: @"http://api.finiex.vn/api/login/"];
    NSDictionary *parameters = @{@"phone" : phone, @"password":password};
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    return [manager GET:urll parameters:parameters progress:nil success:success failure:failure];
}

+(NSURLSessionDataTask *)updateLocation:(double) lat lng:(double) lng userId:(int)userId accessToken:(NSString *) accessToken success:(void (^)(NSURLSessionTask *, id _Nullable))success failure:(void (^)(NSURLSessionTask * _Nullable, NSError *))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableString *urll = [[NSMutableString alloc] init];
    [urll appendString: @"http://api.finiex.vn/api/user/"];
    [urll appendString:[NSString stringWithFormat:@"%ld",(long)userId]];
    [urll appendString:@"?access_token="];
    [urll appendString:accessToken];
    NSDictionary *parameters = @{@"Latitude" : @(lat), @"Longitude": @(lng)};
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    [serializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = serializer;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    return [manager PUT:urll parameters:parameters success:success failure:failure];
}
+(NSURLSessionDataTask *)updateStatus:(int)status oStatus:(int)oStatus note:(NSString *) note order:(int)orderId accessToken:(NSString *)accessToken success:(void (^)(NSURLSessionTask *, id _Nullable))success failure:(void (^)(NSURLSessionTask * _Nullable, NSError *))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableString *urll = [[NSMutableString alloc] init];
    [urll appendString: @"http://api.finiex.vn/api/order/"];
    [urll appendString:[NSString stringWithFormat:@"%ld",(long)orderId]];
    [urll appendString:@"?access_token="];
    [urll appendString:accessToken];
    NSDictionary *parameters = @{@"Status" : @(status), @"oStatus": @(oStatus), @"Notes":note};
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    [serializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = serializer;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    return [manager PUT:urll parameters:parameters success:success failure:failure];
}

+(NSURLSessionDataTask *)updatePayment:(int) uID pMoney:(int) pMoney pShip:(int) pShip date:(NSString *) date accessToken:(NSString *) accessToken success:(void (^)(NSURLSessionTask *, id _Nullable))success failure:(void (^)(NSURLSessionTask * _Nullable, NSError *))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableString *urll = [[NSMutableString alloc] init];
    [urll appendString: @"http://api.finiex.vn/api/pmoney/"];
    [urll appendString:@"?access_token="];
    [urll appendString:accessToken];
    NSDictionary *parameters = @{@"uId" : @(uID), @"pMoney": @(pMoney), @"pShip": @(pShip), @"DateCreat" : date};
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    [serializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = serializer;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    return [manager POST:urll parameters:parameters progress:nil success:success failure:failure];
}

+(NSURLSessionDataTask *)uploadImageToImgur:(UIImage *)image success:(void (^)(NSURLSessionTask *, id _Nullable))success failure:(void (^)(NSURLSessionTask * _Nullable, NSError *))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableString *urll = [[NSMutableString alloc] init];
    [urll appendString: @"https://api.imgur.com/3/image"];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"Client-ID f9ef7568e231ee5" forHTTPHeaderField:@"Authorization"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    return [manager POST:urll parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        [formData appendPartWithFormData:imageData name:@"image"];
    } progress:nil success:success failure:failure];

}
+(NSURLSessionDataTask *)uploadImage:(NSString *)imageURL userId:(int)userId customers:(NSString *)customers dateCreates:(NSString *)dateCreated accessToken:(NSString *)accessToken success:(void (^)(NSURLSessionTask *, id _Nullable))success failure:(void (^)(NSURLSessionTask * _Nullable, NSError *))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableString *urll = [[NSMutableString alloc] init];
    [urll appendString: @"http://api.finiex.vn/api/images"];
    [urll appendString:@"?access_token="];
    [urll appendString:accessToken];
    NSDictionary *parameters = @{@"ImagesURL" :imageURL, @"UserID": @(userId), @"Custommers":customers, @"DateCreats": dateCreated};
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    [serializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = serializer;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    return [manager POST:urll parameters:parameters progress:nil success:success failure:failure];
}
+(NSURLSessionDataTask *)getUserInfo:(NSString *)token userId:(NSInteger)userId success:(void (^)(NSURLSessionDataTask *, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError *))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableString *urll = [[NSMutableString alloc] init];
    [urll appendString: @"http://api.finiex.vn/api/"];
    [urll appendString: @"user/"];
    [urll appendString: [NSString stringWithFormat:@"%i", userId]];
    NSDictionary *parameters = @{@"access_token" : token};
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    return [manager GET:urll parameters:parameters progress:nil success:success failure:failure];
}
@end
