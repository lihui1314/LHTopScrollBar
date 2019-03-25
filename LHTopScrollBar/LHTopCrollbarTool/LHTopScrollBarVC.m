//
//  LHTopScrollBarVC.m
//  LHTopScrollBar
//
//  Created by 李辉 on 2019/3/4.
//  Copyright © 2019 李辉. All rights reserved.
//

#import "LHTopScrollBarVC.h"
#import "LHTopScrollBar.h"
#import "LHScrollBarCellModel.h"
@interface LHTopScrollBarVC ()<UIScrollViewDelegate,LHTopScrollBarDelegate>{
    
}
@property(nonatomic,strong)UIScrollView*mainScrollerView;
@property(nonatomic,strong)LHTopScrollBar *scBar;

@end

@implementation LHTopScrollBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray*mutArr = [NSMutableArray array];
    NSArray*array = @[@{@"cellTtitle":@"红色",@"clsName":@"1"},
                      @{@"cellTtitle":@"橙sd色",@"clsName":@"2"},
                      @{@"cellTtitle":@"黄ssss蓝",@"clsName":@"3"},
                      @{@"cellTtitle":@"绿色",@"clsName":@"4"},
                      @{@"cellTtitle":@"青色",@"clsName":@"5"},
                      @{@"cellTtitle":@"蓝色",@"clsName":@"6"},
                      @{@"cellTtitle":@"蓝色",@"clsName":@"6"},
                      @{@"cellTtitle":@"蓝色",@"clsName":@"6"},
                      @{@"cellTtitle":@"蓝色",@"clsName":@"6"},
                      @{@"cellTtitle":@"蓝色",@"clsName":@"6"}
                      ];
    for (NSInteger i =0; i<array.count; i++) {
        NSDictionary*dic = array[i];
        LHScrollBarCellModel*model = [[LHScrollBarCellModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [mutArr addObject:model];
        
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(lh_canDoRefreshVC:) name:@"LHDIDENDSCROLL" object:nil];
    LHTopScrollBar*bar = [[LHTopScrollBar alloc]initWithFrame:CGRectMake(10, 44, 300, 44) dataArray:mutArr delegate:self andType:LHTopScrollBarTypeNormal];
    bar.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _scBar = bar;
    [self.view addSubview:bar];
    
    self.mainScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 88, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height-88-34)];
    self.mainScrollerView.contentSize =CGSizeMake(UIScreen.mainScreen.bounds.size.width*array.count, self.mainScrollerView.frame.size.height-1);
    self.mainScrollerView.pagingEnabled = YES;
    self.mainScrollerView.delegate = self;
    self.mainScrollerView.backgroundColor = [UIColor cyanColor];
    self.mainScrollerView.bounces=NO;
    [self.view addSubview:self.mainScrollerView];
    // Do any additional setup after loading the view.
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat rate =  scrollView.contentOffset.x/UIScreen.mainScreen.bounds.size.width;
         [self.scBar lh_mainScrollDidScroll:rate];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    self.scBar.selectedIndex = (NSInteger)(scrollView.contentOffset.x/UIScreen.mainScreen.bounds.size.width);
//    self.scBar.preSeletedIndex= self.scBar.selectedIndex;
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"LHDIDENDSCROLL" object:@{@"index":@(self.scBar.selectedIndex)}];
    [self.scBar lh_mainSCrollDidEndDecelerating:self.scBar.selectedIndex];
    
}
#pragma mark LHTopScrollBarDelegate
-(void)lh_didClicktTopbarCell:(NSInteger)index{
    self.mainScrollerView.contentOffset = CGPointMake(UIScreen.mainScreen.bounds.size.width*index,0);
    [self.scBar lh_mainSCrollDidEndDecelerating:index];
}

//做刷新等相关操作
-(void)lh_didSeleCellAtIndex:(NSInteger)seletedIndex{
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
