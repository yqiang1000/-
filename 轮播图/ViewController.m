//
//  ViewController.m
//  轮播图
//
//  Created by WeibaYeQiang on 16/4/22.
//  Copyright © 2016年 YQ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSArray *imageNames = @[@"QI(1MFTRFN02WPNDOYRF@A1.jpg",@"NRB77}NIOOHABA`XFY[ODQG.jpg",@"T450_RQ9WCBH56VGJALOLV7.jpg",@"S]6N737JBN)_ILMSL3T2XOC.jpg",@"WRU8M4U(_SY2~]_71L3L3UM.jpg"];
//    NSMutableArray *imageNames = [[NSMutableArray alloc] init];
//    for (int i = 0; i < 5; i++) {
//        NSString *string = [NSString stringWithFormat:@"img_0%d.png",i];
//        [imageNames addObject:string];
//    }

    NSArray *imageNames = @[@"img_01.png",@"img_02.png",@"img_03.png",@"img_04.png",@"img_05.png"];
    CGRect frame = CGRectMake((kScreenWidth - 300)/2, 100, 300, 130);
    
    CarouselView *carouseView = [CarouselView createWithFrame:frame ImageNames:imageNames];
    carouseView.delegate = self;
//    carouseView.timer_interval = 3;
    [self.view addSubview:carouseView];
    
}


- (void)carouselView:(CarouselView *)carouselView didSelect:(NSInteger)index {
    NSLog(@">>>> %li",index);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
