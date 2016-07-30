//
//  Utils.m
//  HDMovieTemplate
//
//  Created by iService on 1/11/16.
//  Copyright © 2016 Tinhvv. All rights reserved.
//

#import "Utils.h"
#import "Define.h"
@implementation Utils
+(NSString *)timeToString:(NSTimeInterval)timeInterval{
    NSInteger interval = timeInterval;
    NSInteger ms = (fmod(timeInterval, 1) * 1000);
    long seconds = interval % 60;
    long minutes = (interval / 60) % 60;
    long hours = (interval / 3600);
    if(hours >0){
    return [NSString stringWithFormat:@"%0.2ld:%0.2ld:%0.2ld", hours, minutes, seconds];
    }else{
        return [NSString stringWithFormat:@"%0.2ld:%0.2ld", minutes, seconds];
    }
}
+(NSArray *)getListResolution:(NSString *)data{
    return nil;
}
+ (NSDate *)parseDate:(NSString *)dateStr
{
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:DATE_FORMAT_1];
    NSDate *date = [dateFormat dateFromString:dateStr];
    if(date == nil){
        [dateFormat setDateFormat:DATE_FORMAT_2];
        date = [dateFormat dateFromString:dateStr];
    }
    return date;
}
+(NSString *)dateToFuture:(NSString *)dateStr{
    NSDate *date = [self parseDate:dateStr];
    if(date == nil)
        return @"Đang tính";
    NSTimeInterval nsTI = [date timeIntervalSinceNow];
    NSString *rer = @"";
    NSInteger nsI = nsTI;
    if(nsI > 0){
        rer = @"Còn ";
        long day = (nsI / (3600 * 24));
        if(day > 0)
            rer = [NSString stringWithFormat:@"%@ %li ngày", rer, day];
        long hour = ((nsI / 3600) % 24);
        if(hour > 0)
            rer = [NSString stringWithFormat:@"%@ %li giờ", rer, hour];
        long minutes = ((nsI / 60) % 60);
        if(minutes <= 0) minutes = 1;
        if(minutes > 0)
            rer = [NSString stringWithFormat:@"%@ %li phút", rer, minutes];

    }else{
        rer = @"Kết thúc ";
        nsI = -nsI;
        long day = (nsI / (3600 * 24));
        if(day > 0)
            rer = [NSString stringWithFormat:@"%@ %li ngày", rer, day];
        long hour = ((nsI / 3600) % 24);
        if(hour > 0)
            rer = [NSString stringWithFormat:@"%@ %li giờ", rer, hour];
        long minutes = ((nsI / 60) % 60);
        if(minutes <= 0) minutes = 1;
        if(minutes > 0)
            rer = [NSString stringWithFormat:@"%@ %li phút", rer, minutes];
        rer = [NSString stringWithFormat:@"%@ trước", rer];
    }
    return  rer;
}
@end
