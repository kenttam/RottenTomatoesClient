//
//  RTDMovieDetailViewController.m
//  rottenTomatoesDemo
//
//  Created by Kent Tam on 10/14/14.
//  Copyright (c) 2014 Kent Tam. All rights reserved.
//

#import "RTDMovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface RTDMovieDetailViewController ()

@end

@implementation RTDMovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = self.movie[@"title"];
    self.titleLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"synopsis"];
    [self.synopsisLabel sizeToFit];
    self.scrollView.contentSize = CGSizeMake(320, 1000);
    NSString *url = [self.movie valueForKeyPath:@"posters.thumbnail"];
    [self.posterImageView setImageWithURL: [NSURL URLWithString:url]];
    url = [url stringByReplacingOccurrencesOfString:@"tmb"
                                   withString:@"ori"];
    [self.posterImageView setImageWithURL: [NSURL URLWithString:url]];
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

@end
