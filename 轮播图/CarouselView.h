//
//  CarouselView.h
//  轮播图
//
//  Created by WeibaYeQiang on 16/4/22.
//  Copyright © 2016年 YQ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CarouselView;

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@protocol CarouselViewDelegate <NSObject>

@optional
- (void)carouselView:(CarouselView *)carouselView didSelect:(NSInteger)index;

@end


@interface CarouselView : UIView<UIScrollViewDelegate>

@property (assign, nonatomic) id <CarouselViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame ImageNames:(NSArray *)imageNames;
+ (id)createWithFrame:(CGRect)frame ImageNames:(NSArray *)imageNames;

@end
