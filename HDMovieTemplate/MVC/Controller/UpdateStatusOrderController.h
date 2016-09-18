//
//  UpdateStatusOrderController.h
//  FiniExShipper
//
//  Created by Do Ngoc Vinh on 7/30/16.
//  Copyright © 2016 VinhDN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
@interface UpdateStatusOrderController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
@property Order *order;
@property (weak, nonatomic) IBOutlet UIPickerView *statusPicker;
- (IBAction)backClick:(id)sender;
- (IBAction)updateStatusClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
- (IBAction)updateNoteClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *noteEdt;

@end
