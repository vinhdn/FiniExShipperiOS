//
//  UpdateStatusOrderController.m
//  FiniExShipper
//
//  Created by Do Ngoc Vinh on 7/30/16.
//  Copyright © 2016 VinhDN. All rights reserved.
//

#import "UpdateStatusOrderController.h"
#import "ApiConnect.h"
#import "FiniUser.h"
@interface UpdateStatusOrderController (){
    NSArray *_listStatus;
    
}
@property (strong, nonatomic) UIActivityIndicatorView *indicator;
@end

@implementation UpdateStatusOrderController

- (void)viewDidLoad {
    _listStatus = @[@"Đã nhận", @"Đã chuyển đơn", @"Đã hoàn thành", @"Chuyển hoàn"];
    [super viewDidLoad];
    self.indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    self.indicator.center = self.view.center;
    [self.view addSubview:self.indicator];
    [self.indicator bringSubviewToFront:self.view];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.statusPicker reloadComponent:0];
    if(self.order != nil){
        self.titleLb.text = self.order.OrderName;
        int pos = [self.order.Status intValue] - 2;
        if(pos < 0) pos = 0;
        [self.statusPicker selectRow:pos inComponent:0 animated:false];
    }else{
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [self.noteEdt resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_listStatus count];
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _listStatus[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}
- (IBAction)backClick:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)updateStatusClick:(id)sender {
    NSInteger ss = [self.statusPicker selectedRowInComponent:0];
    ss = ss + 2;
    NSInteger oss = ss;
    if(oss <= 3) oss = 2;
    FiniUser *fu = [FiniUser sharedInstance];
    [fu loadData];
    [self.indicator startAnimating];
    NSString *noteOld = self.order.Notes;
    if(noteOld == nil) noteOld = @"";
    [ApiConnect updateStatus:ss oStatus:oss note:[NSString stringWithFormat:@"Cập nhật %@/ %@", _listStatus[ss - 2], noteOld] order:[self.order.ID intValue] accessToken:fu.accessToken success:^(NSURLSessionTask * _Nullable request, id _Nullable response) {
        if(response){
            if(ss == 4){
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:DATE_FORMAT_2];
                NSString *date = [dateFormat stringFromDate:[NSDate date]];
                [ApiConnect updatePayment:fu.idUser pMoney:[self.order.Prices intValue] pShip:[self.order.PriceShip intValue] date:date  accessToken:fu.accessToken success:^(NSURLSessionTask * request, id _Nullable success) {
                    [[NSNotificationCenter defaultCenter]
                     postNotificationName:@"UpdateMoney"
                     object:self];
                } failure:^(NSURLSessionTask * _Nullable req, NSError * error) {
                    NSLog(@"UPDATE MONEY ERROR %@",error);
                    [[NSNotificationCenter defaultCenter]
                     postNotificationName:@"UpdateMoney"
                     object:self];
                }];
            }
        }
        [self.indicator stopAnimating];
        NSLog(@"UPDATE STATUS SUCCESS %@",response);
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"ReloadData"
         object:self];
        [self dismissViewControllerAnimated:NO completion:nil];
    } failure:^(NSURLSessionTask * _Nullable session, NSError * _Nullable success) {
        NSLog(@"UPDATE STATUS ERROR %@",success);
    }];
}

- (IBAction)updateNoteClick:(id)sender {
    NSInteger ss = [self.order.Status intValue];
    NSInteger oss = ss;
    if(oss <= 3) oss = 2;
    FiniUser *fu = [FiniUser sharedInstance];
    [fu loadData];
    NSString *note = self.noteEdt.text;
    if(note != nil && note.length > 0){
        [self.indicator startAnimating];
        NSString *noteOld = self.order.Notes;
        if(noteOld == nil) noteOld = @"";
    [ApiConnect updateStatus:ss oStatus:oss note:[NSString stringWithFormat:@"%@/%@",note, noteOld] order:[self.order.ID intValue] accessToken:fu.accessToken success:^(NSURLSessionTask * request, id _Nullable response) {
        [self.indicator stopAnimating];
        NSLog(@"UPDATE STATUS SUCCESS %@",response);
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"ReloadData"
         object:self];
        [self dismissViewControllerAnimated:NO completion:nil];
    } failure:^(NSURLSessionTask * _Nullable request, NSError *error) {
        [self.indicator stopAnimating];
        NSLog(@"UPDATE STATUS ERROR %@",error);
    }];
    }
}
@end
