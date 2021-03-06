//
//  LHTopScrollBar.h
//  LHTopScrollBar
//
//  Created by 李辉 on 2019/3/5.
//  Copyright © 2019 李辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHTopScrollCell.h"
//#define CellPadding 6
NS_ASSUME_NONNULL_BEGIN
@protocol LHTopScrollBarDelegate <NSObject>
-(void)lh_didClicktTopbarCell:(NSInteger)index;
-(void)lh_didSeletCellAtIndex:(NSInteger)seletedIndex;//最终的选中目标
@end
typedef NS_ENUM(NSInteger,LHTopScrollBarType){
    LHTopScrollBarTypelineHiden,
    LHTopScrollBarTypeLineEqCellWidth,
    LHTopScrollBarTypeNormal,
    LHTopScrollBarTypeSpring
    
};
@interface LHTopScrollBar : UIView<UIScrollViewDelegate,LHTouchViewDelegate>
@property(nonatomic,strong)NSMutableArray*clsModelArray;
@property(nonatomic,strong)UIScrollView*scrollView;
@property(nonatomic,weak)id<LHTopScrollBarDelegate>delegate;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,assign)NSInteger selectedIndex;
@property(nonatomic,assign)NSInteger preSeletedIndex;
@property(nonatomic,assign)BOOL viewHaveFirstInit;
@property(nonatomic,assign)LHTopScrollBarType type;
-(void)lh_reloadData;
-(instancetype)initWithFrame:(CGRect)frame dataArray:(nullable NSArray*)array delegate:(nullable id)delegate andType:(LHTopScrollBarType)type;
-(void)lh_mainScrollDidScroll:(CGFloat)rate;
-(void)lh_mainSCrollDidEndDecelerating:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
