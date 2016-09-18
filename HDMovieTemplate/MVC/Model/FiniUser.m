//
//  FiniUser.m
//  HDMovie
//
//  Created by Do Ngoc Vinh on 7/24/16.
//  Copyright © 2016 VinhDN. All rights reserved.
//

#import "FiniUser.h"
NSString * const kAccessToken = @"kAccessToken";
NSString * const kId = @"kID";
@implementation FiniUser
+(FiniUser *)sharedInstance{
    static FiniUser *_sharedInstance = nil;
    static dispatch_once_t onceSecurePredicate;
    dispatch_once(&onceSecurePredicate,^
                  {
                      _sharedInstance = [[self alloc] init];
                  });
    
    return _sharedInstance;
}
-(void)loadData{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kId])
    {
        self.idUser = [(NSNumber *)[[NSUserDefaults standardUserDefaults]
                                   objectForKey:kId] intValue];
        
        self.accessToken = [[NSUserDefaults standardUserDefaults]
                                   stringForKey:kAccessToken];
    }
    else
    {
        self.idUser = 0;
        self.accessToken = @"";
    }
}
-(void)saveData{
    [[NSUserDefaults standardUserDefaults]
     setObject:[NSNumber numberWithInt:self.idUser] forKey:kId];
    
    [[NSUserDefaults standardUserDefaults]
     setObject:self.accessToken forKey:kAccessToken];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)resetData{
    [[NSUserDefaults standardUserDefaults]
     setObject:[NSNumber numberWithInt:-1] forKey:kId];
    
    [[NSUserDefaults standardUserDefaults]
     setObject:@"" forKey:kAccessToken];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
