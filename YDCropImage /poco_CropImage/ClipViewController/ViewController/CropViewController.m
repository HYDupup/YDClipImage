//
//  CropViewController.m
//  poco_CropImage
//
//  Created by mac on 17/7/26.
//  Copyright © 2017年 HYD. All rights reserved.
//

#import "CropViewController.h"
#import "ClipView.h"
#import "BottomView.h"

@interface CropViewController ()<BottomViewDelegate>

@property (nonatomic,strong)ClipView *cropView;

@property (nonatomic,strong)BottomView *bottomView;

@property (nonatomic,strong)NSArray *bottomBtns;
//裁剪比例
@property (nonatomic,strong)NSArray *cropScales;

@end

@implementation CropViewController


-(instancetype)initWithImage:(UIImage *)initialImage{
    self = [super init];
    if (self) {
        self.initialImage = initialImage;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    [self creatData];
    [self creatUI];
}

#pragma mark 懒加载
-(NSArray *)bottomBtns{
    if (_bottomBtns == nil) {
        _bottomBtns = [[NSArray alloc]init];
    }
    return _bottomBtns;
}
-(NSArray *)cropScales{
    if (_cropScales == nil) {
        _cropScales = [[NSArray alloc]init];
    }
    return _cropScales;
}

-(void)creatData{
    self.bottomBtns = @[@"任意",@"3:2",@"4:3",@"16:9",@"1:1",@"2:3",@"3:4",@"9:16"];
    self.cropScales = @[
                        NSStringFromCGSize(CGSizeMake(0, 0)),
                        NSStringFromCGSize(CGSizeMake(3, 2)),
                        NSStringFromCGSize(CGSizeMake(4, 3)),
                        NSStringFromCGSize(CGSizeMake(16, 9)),
                        NSStringFromCGSize(CGSizeMake(1, 1)),
                        NSStringFromCGSize(CGSizeMake(2, 3)),
                        NSStringFromCGSize(CGSizeMake(3, 4)),
                        NSStringFromCGSize(CGSizeMake(9, 16))];
}

-(void)creatUI{
    
    self.cropView = [[ClipView alloc]initWithFrame:CGRectMake(10, 74, ScreenWidth-20, ScreenHeight-74*2) andInitialImage:self.initialImage andCropScale:CGSizeFromString(self.cropScales[0])];
    [self.view addSubview:self.cropView];
    
    self.bottomView = [[BottomView alloc]initWithFrame:CGRectMake(0, ScreenHeight-120*VIEW_RATE, ScreenWidth,120*VIEW_RATE) andBtns:self.bottomBtns andDefaultBtnIndex:1];
    self.bottomView.delegate = self;
    [self.view addSubview:self.bottomView];
}

#pragma mark bottomViewDelegate
//点击返回按钮
-(void)clickBottomViewCancelBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
//点击确定按钮
-(void)clickBottomViewEnsureBtn:(UIButton *)sender{
    
    UIImage *image = [self.cropView cropImgae];
    if ([self.delegate respondsToSelector:@selector(backCropImage:)]) {
        [self.delegate backCropImage:image];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
//点击ScrollView里面的按钮
-(void)clickBottomViewBtns:(UIButton *)sender andIndex:(NSInteger)index{
    
    CGSize size = [self.cropView.cropOverlayView cropScale:CGSizeFromString(self.cropScales[index-1])];
    [self.cropView.cropOverlayView changeScale:size];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
