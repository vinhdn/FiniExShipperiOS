//
//  Order.h
//  HDMovie
//
//  Created by Do Ngoc Vinh on 7/19/16.
//  Copyright © 2016 VinhDN. All rights reserved.
//
/*
 private int _ID;
 
 private int ID;
 
	private boolean IsLog;
 
 private String _EndDate;
 
 private String _Notes;
 
 private int _Status;
 
 private String ErrorMessage;
 
 private int _LadingID;
 
 private int _OrderID;
 
 private int OrderID;
 
 private String _DateCreated;
 
 private String OldValue;
 
 private String Noilay;
 private String Noitra;
 
 private double Prices;
 private double PriceShip;
 
 private String OrderName;
 private int Status;
 
 private String Phone;
 
 private String Address;
 
 private String EndDate;
 
 private String NguoiNhan;
 
 private String Phone_AM;
 private String Notes_AM;
 
 private String Notes;
 
 private long dealine = -1;
 */
#import <Foundation/Foundation.h>
#import "JSONModel.h"
@interface Order : JSONModel
@property (strong, nonatomic) NSNumber<Optional>* _ID;
@property (strong, nonatomic) NSNumber<Optional>* ID;
@property (strong, nonatomic) NSString<Optional>* _EndDate;
@property (strong, nonatomic) NSString<Optional>* _Notes;
@property (strong, nonatomic) NSNumber<Optional>* _Status;
@property (strong, nonatomic) NSString<Optional>* ErrorMessage;
@property (strong, nonatomic) NSNumber<Optional>* _LadingID;
@property (strong, nonatomic) NSNumber<Optional>* _OrderID;
@property (strong, nonatomic) NSNumber<Optional>* OrderID;
@property (strong, nonatomic) NSString<Optional>* _DateCreated;
@property (strong, nonatomic) NSString<Optional>* Noilay;
@property (strong, nonatomic) NSString<Optional>* Noitra;
@property (strong, nonatomic) NSNumber<Optional>* Prices;
@property (strong, nonatomic) NSNumber<Optional>* PriceShip;
@property (strong, nonatomic) NSString<Optional>* OrderName;
@property (strong, nonatomic) NSNumber<Optional>* Status;
@property (strong, nonatomic) NSString<Optional>* Phone;
@property (strong, nonatomic) NSString<Optional>* Address;
@property (strong, nonatomic) NSString<Optional>* EndDate;
@property (strong, nonatomic) NSString<Optional>* NguoiNhan;
@property (strong, nonatomic) NSString<Optional>* Phone_AM;
@property (strong, nonatomic) NSString<Optional>* Notes_AM;
@property (strong, nonatomic) NSString<Optional>* Notes;
@property (nonatomic) NSTimeInterval time;
-(void) setTime;
@end
