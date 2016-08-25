

#import "DEMOMenuViewController.h"
#import "REFrostedViewController.h"
#import "AppDelegate.h"
#import "ApiConnect.h"
#import "DEMONavigationController.h"
#import "FiniUser.h"
#import "LoginController.h"
#import "UserInfo.h"

@interface DEMOMenuViewController ()

@end

@implementation DEMOMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadCategories];
    
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self loadUserInfo];
}

-(void)loadCategories{
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"UpdateMoney"
                                                  object:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryChanged:)
                                                 name:@"UpdateMoney"
                                               object:nil];
}

// This method is called when the Dynamic Type user setting changes (from the system Settings app)
- (void)contentSizeCategoryChanged:(NSNotification *)notification
{
    [self loadUserInfo];
}

-(void) loadUserInfo{
    FiniUser *fu = [FiniUser sharedInstance];
    [fu loadData];
    [ApiConnect getUserInfo:fu.accessToken userId:fu.idUser success:^(NSURLSessionDataTask * dataTask, id _Nullable success) {
        if(!success) return;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:success options:NSJSONWritingPrettyPrinted error:nil];
        NSString *data =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        UserInfo *userInfo = [[UserInfo alloc] initWithString:data error:nil];
        if(!userInfo) return;
        self.tableView.tableHeaderView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 160.0f)];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 0, 24)];
            label.text = [NSString stringWithFormat:@"User: %@", userInfo.FullName];
            label.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
            [label sizeToFit];
            
            [view addSubview:label];
            
            UILabel *labelPayment = [[UILabel alloc] initWithFrame:CGRectMake(10, 59, 0, 24)];
            labelPayment.text = [NSString stringWithFormat:@"Payment: %@", [NSString localizedStringWithFormat:@"%li VNĐ",[userInfo.aPayment longValue]]];
            labelPayment.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
            labelPayment.backgroundColor = [UIColor clearColor];
            labelPayment.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
            [labelPayment sizeToFit];
            
            UILabel *labelOuto = [[UILabel alloc] initWithFrame:CGRectMake(10, 88, 0, 24)];
            labelOuto.text = [NSString stringWithFormat:@"OutoMoney: %@", [NSString localizedStringWithFormat:@"%li VNĐ",[userInfo.aOutoMoney longValue]]];
            labelOuto.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
            labelOuto.backgroundColor = [UIColor clearColor];
            labelOuto.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
            [labelOuto sizeToFit];
            
            UILabel *labelMoney = [[UILabel alloc] initWithFrame:CGRectMake(10, 117, 0, 24)];
            labelMoney.text = [NSString stringWithFormat:@"Money: %@", [NSString localizedStringWithFormat:@"%li VNĐ",[userInfo.pMoney longValue]]];
            labelMoney.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
            labelMoney.backgroundColor = [UIColor clearColor];
            labelMoney.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
            [labelMoney sizeToFit];
            
            UILabel *labelShip = [[UILabel alloc] initWithFrame:CGRectMake(10, 146, 0, 24)];
            labelShip.text = [NSString stringWithFormat:@"Ship: %@", [NSString localizedStringWithFormat:@"%li VNĐ",[userInfo.pShip longValue]]];
            labelShip.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
            labelShip.backgroundColor = [UIColor clearColor];
            labelShip.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
            [labelShip sizeToFit];
//            labelShip.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin| UIViewAutoresizingFlexibleRightMargin;
            
            [view addSubview:labelShip];
            
            [view addSubview:labelMoney];
            
            [view addSubview:labelOuto];
            [view addSubview:labelPayment];
            view;
        });
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable data, NSError *error) {
        
    }];
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return nil;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
    view.backgroundColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
    label.text = @"Friends Online";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return 0;
    
    return 34;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 1){
        FiniUser *fu = [FiniUser sharedInstance];
        [fu resetData];
        [self.parentViewController dismissViewControllerAnimated:NO completion:nil];
        LoginController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginController"];
        [self presentViewController:monitorMenuViewController animated:NO completion:nil];
    }
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

        NSArray *titles = @[@"Nhiệm vụ", @"Đăng xuất"];
        cell.textLabel.text = titles[indexPath.row];
    
    return cell;
}
 
@end
