//
//  LoginController.h
//  HDMovie
//
//  Created by Do Ngoc Vinh on 7/24/16.
//  Copyright © 2016 VinhDN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameTf;
@property (weak, nonatomic) IBOutlet UITextField *passwordTf;
- (IBAction)loginClick:(id)sender;

@end
