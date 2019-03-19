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
-(void)lh_didSelectedTopbarCell:(NSInteger)index;
@optional
-(NSInteger)numberOfCells;
-(NSString*)barTitle;
-(CGFloat)widthOfCell:(NSInteger)index;
@end
typedef NS_ENUM(NSInteger,LHTopScrollBarType){
    LHTopScrollBarTypePanda,
    LHTopScrollBarTypeNormal,
    LHTopScrollBarTypeSpring
    
};
@interface LHTopScrollBar : UIView<UIScrollViewDelegate,LHTouchViewDelegate>
@property(nonatomic,strong)NSMutableArray*classInfoArray;
@property(nonatomic,strong)UIScrollView*scrollView;
@property(nonatomic,weak)id<LHTopScrollBarDelegate>delegate;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,assign)NSInteger selectedIndex;
@property(nonatomic,assign)NSInteger preSeletedIndex;
@property(nonatomic,assign)BOOL viewHaveFirstInit;
@property(nonatomic,assign)LHTopScrollBarType type;
-(void)lh_reloadData;
-(instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray*)array delegate:(id)delegate andType:(LHTopScrollBarType)type;
-(void)lh_mainScrollDidScroll:(CGFloat)rate;
@end

NS_ASSUME_NONNULL_END
