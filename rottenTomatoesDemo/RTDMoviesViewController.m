//
//  RTDMoviesViewController.m
//  rottenTomatoesDemo
//
//  Created by Kent Tam on 10/13/14.
//  Copyright (c) 2014 Kent Tam. All rights reserved.
//

#import "RTDMoviesViewController.h"
#import "RTDMovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "RTDMovieDetailViewController.h"
#import "SVProgressHUD.h"

@interface RTDMoviesViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation RTDMoviesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.networkErrorView setHidden:YES];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.rowHeight = 100;
    
    self.title = @"Movie";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RTDMovieCell" bundle:nil]
     forCellReuseIdentifier:@"RTDMovieCell"];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    // Do any additional setup after loading the view from its nib.
    [SVProgressHUD show];
    [self getData];
}

-(void) getData {
    NSURL *url = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=enrkwu9mpxqeph9tte6gwnjz&limit=20&country=us"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            [self.networkErrorView setHidden:NO];
        } else {
            [self.networkErrorView setHidden:YES];
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            self.movies  = responseDictionary[@"movies"];
            
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        }
        [self.refreshControl endRefreshing];
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movies.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RTDMovieDetailViewController *vc = [[RTDMovieDetailViewController alloc]init];
    vc.movie = self.movies[indexPath.row];
    RTDMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RTDMovieCell" forIndexPath:indexPath];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RTDMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RTDMovieCell"];
    NSDictionary *movie = self.movies[indexPath.row];
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"synopsis"];
    
    NSString *posterUrl = [movie valueForKeyPath:@"posters.thumbnail"];
    [cell.posterView setImageWithURL: [NSURL URLWithString:posterUrl]];
    return cell;
}

- (void) onRefresh {
    [self getData];
}
@end
