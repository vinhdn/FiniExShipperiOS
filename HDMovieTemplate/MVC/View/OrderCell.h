//
//  OrderCell.h
//  HDMovie
//
//  Created by Do Ngoc Vinh on 7/23/16.
//  Copyright © 2016 VinhDN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *addLayLb;
@property (weak, nonatomic) IBOutlet UILabel *addTraLb;
@property (weak, nonatomic) IBOutlet UILabel *phoneNhanLb;
@property (weak, nonatomic) IBOutlet UILabel *phoneTraLb;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;
@property (weak, nonatomic) IBOutlet UILabel *priceFeeLb;
@property (weak, nonatomic) IBOutlet UILabel *statusLb;
@property (weak, nonatomic) IBOutlet UILabel *noteLb;
@property (weak, nonatomic) IBOutlet UILabel *noteKhachLb;

@end
