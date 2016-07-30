//
//  OrderController.m
//  HDMovie
//
//  Created by Do Ngoc Vinh on 7/23/16.
//  Copyright © 2016 VinhDN. All rights reserved.
//

#import "OrderController.h"
#import "OrderCell.h"
#import "Order.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "Define.h"
#import "Utils.h"
#import "UpdateStatusOrderController.h"
@implementation OrderController
-(void)viewDidLoad{
    if(self.task != nil && self.task._LadingName != nil){
        self.titleLb.text = self.task._LadingName;
    }else{
        self.titleLb.text = @"Danh sách đơn hàng";
    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"TaskLoaded"
                                                  object:nil];
}
-(void)viewDidAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryChanged:)
                                                 name:@"TaskLoaded"
                                               object:nil];
}
- (void)contentSizeCategoryChanged:(NSNotification *)notification
{
    if(notification.object != nil && [notification.object class] == Task.class){
        if([((Task*)notification.object)._LadingID intValue] == [self.task._LadingID intValue]){
            self.task = notification.object;
            [self.tableView reloadData];
        }
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.task == nil)
        return 0;
    return [self.task.listOrder count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];    
}
-(NSString*)getStatus:(NSInteger)status{
    if(status == 1) return @"Đang chờ";
    if(status == 2) return @"Đã nhận";
    if(status == 3) return @"Đã chuyển đơn";
    if(status == 4) return @"Đã hoàn thành";
    if(status == 5) return @"Chuyển hoàn";
    return @"Đang cập nhật";
}

+ (NSDate *)parseDate:(NSString *)dateStr
{
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:DATE_FORMAT_1];
    NSDate *date = [dateFormat dateFromString:dateStr];
    if(date == nil){
        [dateFormat setDateFormat:DATE_FORMAT_2];
        date = [dateFormat dateFromString:dateStr];
    }
    NSTimeInterval nsTI = [date timeIntervalSinceDate:[NSDate date]];
    return date;
}

- (void)configureCell:(OrderCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = YES; // Enable to use "-sizeThatFits:"
    Order *order = [self.task.listOrder objectAtIndex:indexPath.row];
    [cell.nameLb setText:order.OrderName];
    [cell.phoneTraLb setText:order.Phone_AM];
    [cell.phoneNhanLb setText:order.Phone];
    [cell.addLayLb setText:order.Noilay];
    [cell.addTraLb setText:order.Noitra];
    [cell.noteLb setText:order.Notes];
    [cell.noteKhachLb setText:order.Notes_AM];
    [cell.statusLb setText:[self getStatus:[order.Status integerValue]]];
    switch ([order.Status integerValue]) {
        case 1:
            [cell.statusLb setBackgroundColor:[UIColor yellowColor]];
            [cell.statusLb setTextColor:[UIColor blueColor]];
            break;
        case 2:
            [cell.statusLb setBackgroundColor:[UIColor blueColor]];
            [cell.statusLb setTextColor:[UIColor whiteColor]];
            break;
        case 3:
            [cell.statusLb setBackgroundColor:[UIColor greenColor]];
            [cell.statusLb setTextColor:[UIColor whiteColor]];
            break;
        case 4:
            [cell.statusLb setBackgroundColor:[UIColor greenColor]];
            [cell.statusLb setTextColor:[UIColor whiteColor]];
            break;
        case 5:
            [cell.statusLb setBackgroundColor:[UIColor redColor]];
            [cell.statusLb setTextColor:[UIColor whiteColor]];
            break;
        default:
            [cell.statusLb setBackgroundColor:[UIColor yellowColor]];
            [cell.statusLb setTextColor:[UIColor blueColor]];
            break;
    }
    [cell.priceLb setText:[NSString localizedStringWithFormat:@"%.0f VNĐ",[order.Prices floatValue]]];
    [cell.priceFeeLb setText:[NSString localizedStringWithFormat:@"%.0f VNĐ",[order.PriceShip floatValue]]];
    [cell.timeLb setText:[Utils dateToFuture:order.EndDate]];
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return [tableView fd_heightForCellWithIdentifier:@"OrderCell" configuration:^(OrderCell *cell) {
//        [self configureCell:cell atIndexPath:indexPath];
//    }];
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UpdateStatusOrderController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UpdateStatusController"];
    Order *cat = [self.task.listOrder objectAtIndex:indexPath.row];
    monitorMenuViewController.order = cat;
    [self presentViewController:monitorMenuViewController animated:NO completion:nil];
}
@end
