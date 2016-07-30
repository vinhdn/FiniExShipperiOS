//
//  TaskController.h
//  HDMovie
//
//  Created by Do Ngoc Vinh on 7/23/16.
//  Copyright © 2016 VinhDN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiConnect.h"
#import "Task.h"
#import "TaskCell.h"
#import <REFrostedViewController.h>
@interface TaskController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)menuClick:(id)sender;
@property (nonatomic,strong,nullable) NSMutableArray * listTask;
@end
