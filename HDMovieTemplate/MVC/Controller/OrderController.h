//
//  OrderController.h
//  HDMovie
//
//  Created by Do Ngoc Vinh on 7/23/16.
//  Copyright © 2016 VinhDN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
@interface OrderController : UIViewController<UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property(nonatomic) Task *task;
@end
