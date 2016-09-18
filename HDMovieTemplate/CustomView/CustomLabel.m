//
//  CustomLabel.m
//  NailsProject
//
//  Created by MD101 on 10/18/15.
//  Copyright © 2015 FiWi Group. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)awakeFromNib{
    [super awakeFromNib];
    if (self.tag == TAG_LABEL_LEVEL_1) {
        self.font = [UIFont boldSystemFontOfSize:20];
    }
    else if (self.tag == TAG_LABEL_LEVEL_2) {
        self.font = [UIFont systemFontOfSize:17];
    }
    else if (self.tag == TAG_LABEL_LEVEL_3) {
        self.font = [UIFont systemFontOfSize:15];
    }
    else if (self.tag == TAG_LABEL_LEVEL_4) {
        self.font = [UIFont systemFontOfSize:13];
    }
    
    if ([UIScreen mainScreen].bounds.size.width > 320) {
        self.font = [UIFont fontWithName:self.font.fontName size:self.font.pointSize + 2];
    }

}
@end
