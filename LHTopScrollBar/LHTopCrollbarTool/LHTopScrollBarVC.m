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
                      @{@"cellTtitle":@"橙色Orange",@"clsName":@"2"},
                      @{@"cellTtitle":@"黄色Yellow",@"clsName":@"3"},
                      @{@"cellTtitle":@"Green",@"clsName":@"4"},
                      @{@"cellTtitle":@"青色",@"clsName":@"5"},
                      @{@"cellTtitle":@"蓝色Blue",@"clsName":@"6"},
                       @{@"cellTtitle":@"紫",@"clsName":@"7"}
                      ];
    NSArray*colorArray = @[[UIColor redColor],
                           [UIColor orangeColor],
                           [UIColor yellowColor],
                           [UIColor greenColor],
                           [UIColor cyanColor],
                           [UIColor blueColor],
                           [UIColor purpleColor],
                           
                           ];
    for (NSInteger i =0; i<array.count; i++) {
        NSDictionary*dic = array[i];
        LHScrollBarCellModel*model = [[LHScrollBarCellModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [mutArr addObject:model];
        
    }
    LHTopScrollBar*bar = [[LHTopScrollBar alloc]initWithFrame:CGRectMake(10, 44, 300, 44) dataArray:mutArr delegate:self andType:LHTopScrollBarTypeSpring];
    bar.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _scBar = bar;
    [self.view addSubview:bar];
    
    self.mainScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 88, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height-88)];
    self.mainScrollerView.contentSize =CGSizeMake(UIScreen.mainScreen.bounds.size.width*array.count, self.mainScrollerView.frame.size.height-1);
    //
    for (NSInteger i =0; i<array.count; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i*UIScreen.mainScreen.bounds.size.width, 0, UIScreen.mainScreen.bounds.size.width, self.mainScrollerView.frame.size.height)];
        view.backgroundColor = colorArray[i];
        [self.mainScrollerView addSubview:view];
    }
    //
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
    [self.scBar lh_mainSCrollDidEndDecelerating:self.scBar.selectedIndex];
    
}
#pragma mark LHTopScrollBarDelegate
-(void)lh_didClicktTopbarCell:(NSInteger)index{
    self.mainScrollerView.contentOffset = CGPointMake(UIScreen.mainScreen.bounds.size.width*index,0);
    [self.scBar lh_mainSCrollDidEndDecelerating:index];
}

//做刷新等相关操作
-(void)lh_didSeletCellAtIndex:(NSInteger)seletedIndex{
    
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
