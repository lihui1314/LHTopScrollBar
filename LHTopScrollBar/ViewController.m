//
//  ViewController.m
//  LHTopScrollBar
//
//  Created by 李辉 on 2019/3/4.
//  Copyright © 2019 李辉. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)UIScrollView*scrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView*topView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, 40)];
    topView.backgroundColor = [UIColor cyanColor];
    self.line = [[UIView alloc]initWithFrame:CGRectMake(-10, 38, 100, 2)];
    self.line.backgroundColor = [UIColor redColor];
    [topView addSubview:self.line];
    [self.view addSubview:topView];
    
    UIButton*button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(300, 200, 60, 30);
    [button setTitle:@"缩放" forState:(UIControlStateNormal)];
    [button setBackgroundColor:[UIColor blueColor]];
    [button addTarget:self action:@selector(btnAc:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//    NSLog(@"%f",self.view.frame.size.width);
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,80,self.view.frame.size.width,self.view.frame.size.height-80)];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width*3, self.view.frame.size.height*2);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    _scrollView.bounces = NO;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scflag = scrollView.contentOffset.x/self.view.frame.size.width;
    
    self.line.transform = CGAffineTransformMakeTranslation(scrollView.contentOffset.x, 0);
    self.line.transform = CGAffineTransformScale(self.line.transform, scflag+1, 1);
   

}
-(void)btnAc:(UIButton*)sender{
    CGAffineTransform t = self.line.transform;
    CGAffineTransform transform = CGAffineTransformScale(t, 0.8, 1);
    [UIView animateWithDuration:0.3 animations:^{
       
        CGAffineTransform transl = CGAffineTransformTranslate(transform, 20, 0);
        self.line.transform = transform;
    
    }];
    
    
   
   
}
-(void)tapAction:(UITapGestureRecognizer*)tap{
    NSLog(@"tap");
}
@end
