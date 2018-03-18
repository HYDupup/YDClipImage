//
//  BottomView.h
//  poco_CropImage
//
//  Created by mac on 17/7/26.
//  Copyright © 2017年 HYD. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BottomViewDelegate <NSObject>

@optional

-(void)clickBottomViewCancelBtn:(UIButton *)sender;
-(void)clickBottomViewEnsureBtn:(UIButton *)sender;

-(void)clickBottomViewBtns:(UIButton *)sender andIndex:(NSInteger)index;

@end

@interface BottomView : UIView

/*
 frame:BottomView的frame
 btns:BottomView中间部分按钮，显示的文字内容
 */
-(instancetype)initWithFrame:(CGRect)frame andBtns:(NSArray *)btns;

/*
 frame:BottomView的frame
 btns:BottomView中间部分按钮，显示的文字内容
 defaultBtnIndex:BottomView中间部分按钮,默认的选择的按钮位置
 defaultBtnIndex = [1,+无穷]
 */
-(instancetype)initWithFrame:(CGRect)frame andBtns:(NSArray *)btns andDefaultBtnIndex:(NSInteger)defaultBtnIndex;

@property (nonatomic,weak)id<BottomViewDelegate>delegate;

@end
