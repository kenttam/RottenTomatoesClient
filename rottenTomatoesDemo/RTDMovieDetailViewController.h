//
//  RTDMovieDetailViewController.h
//  rottenTomatoesDemo
//
//  Created by Kent Tam on 10/14/14.
//  Copyright (c) 2014 Kent Tam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTDMovieDetailViewController : UIViewController

@property (nonatomic, strong) NSDictionary *movie;
@property (nonatomic, strong) UIImage * placeholderImage;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
