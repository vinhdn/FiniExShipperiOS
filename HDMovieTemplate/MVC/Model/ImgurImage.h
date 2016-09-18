//
//  ImgurImage.h
//  FiniExShipper
//
//  Created by Do Ngoc Vinh on 8/4/16.
//  Copyright © 2016 VinhDN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@interface ImgurImage : JSONModel
    @property (nonatomic) int id;
    @property (nonatomic) NSString* link;
@end
