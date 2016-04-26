//
//  CarouselView.m
//  轮播图
//
//  Created by WeibaYeQiang on 16/4/22.
//  Copyright © 2016年 YQ. All rights reserved.
//

#import "CarouselView.h"

#define timer_interval 2

@interface CarouselView()

@property (strong, nonatomic) NSArray *imageNames;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (nonatomic, assign) CGFloat kWidth;
@property (nonatomic, assign) CGFloat kHeight;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation CarouselView

- (id)initWithFrame:(CGRect)frame ImageNames:(NSArray *)imageNames {
    self = [super init];
    if (self) {
        self.frame = frame;
        _kWidth = frame.size.width;
        _kHeight = frame.size.height;
        _imageNames = [NSArray arrayWithArray:imageNames];
        [self createView];
        [self createTimer];
    }
    return self;
}

+ (id)createWithFrame:(CGRect)frame ImageNames:(NSArray *)imageNames {
    return [[CarouselView alloc] initWithFrame:frame ImageNames:imageNames];
}

- (void)createView {
    //滑动视图
    if (self.scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    }
    _scrollView.contentSize = CGSizeMake(_kWidth * (_imageNames.count + 2), _kHeight);
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    //轮播图
    for (int i = 0; i < _imageNames.count + 2; i++) {

        NSString *imageName = [[NSString alloc] init];
        if (i == 0 ) {
            imageName = _imageNames[_imageNames.count - 1];
        } else if (i == _imageNames.count + 1) {
            imageName = _imageNames[0];
        } else {
            imageName = _imageNames[i -1];
        }
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_kWidth * i, 0, _kWidth, _kHeight)];
        imageView.image = [UIImage imageNamed:imageName];
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [imageView addGestureRecognizer:tap];
        
        [_scrollView addSubview:imageView];
    }
    [_scrollView setContentOffset:CGPointMake(_kWidth, 0) animated:YES];
    [self addSubview:_scrollView];
    
    //page
    if (self.pageControl == nil) {
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _kHeight - 20, _kWidth, 20)];
    }
    self.pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.numberOfPages = _imageNames.count;
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = [UIColor redColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor yellowColor];
    [self addSubview:self.pageControl];
}

#pragma mark - 轮播图点击事件
- (void)tapAction:(UITapGestureRecognizer *)tap {
    NSInteger tag = tap.view.tag;
    if (tag == 0) {
        tag = _imageNames.count;
    } else if (tag == _imageNames.count + 1)
        tag = 1;
    if ([self.delegate respondsToSelector:@selector(carouselView:didSelect:)]) {
        [self.delegate carouselView:self didSelect:tag - 1];
    }
}

#pragma mark - 创建定时器
- (void)createTimer {
    
    if (self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:timer_interval target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    }
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

//下一张图片
- (void)nextImage {
    NSInteger index = self.pageControl.currentPage;
    if (index == _imageNames.count + 1) {
        index = 0;
    } else {
        index++;
    }
    [self.scrollView setContentOffset:CGPointMake((index + 1) * _kWidth, 0)animated:YES];
    
}


#pragma mark - scrollView delegate
//将要开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //定时器停止
    [self.timer invalidate];
    self.timer = nil;
}

//将要停止拖拽
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
}

//已经结束拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

    [self performSelector:@selector(createTimer) withObject:nil afterDelay:2];
}

//结束减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    int index = (self.scrollView.contentOffset.x + _kWidth * 0.5) / _kWidth;
    if (index == _imageNames.count + 1) {
        [self.scrollView setContentOffset:CGPointMake(_kWidth, 0) animated:NO];
    } else if (index == 0) {
        [self.scrollView setContentOffset:CGPointMake(_imageNames.count * _kWidth, 0) animated:NO];
    }
}

//结束滑动动画
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / _kWidth;
    if (index == _imageNames.count + 1) {
        index = 1;
    } else if (index == 0) {
        index = _imageNames.count;
    }
    self.pageControl.currentPage = index - 1;
}

@end
