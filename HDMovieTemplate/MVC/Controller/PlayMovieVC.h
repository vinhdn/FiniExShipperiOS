//
//  PlayMovieVC.h
//  HDMovieTemplate
//
//  Created by iService on 1/9/16.
//  Copyright © 2016 Tinhvv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovePlay.h"

@interface PlayMovieVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UIView *parentPlayerV;
@property (weak, nonatomic) IBOutlet UIView *controlV;
@property (weak, nonatomic) IBOutlet UIView *headerV;
@property (weak, nonatomic) IBOutlet UIView *topV;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UISlider *progressV;
@property(nonatomic) NSString *movieId;
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer;
- (IBAction)pauseOrPlay:(UIButton*)sender;
- (IBAction)back:(id)sender;
- (IBAction)progressChanged:(UISlider*)sender;
- (void)hiddenView;
@end
