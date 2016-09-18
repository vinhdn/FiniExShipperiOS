//
//  Order.m
//  HDMovie
//
//  Created by Do Ngoc Vinh on 7/19/16.
//  Copyright © 2016 VinhDN. All rights reserved.
//

#import "Order.h"
#import "Utils.h"
@implementation Order
-(void)setTime{
    if(self.EndDate != nil){
        NSDate *date = [Utils parseDate:self.EndDate];
        if(date != nil)
            self.time = [date timeIntervalSinceNow];
    }
}
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    if ([propertyName isEqualToString: @"time"]) return YES;
    return NO;
}
-(NSComparisonResult)compare:(Order *)object{
    if(self.Status.intValue == 4 && object.Status.intValue == 4){
        if(self.time > object.time)
            return NSOrderedAscending;
        else return NSOrderedDescending;
    }else if(self.Status.intValue == 4){
        return NSOrderedDescending;
    }else if(object.Status.intValue == 4){
        return NSOrderedAscending;
    }else{
        if(self.time > object.time)
            return NSOrderedAscending;
        else return NSOrderedDescending;
    }
}
@end
