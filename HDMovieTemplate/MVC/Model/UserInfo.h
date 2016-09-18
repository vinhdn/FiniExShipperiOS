//
//  UserInfo.h
//  FiniExShipper
//
//  Created by Do Ngoc Vinh on 8/26/16.
//  Copyright © 2016 VinhDN. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface UserInfo : JSONModel
@property (strong, nonatomic) NSNumber<Optional>* UserID;
@property (strong, nonatomic) NSNumber<Optional>* RoleID;
@property (strong, nonatomic) NSString<Optional>* FullName;
@property (strong, nonatomic) NSString<Optional>* Email;
@property (strong, nonatomic) NSString<Optional>* Address;
@property (strong, nonatomic) NSNumber<Optional>* pMoney;
@property (strong, nonatomic) NSNumber<Optional>* pShip;
@property (strong, nonatomic) NSString<Optional>* Phone;
@property (strong, nonatomic) NSNumber<Optional>* aOutoMoney;
@property (strong, nonatomic) NSNumber<Optional>* aPayment;
@property (strong, nonatomic) NSNumber<Optional>* TotalOrder;
@end
