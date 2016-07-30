//
//  LoginController.m
//  HDMovie
//
//  Created by Do Ngoc Vinh on 7/24/16.
//  Copyright © 2016 VinhDN. All rights reserved.
//

#import "LoginController.h"
#import "ApiConnect.h"
#import "FiniUser.h"
#import "DEMORootViewController.h"
@interface LoginController()
@property (strong, nonatomic) UIActivityIndicatorView *indicator;
@end
@implementation LoginController
-(void)viewDidLoad{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [self.usernameTf resignFirstResponder];
    [self.passwordTf resignFirstResponder];
}
-(void)viewDidAppear:(BOOL)animated{
    FiniUser *fu = [FiniUser sharedInstance];
    [fu loadData];
    if(fu.idUser > 0){
        [self dismissViewControllerAnimated:NO completion:nil];
        DEMORootViewController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"rootController"];
        [self presentViewController:monitorMenuViewController animated:NO completion:nil];
    }
}
- (IBAction)loginClick:(id)sender {
    NSString *phone = [self.usernameTf text];
    NSString *pass = [self.passwordTf text];
    if(phone == nil || pass == nil || [phone length] <= 0 || [pass length] <= 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Đăng nhập"
                                                    message:@"Bạn cần phải nhập đầu đủ thông tin đăng nhập"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
        [alert show];
    }else{
        if(self.indicator == nil){
            self.indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            self.indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
            self.indicator.center = self.view.center;
            [self.view addSubview:self.indicator];
            [self.indicator bringSubviewToFront:self.view];
        }
            [self.indicator startAnimating];
            [ApiConnect login:phone password:pass success:^(NSURLSessionDataTask *dataTask, id _Nullable response) {
                    NSLog(@"LOGIN %@", response);
                if(response != nil && [response class] == [NSString class]){
                    [self.indicator stopAnimating];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Đăng nhập"
                                                                    message:@"Tài khoản hoặc mật khẩu không đúng, vui lòng nhập lại"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                }else{
                if(response != nil && [response count] > 0){
                if([response count] == 2){
                    [FiniUser sharedInstance].idUser = [[response objectAtIndex:0] intValue];
                    NSString* accessToken = [response objectAtIndex:1];
                    [FiniUser sharedInstance].accessToken = accessToken;
                    [[FiniUser sharedInstance] saveData];
                    [self dismissViewControllerAnimated:NO completion:nil];
                    DEMORootViewController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"rootController"];
                    [self presentViewController:monitorMenuViewController animated:NO completion:nil];
                    }else{
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Đăng nhập"
                                                                    message:@"Tài khoản hoặc mật khẩu không đúng, vui lòng nhập lại"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                        [alert show];
                    }
                }else{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Đăng nhập"
                                                                    message:@"Tài khoản hoặc mật khẩu không đúng, vui lòng nhập lại"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                }
                [self.indicator stopAnimating];
                }
                } failure:^(NSURLSessionDataTask * _Nullable dataTask, NSError *error) {
                    [self.indicator stopAnimating];
                    NSLog(@"LOGIN Error %@", error);
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Đăng nhập"
                                                                    message:@"Có lỗi xảy ra."
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                }];
                
        
    }
}
@end
