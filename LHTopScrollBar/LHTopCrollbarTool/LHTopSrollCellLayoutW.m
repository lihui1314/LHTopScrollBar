//
//  LHTopSrollCellLayoutW.m
//  LHTopScrollBar
//
//  Created by 李辉 on 2019/3/14.
//  Copyright © 2019 李辉. All rights reserved.
//

#import "LHTopSrollCellLayoutW.h"

@implementation LHTopSrollCellLayoutW
-(instancetype)initWithModel:(LHScrollBarCellModel *)model and:(NSInteger)index{
    self = [super init];
    if (self) {
        [self lh_config:model];
        self.cellIndex = index;
    }
    return self;
}
-(void)lh_config:(LHScrollBarCellModel*)model{
    _attStr = [[NSMutableAttributedString alloc]initWithString:model.cellTtitle attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    _cellWidth = [self lh_computeCellWidth];
    
}
-(CGFloat)lh_computeCellWidth{
  CGRect rect =  [self.attStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:(NSStringDrawingUsesLineFragmentOrigin) context:nil];
    return rect.size.width;
}
@end
