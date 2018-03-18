//
//  ViewController.m
//  poco_CropImage
//
//  Created by mac on 17/7/26.
//  Copyright © 2017年 HYD. All rights reserved.
//

#import "ViewController.h"
#import "BeautyViewController.h"

@interface ViewController ()

@property (nonatomic,strong)UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-200)/2,(ScreenHeight-200)/2 , 200, 200)];
    self.imageView.userInteractionEnabled = YES;
    self.imageView.image = [UIImage imageNamed:@"2"];
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:self.imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.imageView addGestureRecognizer:tap];
    
}

//进入裁剪界面
-(void)tap:(UIGestureRecognizer *)recognizer{
    BeautyViewController *beautyVC = [[BeautyViewController alloc]init];
    beautyVC.initialImage = self.imageView.image;
    [self.navigationController pushViewController:beautyVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
