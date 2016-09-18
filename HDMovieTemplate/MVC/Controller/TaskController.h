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
@interface TaskController : UIViewController<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView * _Nullable tableView;
- (IBAction)menuClick:(nullable id)sender;
- (IBAction)takePhotoClick:(nullable id)sender;
@property (nonatomic,strong,nullable) NSMutableArray * listTask;
@end
