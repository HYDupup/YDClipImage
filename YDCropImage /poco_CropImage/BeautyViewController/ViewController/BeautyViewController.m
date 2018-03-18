//
//  BeautyViewController.m
//  poco_CropImage
//
//  Created by mac on 17/7/26.
//  Copyright © 2017年 HYD. All rights reserved.
//

#import "BeautyViewController.h"
#import "CropViewController.h"
#import "BottomView.h"
#import "BeautyButton.h"

@interface BeautyViewController ()<CropViewControllerDelegate>

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UIScrollView *scrollView;

@property (nonatomic,strong)NSArray *scrollViewBtns;
@property (nonatomic,strong)NSArray *scrollViewHightBtns;
@property (nonatomic,strong)NSArray *scrollViewTitleBtns;

@end

@implementation BeautyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    [self creatData];
    [self creatUI];
    
}

#pragma mark 懒加载
-(NSArray *)scrollViewBtns{
    if (_scrollViewBtns == nil) {
        _scrollViewBtns = [[NSArray alloc]init];
    }
    return _scrollViewBtns;
}
-(NSArray *)scrollViewHightBtns{
    if (_scrollViewHightBtns == nil) {
        _scrollViewHightBtns = [[NSArray alloc]init];
    }
    return _scrollViewHightBtns;
}
-(NSArray *)scrollViewTitleBtns{
    if (_scrollViewTitleBtns == nil) {
        _scrollViewTitleBtns = [[NSArray alloc]init];
    }
    return _scrollViewTitleBtns;
}

-(void)creatData{
    self.scrollViewBtns = @[@"scene",@"beauty_color",@"beauty_effect",@"beauty_effects",@"beauty_Emptiness",@"beauty_frame",@"beauty_lightdark",@"beauty_Sharpen",@"beauty_word"];
      self.scrollViewHightBtns = @[@"scene_hover",@"beauty_color_hover",@"beauty_effect_hover",@"beauty_effects_hover",@"beauty_Emptiness_hover",@"beauty_frame_hover",@"beauty_lightdark_hover",@"beauty_Sharpen_hover",@"beauty_word_hover"];
    self.scrollViewTitleBtns = @[@"",@"裁剪",@"颜色",@"光效",@"文字",@"印章",@"边框",@"卡片",@"明暗",@"调色",@"锐化",@"虚化"];
}

-(void)creatUI{
    [self creatImageView];
    [self creatScrollView];
}

-(void)creatImageView{
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 74, ScreenWidth-20, ScreenHeight-74*2)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.image = self.initialImage;
    [self.view addSubview:self.imageView];
}

-(void)creatScrollView{
    CGFloat btnWidth = 120*VIEW_RATE;
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, ScreenHeight-btnWidth, ScreenWidth, btnWidth)];
    [self.scrollView setBackgroundColor:HYDColour(38.0f, 43.0f, 49.0f)];
    [self.scrollView setContentSize:CGSizeMake(btnWidth*self.scrollViewBtns.count+1-10, 0)];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    for (int i=0; i<self.scrollViewBtns.count+1; i++) {
        if (i == 0) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, btnWidth-10, btnWidth)];
            [btn setImage:[UIImage imageNamed:self.scrollViewBtns[i]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:self.scrollViewHightBtns[i]] forState:UIControlStateNormal ];
            [btn setBackgroundColor:[UIColor clearColor]];
            btn.tag = i;
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:btn];
        }else if(i == 1){
            UIView *segmentationLine = [[UIView alloc]initWithFrame:CGRectMake(btnWidth-10, 0, 1, self.scrollView.height)];
            [segmentationLine setBackgroundColor:[UIColor blackColor]];
            [self.scrollView addSubview:segmentationLine];
        }else{
            int index = i - 1;
            BeautyButton *btn = [[BeautyButton alloc]initWithFrame:CGRectMake(1+index*btnWidth-10, 0, btnWidth, btnWidth) andImgae:self.scrollViewBtns[index] andHeigthImage:self.scrollViewHightBtns[index] andTitle:self.scrollViewTitleBtns[index]];
            btn.tag = index;
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:btn];
        }
    }
}

-(void)clickBtn:(UIButton *)sender{
    if (sender.tag == 1) {
        CropViewController *cropVC = [[CropViewController alloc]initWithImage:self.initialImage];
        cropVC.delegate = self;
        [self.navigationController pushViewController:cropVC animated:YES];
    }
}

-(void)backCropImage:(UIImage *)cropImgae{
    self.initialImage = cropImgae;
    self.imageView.image = cropImgae;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
