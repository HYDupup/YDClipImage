//
//  BottomView.m
//  poco_CropImage
//
//  Created by mac on 17/7/26.
//  Copyright © 2017年 HYD. All rights reserved.
//

#import "BottomView.h"

@interface BottomView()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *scrollView;

@property (nonatomic,strong)UIButton *cancelBtn;
@property (nonatomic,strong)UIButton *ensureBtn;

@property (nonatomic,strong)NSArray *btns;
@property (nonatomic,assign)NSInteger defaultBtnIndex;

@end

@implementation BottomView

-(instancetype)initWithFrame:(CGRect)frame andBtns:(NSArray *)btns{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor blackColor]];
        self.btns = btns;
        [self creatUI];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame andBtns:(NSArray *)btns andDefaultBtnIndex:(NSInteger)defaultBtnIndex{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor blackColor]];
        self.btns = btns;
        self.defaultBtnIndex = defaultBtnIndex;
        [self creatUI];
    }
    return self;
}

#pragma mark 懒加载
-(NSArray *)btns{
    if (_btns == nil) {
        _btns = [[NSArray alloc]init];
    }
    return _btns;
}

-(void)creatUI{
    
    self.cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.height, self.height)];
    [self.cancelBtn setBackgroundColor:HYDColour(38.0f, 43.0f, 49.0f)];
    [self.cancelBtn setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelBtn];
    
    self.ensureBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width-self.height, 0, self.height, self.height)];
    [self.ensureBtn setBackgroundColor:HYDColour(38.0f, 43.0f, 49.0f)];
    [self.ensureBtn setImage:[UIImage imageNamed:@"ensure"] forState:UIControlStateNormal];
    [self.ensureBtn addTarget:self action:@selector(clickEnsureBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.ensureBtn];
    
    if (self.btns.count != 0) {
        [self creatScrollView];
    }
    
}

-(void)creatScrollView{
    CGFloat btnWidth;
    if (self.btns.count < 4) {
        btnWidth = (self.width - 2*self.height - self.btns.count - 1)/self.btns.count;
    }else{
        btnWidth = (self.width - 2*self.height - 5)/4;
    }
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(self.height, 0, self.width-2*self.height, self.height)];
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.scrollView setContentSize:CGSizeMake(self.btns.count*btnWidth+self.btns.count+1, 0)];
    [self.scrollView setBackgroundColor:[UIColor blackColor]];
    [self addSubview:self.scrollView];
    
    for (int i=0; i<self.btns.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(1*(i+1)+i*btnWidth, 0, btnWidth, self.scrollView.height)];
        [btn setTitle:self.btns[i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [btn setBackgroundColor:HYDColour(38.0f, 43.0f, 49.0f)];
        btn.tag = i+1;
        [btn addTarget:self action:@selector(clickBtns:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];
        
        if (self.defaultBtnIndex > 0 && self.defaultBtnIndex <= self.btns.count) {
            if (self.defaultBtnIndex == i+1) {
                btn.enabled = NO;
                [btn setBackgroundColor:HYDColour(58.0f, 63.0f, 67.0f)];
            }
        }
    }
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
}
#pragma mark BottomDelegate
-(void)clickCancelBtn:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(clickBottomViewCancelBtn:)]) {
        [self.delegate clickBottomViewCancelBtn:sender];
    }
}
-(void)clickEnsureBtn:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(clickBottomViewEnsureBtn:)]) {
        [self.delegate clickBottomViewEnsureBtn:sender];
    }
}
-(void)clickBtns:(UIButton *)sender{
    for (int i=1; i<=self.btns.count; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:i];
        if (i == (int)sender.tag ) {
            btn.enabled = NO;
            [btn setBackgroundColor:HYDColour(58.0f, 63.0f, 67.0f)];
        }else{
            btn.enabled = YES;
            [btn setBackgroundColor:HYDColour(38.0f, 43.0f, 49.0f)];
        }
    }
    
    CGFloat rectX = 2*sender.width;
    CGRect offset = [self.scrollView convertRect:sender.frame toView:self];
    
    CGFloat initialX = self.scrollView.contentOffset.x;

    if (offset.origin.x < rectX && offset.origin.x > 0) {
        CGFloat x = rectX - offset.origin.x;
        initialX = initialX - x;
        if (initialX <= 0) {
            initialX = 0;
        }
    }else if(offset.origin.x > rectX+sender.width){
        CGFloat x = offset.origin.x - rectX - sender.width;
        initialX = initialX + x;
        if (initialX > self.scrollView.contentSize.width - self.scrollView.width) {
            initialX = self.scrollView.contentSize.width - self.scrollView.width;
        }
    }
    [self.scrollView setContentOffset:CGPointMake(initialX, 0) animated:YES];
    
    
    if ([self.delegate respondsToSelector:@selector(clickBottomViewBtns:andIndex:)]) {
        [self.delegate clickBottomViewBtns:sender andIndex:sender.tag];
    }
}

@end
