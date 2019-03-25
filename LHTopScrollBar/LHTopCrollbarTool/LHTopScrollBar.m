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
#define SeletedCellLabColor [UIColor redColor]
#import "LHTopScrollBar.h"
#import "LHButton.h"
#import "LHScrollBarCellModel.h"
#import "LHTopSrollCellLayoutW.h"
@implementation LHTopScrollBar{
    CGFloat _flagIndex;
    NSMutableArray*_cellArray;
}
-(instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray*)array delegate:(id)delegate andType:(LHTopScrollBarType)type{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        self.type = type;
        self.preSeletedIndex = 0;
        self.selectedIndex = 0;
        self.classInfoArray = [self lh_layOutArrray:array];
        _cellArray = [NSMutableArray array];
        [self addAllSubViews:frame];
    }
    return self;
}

-(void)addAllSubViews:(CGRect)frame{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake([self lh_contentSizeWidth], frame.size.height);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    [_cellArray removeAllObjects];
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
        if (i == _selectedIndex) {
            NSMutableAttributedString*mutaAttStr = (NSMutableAttributedString*)cell.nameLab.attributedText;
            [mutaAttStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, mutaAttStr.length)];
            [mutaAttStr addAttribute:NSStrokeWidthAttributeName value:@(-4) range:NSMakeRange(0, mutaAttStr.length)];
            
        }
        [self.scrollView addSubview:cell];
        [_cellArray addObject:cell];
    }
    _flagIndex = [self lh_calculateFlagIndex];//计算flag坐标位置。
    [self clsArrConfig];
    [self lineLoc];
    [self.scrollView addSubview:self.lineView];

    [self addSubview:self.scrollView];
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

-(UIView*)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor redColor];
    }
    return _lineView;
}
-(UIScrollView*)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
    }
    return _scrollView;
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
    if ([self.delegate respondsToSelector:@selector(lh_didClicktTopbarCell:)]) {
        [self.delegate lh_didClicktTopbarCell:viewTag];
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
        [self calculateOffX:i];
    }
}
//计算标杆坐标
-(NSInteger)lh_calculateFlagIndex{
    if (self.scrollView.contentSize.width>self.scrollView.frame.size.width) {
        if (self.classInfoArray.count>9) {
            for (NSInteger i =0; i<self.classInfoArray.count; i++) {
                LHTopSrollCellLayoutW*lay = self.classInfoArray[i];
                if (lay.cellRect.origin.x+lay.cellRect.size.width>=self.scrollView.frame.size.width) {
                    _flagIndex = i-1;
                    break;
                }
            }
        }else{
            for (NSInteger i = self.classInfoArray.count-1; i>=0; i--) {
                LHTopSrollCellLayoutW*lay = self.classInfoArray[i];
                if (lay.cellRect.origin.x+lay.cellRect.size.width>=self.scrollView.frame.size.width) {
                    LHTopSrollCellLayoutW*layN = self.classInfoArray[i-1];
                    if ((layN.cellRect.origin.x+layN.cellRect.size.width)<=self.scrollView.frame.size.width) {
                        _flagIndex = i-1;
                        break;
                    }
                }
            }
        }
       
    }
    if (_flagIndex == 0) {
        _flagIndex = self.classInfoArray.count;
    }
    return _flagIndex;
}
//计算offX；scrollView的偏移量
-(void)calculateOffX:(NSInteger)index{
    LHTopSrollCellLayoutW*layout = self.classInfoArray[index];
    NSInteger criticalIndex=_flagIndex;
   
    NSInteger flagIndex = criticalIndex/2;
    if (index<=flagIndex) {
        layout.offx=0;
    }else if (flagIndex<index && index<self.classInfoArray.count-1-flagIndex) {
         CGFloat offX = layout.cellRect.origin.x+layout.cellWidth/2  - self.scrollView.frame.size.width/2;
        layout.offx = offX;
    }else{
        CGFloat contentWidth = [self lh_contentSizeWidth];
        layout.offx = contentWidth - self.scrollView.frame.size.width;
    }
    
}
#pragma mark MainScrollViewDidEndDecelerating
-(void)lh_mainSCrollDidEndDecelerating:(NSInteger)index{
    LHTopSrollCellLayoutW* lay = self.classInfoArray[index];
    LHTopSrollCellLayoutW*preLay = self.classInfoArray[_preSeletedIndex];
    [UIView animateWithDuration:0.2 animations:^{
        self.scrollView.contentOffset = CGPointMake(lay.offx, 0);
    }];
    LHTopScrollCell*preCell = _cellArray[_preSeletedIndex];
    NSMutableAttributedString*preMutaAttStr = preLay.attStr;
    [preMutaAttStr removeAttribute:NSForegroundColorAttributeName range:NSMakeRange(0,preMutaAttStr.length )];
    [preMutaAttStr removeAttribute:NSStrokeWidthAttributeName range:NSMakeRange(0,preMutaAttStr.length )];
    preCell.nameLab.attributedText = preMutaAttStr;
    
    LHTopScrollCell*cell = _cellArray[index];
    NSMutableAttributedString*mutaAttStr = lay.attStr;
    [mutaAttStr addAttribute:NSForegroundColorAttributeName value:SeletedCellLabColor range:NSMakeRange(0, mutaAttStr.length)];
    [mutaAttStr addAttribute:NSStrokeWidthAttributeName value:@(-4) range:NSMakeRange(0, mutaAttStr.length)];
    cell.nameLab.attributedText = mutaAttStr;
    self.preSeletedIndex = index;
    if ([self.delegate respondsToSelector:@selector(lh_didSeleCellAtIndex:)]) {
        [self.delegate lh_didSeleCellAtIndex:index];
    }
}

-(void)lh_reloadData{
    [self.scrollView removeFromSuperview];
    [self addAllSubViews:self.frame];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
