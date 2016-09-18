//
//  Task.m
//  HDMovie
//
//  Created by Do Ngoc Vinh on 7/19/16.
//  Copyright © 2016 VinhDN. All rights reserved.
//

#import "Task.h"
#import "ApiConnect.h"
#import "FiniUser.h"
@implementation Task
-(void)getOrder{
    if (__LadingID != nil && [__LadingID integerValue] > 0) {
        [[FiniUser sharedInstance] loadData];
        NSString * accessToken = [FiniUser sharedInstance].accessToken;
    [ApiConnect getOrderOfTask:accessToken taskId:[__LadingID integerValue] success:^(NSURLSessionDataTask *mana, id _Nullable success) {
        NSLog(@"Order TASKS %@", success);
        NSMutableArray *newData =  [[NSMutableArray alloc] init];
        int count = 0;
        for (NSDictionary* task in success) {
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:task options:NSJSONWritingPrettyPrinted error:nil];
            NSString *data =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            Order *catee = [[Order alloc] initWithString:data error:nil];
            [catee setTime];
            if([catee.Status intValue] != 4){
                count += 1;
            }
            [newData addObject:catee];
        }
        if([newData count] > 0){
            self.listOrder = [newData sortedArrayUsingSelector:@selector(compare:)];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"TaskLoaded"
             object:self];
        }
        self.numberOrder = @(count);
    } failure:^(NSURLSessionDataTask * _Nullable mana, NSError *error) {
        NSLog(@"ERROR Order TASKS %@", error);
    }];
    }
}

@end