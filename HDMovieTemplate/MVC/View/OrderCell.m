//
//  OrderCell.m
//  HDMovie
//
//  Created by Do Ngoc Vinh on 7/23/16.
//  Copyright © 2016 VinhDN. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell

- (IBAction)phoneNhanClick:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", _order.Phone]]];

}

- (IBAction)phoneTraClick:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", _order.Phone_AM]]];
}
@end
