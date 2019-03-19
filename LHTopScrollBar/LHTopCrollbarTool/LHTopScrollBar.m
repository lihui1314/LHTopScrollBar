//
//  LHTopScrollBar.m
//  LHTopScrollBar
//
//  Created by 李辉 on 2019/3/5.
//  Copyright © 2019 李辉. All rights reserved.
//
#define topH = 40
#define lineMinWidth 35
#define CellPadding 25
#import "LHTopScrollBar.h"
#import "LHButton.h"
#import "LHScrollBarCellModel.h"
#import "LHTopSrollCellLayoutW.h"
@implementation LHTopScrollBar
-(instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray*)array delegate:(id)delegate andType:(LHTopScrollBarType)type{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        self.type = type;
        self.preSeletedIndex = 0;
        self.selectedIndex = 0;
        self.classInfoArray = [self lh_layOutArrray:array];
        [self addAllSubViews:frame];
    }
    return self;
}

-(void)addAllSubViews:(CGRect)frame{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake([self lh_contentSizeWidth], frame.size.height);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    CGFloat x =0;
    for (NSInteger i =0; i<_classInfoArray.count; i++) {
        LHTopSrollCellLayoutW*layout = _classInfoArray[i];
        
        if (i>0) {
            LHTopSrollCellLayoutW *preLayout =_classInfoArray[i-1];
            x += CellPadding+preLayout.cellWidth;
        }else{
            x =CellPadding;
        }
        CGRect rect = CGRectMake(x, 0, layout.cellWidth, frame.size.height-1);
        layout.cellRect =rect;
        LHTopScrollCell*cell = [[LHTopScrollCell alloc]initWithFrame:rect];
        cell.nameLab.attributedText = layout.attStr;
        cell.delegate = self;
        cell.viewTag = i;
        [self.scrollView addSubview:cell];
    }
    [self clsArrConfig];
    [self lineLoc];
    [self.scrollView addSubview:self.lineView];

    [self addSubview:_scrollView];
}
-(NSMutableArray*)lh_layOutArrray:(NSArray*)array{
    NSMutableArray*muteArray = [NSMutableArray array];
    for (NSInteger i = 0; i<array.count; i++) {
        LHTopSrollCellLayoutW*lay = [[LHTopSrollCellLayoutW alloc]initWithModel:array[i] and:i];
        [muteArray addObject:lay];
    }
    return muteArray;
    
}
-(CGFloat)lh_contentSizeWidth{
    CGFloat width = 0.0;
    for (NSInteger i=0; i<_classInfoArray.count; i++) {
        LHTopSrollCellLayoutW*model = _classInfoArray[i];
        width+=model.cellWidth;
    }
    return (width+CellPadding*(_classInfoArray.count+1));
}
-(void)lh_reloadData{
}
-(UIView*)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor redColor];
    }
    return _lineView;
}
-(void)lineLoc{
//    __weak typeof(self)wek = self;
    if (self.type ==LHTopScrollBarTypePanda) {
        [UIView animateWithDuration:0.1 animations:^{
            LHTopSrollCellLayoutW*lay = self.classInfoArray[self.selectedIndex];
            self.lineView.frame = CGRectMake(lay.cellRect.origin.x, lay.cellRect.size.height-5, lay.cellRect.size.width, 2);
        }];
    }
    if (self.type == LHTopScrollBarTypeNormal) {
        LHTopSrollCellLayoutW*lay = self.classInfoArray[self.preSeletedIndex];
        LHTopSrollCellLayoutW*layNow = self.classInfoArray[self.selectedIndex];
        CGFloat movex =
        layNow.cellRect.origin.x+layNow.cellRect.size.width/2-(lay.cellRect.origin.x+lay.cellRect.size.width/2);
        if (!_viewHaveFirstInit) {
            CGFloat dx = (lay.cellRect.size.width-lineMinWidth)/2;
            CGFloat x = lay.cellRect.origin.x+dx;
            self.lineView.frame = CGRectMake(x, lay.cellRect.size.height-5, lineMinWidth, 3);
        }else{
            self.lineView.transform = CGAffineTransformMakeTranslation(movex, 0);
        }
        _viewHaveFirstInit =YES;
       
    }
   
}
-(void)lh_mainScrollDidScroll:(CGFloat)rate{
//    self.selectedIndex = (NSInteger)rate;
//    CGFloat distance = 0;
    NSLog(@"self.selectedIndex->%ld",self.selectedIndex);
//    LHTopSrollCellLayoutW *layW = self.classInfoArray[self.selectedIndex];
//    distance = (rate>self.selectedIndex)?layW.farFromRightCenter:layW.farFromLeftCenter;
//    CGPoint centerP = CGPointMake(layW.cellRect.origin.x +layW.cellWidth/2, self.lineView.center.y);
//    self.lineView.center = CGPointMake(centerP.x+(rate-self.selectedIndex)*distance, centerP.y);
//    if (rate-self.selectedIndex>0) {
    //整数部分
    int index = (int)rate;
    LHTopSrollCellLayoutW *layW = self.classInfoArray[index];
    //小数部分
      rate = rate - index;
    if (rate<0.5&&rate>=0) {
        self.lineView.transform = CGAffineTransformMakeTranslation(layW.tx_right*rate*2+layW.start, 0);
        NSLog(@"f->%f",layW.tx_right*rate*2+layW.start);
        NSLog(@"xx->%f",self.lineView.frame.origin.x);
        self.lineView.transform = CGAffineTransformScale(self.lineView.transform,(layW.zoom_right/lineMinWidth-1)*rate*2+1, 1);
    }else if(rate>0.5 && rate<=1){
        self.lineView.transform = CGAffineTransformMakeTranslation(layW.tx_right*rate*2+layW.start, 0);
         self.lineView.transform = CGAffineTransformScale(self.lineView.transform,layW.zoom_right/lineMinWidth-(layW.zoom_right/lineMinWidth-1)*(rate-0.5)*2, 1);
    }
    
}

#pragma mark LHTouchViewDelegate
-(void)lh_didClickView:(NSInteger)viewTag{
    self.selectedIndex = viewTag;
    [self lineLoc];
    if ([self.delegate respondsToSelector:@selector(lh_didSelectedTopbarCell:)]) {
        [self.delegate lh_didSelectedTopbarCell:viewTag];
    }
}
-(void)lh_touchBegin{
    
}
#pragma mark clsarrD
-(void)clsArrConfig{
    for (NSInteger i =0; i<self.classInfoArray.count; i++) {
        LHTopSrollCellLayoutW *lay = self.classInfoArray[i];
        lay.start = lay.cellRect.origin.x + (lay.cellRect.size.width-lineMinWidth)/2-CellPadding;
        NSInteger next = i+1;
        if (next<self.classInfoArray.count) {
            
            LHTopSrollCellLayoutW*layNext = self.classInfoArray[next];
            CGFloat farFromRight = layNext.cellRect.origin.x+layNext.cellWidth/2-lay.cellRect.origin.x-lay.cellWidth/2;
            lay.farFromRightCenter = farFromRight;
            layNext.farFromLeftCenter = farFromRight;
            //
            lay.zoom_right = (layNext.cellRect.size.width+layNext.cellRect.origin.x-lay.cellRect.origin.x-(lay.cellRect.size.width-lineMinWidth)/2-(layNext.cellRect.size.width-lineMinWidth)/2);
            layNext.zoom_left = lay.zoom_right;
            
            lay.tx_right = (lay.zoom_right-lineMinWidth)/2;
            layNext.tx_left = lay.tx_right;
           
            
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
