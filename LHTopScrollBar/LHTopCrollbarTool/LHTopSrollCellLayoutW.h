//
//  LHTopSrollCellLayoutW.h
//  LHTopScrollBar
//
//  Created by 李辉 on 2019/3/14.
//  Copyright © 2019 李辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LHScrollBarCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LHTopSrollCellLayoutW : NSObject
@property(nonatomic,strong)NSAttributedString*attStr;
@property(nonatomic,assign)CGFloat cellWidth;
@property(nonatomic,assign)CGRect cellRect;
@property(nonatomic,assign)NSInteger cellIndex;
@property(nonatomic,assign)CGFloat farFromRightCenter;
@property(nonatomic,assign)CGFloat farFromLeftCenter;

@property(nonatomic,assign)CGFloat tx_right;
@property(nonatomic,assign)CGFloat tx_left;
@property(nonatomic,assign)CGFloat zoom_left;
@property(nonatomic,assign)CGFloat zoom_right;
@property(nonatomic,assign)CGFloat start;
-(instancetype)initWithModel:(LHScrollBarCellModel*)model and:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
