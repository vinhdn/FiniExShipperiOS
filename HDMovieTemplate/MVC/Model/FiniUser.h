//
//  FiniUser.h
//  HDMovie
//
//  Created by Do Ngoc Vinh on 7/24/16.
//  Copyright © 2016 VinhDN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@interface FiniUser : JSONModel
+ (FiniUser *)sharedInstance;

@property (assign) int idUser;
@property (assign) NSString *accessToken;

-(void) saveData;
-(void) loadData;
-(void) resetData;
@end
