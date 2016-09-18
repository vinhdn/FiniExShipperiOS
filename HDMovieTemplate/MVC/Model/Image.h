//
//  Image.h
//  FiniExShipper
//
//  Created by Do Ngoc Vinh on 8/4/16.
//  Copyright © 2016 VinhDN. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ImgurImage.h"
@interface Image : JSONModel
    @property (nonatomic) int success;
    @property (nonatomic) int status;
    @property (strong, nonatomic) ImgurImage* data;
@end
