//
//  Task.h
//  HDMovie
//
//  Created by Do Ngoc Vinh on 7/19/16.
//  Copyright © 2016 VinhDN. All rights reserved.
//
/*private boolean IsLog;
 
 private String _LadingName;
 
 private String _DateUpdate;
 
 private String _Notes;
 
 private int _Status;
 
 private String ErrorMessage;
 
 private String _DateCreated;
 
 private int _OrderID;
 
 private int _LinesID;
 
 private int _LadingID;
 
 private String _Active;
 
 private String OldValue;
 
 private List<Order> order;
 */
#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "Order.h"
@interface Task : JSONModel
@property (strong, nonatomic) NSNumber<Optional>* _ID;
@property (strong, nonatomic) NSString<Optional>* _LadingName;
@property (strong, nonatomic) NSString<Optional>* _DateUpdate;
@property (strong, nonatomic) NSString<Optional>* _Notes;
@property (strong, nonatomic) NSNumber<Optional>* _Status;
@property (strong, nonatomic) NSString<Optional>* ErrorMessage;
@property (strong, nonatomic) NSString<Optional>* _DateCreated;
@property (strong, nonatomic) NSNumber<Optional>* _OrderID;
@property (strong, nonatomic) NSNumber<Optional>* _LinesID;
@property (strong, nonatomic) NSNumber<Optional>* numberOrder;
@property (strong, nonatomic) NSNumber<Optional>* _LadingID;
@property (strong, nonatomic) NSString<Optional>* _Active;
@property (strong, nonatomic) NSString<Optional>* OldValue;
@property (strong, nonatomic) NSMutableArray<Ignore>* listOrder;
-(void)getOrder;
@end