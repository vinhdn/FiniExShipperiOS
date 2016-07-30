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
+(NSURLSessionDataTask *)getHomePage:(id)parameters progress:(void (^)(NSProgress *))downloadProgress success:(void (^)(NSURLSessionDataTask *, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError *))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return [manager GET:[NSString stringWithFormat:@"%@/%@", [AppDelegate appLink], HOMEPAGE] parameters:parameters success:success failure:failure];
}
+(NSURLSessionDataTask *)getVideoPlay:(NSString*)movieId ep:(NSInteger)ep success:(void (^)(NSURLSessionDataTask *, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError *))failure{
    NSDictionary *parameters = @{@"sign": [AppDelegate appSign], @"movieId" : movieId, @"ep": [NSString stringWithFormat:@"%li",ep]};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableString *url = [[NSMutableString alloc] init];
    [url appendString: [AppDelegate appLink]];
    [url appendString:@"/"];
    [url appendString:VIDEO_PLAY_URL];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    return [manager GET:url parameters:parameters success:success failure:failure];
}
+(AFHTTPRequestOperation *)getSub:(NSString *)url success:(void (^)(AFHTTPRequestOperation *, id _Nullable))success failure:(void (^)(AFHTTPRequestOperation * _Nullable, NSError *))failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableString *urll = [[NSMutableString alloc] init];
    [urll appendString: url];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    return [manager GET:urll parameters:nil success:success failure:failure];
}
+(NSString*)getSu:api params:(NSMutableDictionary*)params{
    NSError * error = nil;
    NSURL *url = [NSURL URLWithString:api];
    NSData *data = [NSData dataWithContentsOfURL:url];
    if(data == nil) return nil;
    NSString *strutf8 = [NSString stringWithUTF8String:[data bytes]];
    if(strutf8) return strutf8;
    NSString* strlat3 = [[NSString alloc]
                         initWithData:data encoding: NSUnicodeStringEncoding];
    if(strlat3) return strlat3;

    NSString* str = [[NSString alloc]
                     initWithData:data encoding: NSISOLatin1StringEncoding];
//    if(str)
//    return str;
    NSString* strlat2 = [[NSString alloc]
                     initWithData:data encoding: NSISOLatin2StringEncoding];
    
    return strlat2;
}
+(NSString*)getQuality:(id)urlApi{
    NSError * error = nil;
    NSURL *url = [NSURL URLWithString:urlApi];
    NSData *data = [NSData dataWithContentsOfURL:url];
    if(data == nil || [data bytes] == nil) return nil;
    NSString *strutf8 = [NSString stringWithUTF8String:[data bytes]];
    if(strutf8) return strutf8;
    NSString* strlat3 = [[NSString alloc]
                         initWithData:data encoding: NSUnicodeStringEncoding];
    if(strlat3) return strlat3;
    
    NSString* str = [[NSString alloc]
                     initWithData:data encoding: NSISOLatin1StringEncoding];
    NSString* strlat2 = [[NSString alloc]
                         initWithData:data encoding: NSISOLatin2StringEncoding];
    
    return strlat2;
}
+(NSURLSessionDataTask *)search:(NSString *)key success:(void (^)(NSURLSessionDataTask *, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError *))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableString *urll = [[NSMutableString alloc] init];
    [urll appendString: @"http://movies.hdviet.com/tim-kiem-nhanh.html"];
    NSDictionary *parameters = @{@"keyword" : key};
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10) AppleWebKit/538.44 (KHTML, like Gecko) Version/8.0 Safari/538.44" forHTTPHeaderField:@"UserAgent"];
    [manager.requestSerializer setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10) AppleWebKit/538.44 (KHTML, like Gecko) Version/8.0 Safari/538.44" forHTTPHeaderField:@"User-Agent"];
        [manager.requestSerializer setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10) AppleWebKit/538.44 (KHTML, like Gecko) Version/8.0 Safari/538.44" forHTTPHeaderField:@"user-agent"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    return [manager GET:urll parameters:parameters success:success failure:failure];
}
+(NSURLSessionDataTask *)getCategories:(void (^)(NSURLSessionDataTask *, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError *))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableString *urll = [[NSMutableString alloc] init];
    [urll appendString: [AppDelegate appLink]];
    [urll appendString: @"/"];
    [urll appendString: CATEGORIES_URL];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/javascript"];
    return [manager GET:urll parameters:nil success:success failure:failure];
}
+(NSURLSessionDataTask *)getMoviesOfCategory:(NSInteger)cateID offset:(NSInteger)offset success:(void (^)(NSURLSessionDataTask *, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError *))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableString *urll = [[NSMutableString alloc] init];
    [urll appendString: [AppDelegate appLink]];
    [urll appendString: @"/"];
    [urll appendString: VIDEO_DETAIL_URL];
    NSDictionary *parameters = @{@"categoryId" : [NSString stringWithFormat:@"%i", cateID], @"offset":[NSString stringWithFormat:@"%i", offset]};
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/javascript"];
    return [manager GET:urll parameters:parameters success:success failure:failure];
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
    return [manager GET:urll parameters:parameters success:success failure:failure];
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
    return [manager GET:urll parameters:parameters success:success failure:failure];
}
+(NSURLSessionDataTask *)login:(NSString *)phone password:(NSString *)password success:(void (^)(NSURLSessionDataTask *, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError *))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableString *urll = [[NSMutableString alloc] init];
    [urll appendString: @"http://api.finiex.vn/api/login/"];
    NSDictionary *parameters = @{@"phone" : phone, @"password":password};
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    return [manager GET:urll parameters:parameters success:success failure:failure];
}

+(AFHTTPRequestOperation *)updateLocation:(double) lat lng:(double) lng userId:(int)userId accessToken:(NSString *) accessToken success:(void (^)(AFHTTPRequestOperation *, id _Nullable))success failure:(void (^)(AFHTTPRequestOperation * _Nullable, NSError *))failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
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
+(AFHTTPRequestOperation *)updateStatus:(int)status oStatus:(int)oStatus note:(NSString *) note order:(int)orderId accessToken:(NSString *)accessToken success:(void (^)(AFHTTPRequestOperation *, id _Nullable))success failure:(void (^)(AFHTTPRequestOperation * _Nullable, NSError *))failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableString *urll = [[NSMutableString alloc] init];
    [urll appendString: @"http://api.finiex.vn/api/order/"];
    [urll appendString:[NSString stringWithFormat:@"%ld",(long)orderId]];
    [urll appendString:@"?access_token="];
    [urll appendString:accessToken];
    NSDictionary *parameters = @{@"Status" : @(status), @"0Status": @(oStatus), @"Notes":note};
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    [serializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = serializer;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    return [manager PUT:urll parameters:parameters success:success failure:failure];
}
@end
