//
//  TaskController.m
//  HDMovie
//
//  Created by Do Ngoc Vinh on 7/23/16.
//  Copyright © 2016 VinhDN. All rights reserved.
//

#import "TaskController.h"
#import "Order.h"
#import "OrderController.h"
#import "FiniUser.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import <AudioToolbox/AudioToolbox.h>
#import "Image.h"
#import "Define.h"
@interface TaskController ()
@property (strong, nonatomic) NSMutableDictionary *offscreenCells;
@property (assign, nonatomic) BOOL isInsertingRow;
@property (strong, nonatomic) UIActivityIndicatorView *indicator;
@end

@implementation TaskController

- (void)viewDidLoad {
    // Do view setup here.
    [super viewDidLoad];
    self.indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    self.indicator.center = self.view.center;
    [self.view addSubview:self.indicator];
    [self.indicator bringSubviewToFront:self.view];
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 260;
    
    self.tableView.allowsSelection = YES;
    self.offscreenCells = [NSMutableDictionary dictionary];
    [self loadData];
    [self repeatedMethod];
}
-(void)loadData{
    FiniUser *fu = [FiniUser sharedInstance];
    [fu loadData];
    [ApiConnect getTask:fu.accessToken userId:fu.idUser success:^(NSURLSessionDataTask *mana, id _Nullable success) {
        //        NSMutableArray* tasks = [[NSMutableArray alloc] init];
        NSLog(@"TASKS %@", success);
        NSMutableArray *newData =  [[NSMutableArray alloc] init];
        for (NSDictionary* task in success) {
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:task options:NSJSONWritingPrettyPrinted error:nil];
            NSString *data =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            Task *catee = [[Task alloc] initWithString:data error:nil];
            [catee getOrder];
            [newData addObject:catee];
        }
        if([newData count] > 0){
            self.listTask = [[newData reverseObjectEnumerator] allObjects];
            [self.tableView reloadData];
            UILocalNotification *localNotification = [[UILocalNotification alloc] init];
            
            [localNotification setFireDate:[NSDate date]];
            localNotification.timeZone = [NSTimeZone defaultTimeZone];
            [localNotification setAlertBody:@"Time to wake up!"];
            [localNotification setSoundName:UILocalNotificationDefaultSoundName];
            
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        }
    } failure:^(NSURLSessionDataTask * _Nullable mana, NSError *error) {
        NSLog(@"ERROR TASKS %@", error);
    }];

}

- (void)repeatedMethod {
    int parameter1 = 14;
    float parameter2 = 144.6;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 60 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self repeatedMethod];
        [self loadData];
    });
}

- (void) dealloc
{
    // If you don't remove yourself as an observer, the Notification Center
    // will continue to try and send notification objects to the deallocated
    // object.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"TaskLoaded"
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"ReloadData"
                                                  object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryChanged:)
                                                 name:@"TaskLoaded"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadData:)
                                                 name:@"ReloadData"
                                               object:nil];
}

// This method is called when the Dynamic Type user setting changes (from the system Settings app)
- (void)contentSizeCategoryChanged:(NSNotification *)notification
{
    [self.tableView reloadData];
}
- (void)reloadData:(NSNotification *)notification
{
    [self loadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.listTask count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell" forIndexPath:indexPath];
    [self setUpCell:cell atIndexPath:indexPath];
//    Task *task = [self.listTask objectAtIndex:indexPath.row];
//    [cell.nameLb setText:task._LadingName];
//    [cell.statusLb setText:[NSString stringWithFormat:@"%i", [task._Status integerValue]]];
//    if(task._Notes != nil){
//        [cell.noteLb setText:task._Notes];
//    }
//    if([[task listOrder] count] > 0){
//        Order *odr = [[task listOrder] objectAtIndex:0];
//        [cell.addressLb setText:odr.Noitra];
//        [cell.timeLb setText:odr.EndDate];
//        [cell.phoneLb setText:odr.Phone];
//    }
//    
//    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
//    [cell setNeedsUpdateConstraints];
//    [cell updateConstraintsIfNeeded];
    
    return cell;
}

// NOTE: Set the table view's estimatedRowHeight property instead of
// implementing the below method, UNLESS you have extreme variability in
// your row heights and you notice the scroll indicator "jumping"
// as you scroll.
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Do the minimal calculations required to be able to return an
    // estimated row height that's within an order of magnitude of the
    // actual height. For example:
    return [tableView fd_heightForCellWithIdentifier:@"TaskCell" configuration:^(TaskCell *cell) {
                [self configureCell:cell atIndexPath:indexPath];
            }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OrderController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderController"];
    Task *cat = [self.listTask objectAtIndex:indexPath.row];
    monitorMenuViewController.task = cat;
    [self presentViewController:monitorMenuViewController animated:NO completion:nil];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return [tableView fd_heightForCellWithIdentifier:@"TaskCell" configuration:^(TaskCell *cell) {
//        [self configureCell:cell atIndexPath:indexPath];
//    }];
//}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}

- (void)configureCell:(TaskCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = YES; // Enable to use "-sizeThatFits:"
    [self setUpCell:cell atIndexPath:indexPath];
}

- (void)setUpCell:(TaskCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Task *task = [self.listTask objectAtIndex:indexPath.row];
    [cell.nameLb setText:task._LadingName];
    [cell.statusLb setText:[NSString stringWithFormat:@"%li", (long)[task._Status integerValue]]];
    if(task._Notes != nil){
        [cell.noteLb setText:task._Notes];
    }
    if([[task listOrder] count] > 0){
        Order *odr = [[task listOrder] objectAtIndex:0];
        [cell.addressLb setText:odr.Noitra];
        [cell.timeLb setText:odr.EndDate];
        [cell.phoneLb setText:odr.Phone];
    }
    [cell updateConstraintsIfNeeded];
    [cell layoutIfNeeded];
}

- (IBAction)menuClick:(id)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

- (IBAction)takePhotoClick:(id)sender {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:NULL];
}

#pragma Image picker delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage* image = info[UIImagePickerControllerEditedImage];
    [self.indicator startAnimating];
    [ApiConnect uploadImageToImgur:image success:^(AFHTTPRequestOperation * request, id _Nullable success) {
        NSLog(@"SUCCESS %@", success);
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:success options:NSJSONWritingPrettyPrinted error:nil];
        NSString *data =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        Image *imageP = [[Image alloc] initWithString:data error:nil];
        NSLog(@"DATA %@", data);
        FiniUser *fu = [FiniUser sharedInstance];
        [fu loadData];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:DATE_FORMAT_2];
        
        NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
        
        if(imageP.success == 1)
        [ApiConnect uploadImage:[imageP.data link] userId:fu.idUser customers:@"IOS App" dateCreates:stringFromDate accessToken:fu.accessToken success:^(AFHTTPRequestOperation * request, id _Nullable success) {
            NSLog(@"SUCCESS %@", success);
            [self.indicator stopAnimating];
        } failure:^(AFHTTPRequestOperation * _Nullable request, NSError *error) {
            NSLog(@"ERROR %@", error);
            [self.indicator stopAnimating];
        }];
    } failure:^(AFHTTPRequestOperation * _Nullable request, NSError *error) {
        NSLog(@"ERROR %@", error);
        [self.indicator stopAnimating];
    }];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
