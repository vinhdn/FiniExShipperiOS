//
//  CollectionViewController.m
//  HDMovie
//
//  Created by iService on 1/4/16.
//  Copyright © 2016 Vinhdn. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import "HeaderCollectionView.h"
#import "ResultSearchCell.h"
@import Foundation;
@interface CollectionViewController ()
@property (readwrite, nonatomic, strong) NSArray *posts;

@end

@implementation CollectionViewController{
    NSURLSessionDataTask *searchManager;
    NSMutableArray *resultSearch;
}

static NSString * const reuseIdentifier = @"Cell";
-(void)viewDidAppear:(BOOL)animated{
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}
- (void)reload:(__unused id)sender {
    self.navigationItem.rightBarButtonItem.enabled = NO;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:LINK_CONFIG parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSString *llba = [responseObject valueForKeyPath:@"link"];
        [AppDelegate setLink:llba];
        [AppDelegate setSign:[responseObject valueForKeyPath:@"sign"]];
        NSDictionary *parameters = @{@"sign": [AppDelegate appSign]};
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *dict= [ApiConnect sendRequest:HOMEPAGE method:@"GET" params:parameters];
            NSMutableArray *newData =  [[NSMutableArray alloc] init];
            if(dict == nil){
                
            }else{
                NSDictionary *rr = [dict valueForKeyPath:@"r"];
                NSArray *movStr = [rr valueForKeyPath:@"MoviesByCates"];
                for (NSDictionary* cate in movStr) {
                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:cate options:NSJSONWritingPrettyPrinted error:nil];
                    NSString *data =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                    Categories *catee = [[Categories alloc] initWithString:data error:nil];
                    [newData addObject:catee];
                }
                if([newData count] > 0){
                    self.listData = newData;
                    [self.collectionView reloadData];
                }
            }
        });
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    self.listData=[[NSMutableArray alloc] init];
    self.title = @"HDMovie";
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.collectionView.frame.size.width, 100.0f)];
    [self.refreshControl addTarget:self action:@selector(reload:) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:self.refreshControl];
    [self reload:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UISearchBarDelegate>

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length > 0){
        self.resultSearchView.hidden = NO;
        if(searchManager != nil) [searchManager cancel];
        searchManager = [ApiConnect search:searchText success:^(NSURLSessionDataTask *mana, id _Nullable success) {
            resultSearch = [[NSMutableArray alloc] init];
            NSLog(@"SEARCH RESULT %@", success);
            NSDictionary *data = [success valueForKeyPath:@"Title"];
            for (NSDictionary *key in [data allValues]) {
                
                Movie *mov = [[Movie alloc] init];
                mov.MovieID = [key valueForKeyPath:@"MovieID"];
                mov.MovieName = [key valueForKeyPath:@"MovieName"];
                mov.Backdrop = [key valueForKeyPath:@"Backdrop"];
                mov.KnownAs = [key valueForKeyPath:@"KnownAs"];
                [resultSearch addObject:mov];
            }
            [self.tableResultSearch reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable mana, NSError *error) {
            NSLog(@"SEARCH ERROR %@", error);
            resultSearch = [[NSMutableArray alloc] init];
        }];
    }
    else{
        self.resultSearchView.hidden = YES;
        [searchBar resignFirstResponder];
    }
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    self.resultSearchView.hidden = NO;
    [searchBar resignFirstResponder];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    self.resultSearchView.hidden = YES;
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

#pragma mark <UITableViewDataSource>

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [resultSearch count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ResultSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResultSearchCell"];
    Movie *mov = [resultSearch objectAtIndex:indexPath.row];
    cell.titleLb.text = mov.MovieName;
    cell.knowAsLb.text = mov.KnownAs;
    [cell.imageV setImage:nil];
    [cell.imageV setImageWithURL:[NSURL URLWithString:mov.Backdrop]];
    return cell;
}

#pragma mark <UITableViewDelegate>

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailController"];
    Movie *mov = [resultSearch objectAtIndex:indexPath.row];
    monitorMenuViewController.movieId = [mov MovieID];
    [self presentViewController:monitorMenuViewController animated:NO completion:nil];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return [self.listData count];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [[(Categories *)[self.listData objectAtIndex:section] Movies] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    Categories *cat = [self.listData objectAtIndex:indexPath.section];
    Movie *mov = [cat.Movies objectAtIndex:indexPath.row];
    cell.nameLb.text = [mov KnownAs];
    [cell.thumbIV setImage:nil];
    [cell.thumbIV setImageWithURL:[NSURL URLWithString:[mov Poster100x149]]];
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    if(kind == UICollectionElementKindSectionHeader){
        HeaderCollectionView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderCell" forIndexPath:indexPath];
         NSString *title = [[NSString alloc]initWithFormat:@"%@", [(Categories *)[self.listData objectAtIndex:indexPath.section] CategoryName]];
        headerView.headerLb.text = title;
        reusableview = headerView;
    }
    return reusableview;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%li/%li",indexPath.section, indexPath.row);
    DetailController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailController"];
    Categories *cat = [self.listData objectAtIndex:indexPath.section];
    Movie *mov = [cat.Movies objectAtIndex:indexPath.row];
    monitorMenuViewController.movieId = [mov MovieID];
    [self presentViewController:monitorMenuViewController animated:NO completion:nil];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    float cellWidth = screenWidth / 3.3;
    CGSize size = CGSizeMake(cellWidth, cellWidth * 16.0 / 10.0);
    return size;
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
