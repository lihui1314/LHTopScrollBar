//
//  LHTopScrollCell.m
//  LHTopScrollBar
//
//  Created by 李辉 on 2019/3/14.
//  Copyright © 2019 李辉. All rights reserved.
//
#define topP 5
#define LeftP 0
#import "LHTopScrollCell.h"

@implementation LHTopScrollCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self lh_setAllSubViews:frame];
    }
    return self;
}

-(void)lh_setAllSubViews:(CGRect)frame{
    NSLog(@"%f",frame.origin.x);
    _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(LeftP, topP, self.frame.size.width-LeftP*2, self.frame.size.height-2*topP)];
    [self addSubview:_nameLab];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
