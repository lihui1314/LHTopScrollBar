//
//  LHTouchView.m
//  LHTopScrollBar
//
//  Created by 李辉 on 2019/3/14.
//  Copyright © 2019 李辉. All rights reserved.
//

#import "LHTouchView.h"

@implementation LHTouchView{
    UIColor *_backColor;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    _backColor = self.backgroundColor;
   
    if ([self.delegate respondsToSelector:@selector(lh_touchBegin)]) {
        [self.delegate lh_touchBegin];
    }
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    BOOL tOrF = CGRectContainsPoint(rect, point);
    if (tOrF) {
        if ([self.delegate respondsToSelector:@selector(lh_didClickView:)]) {
            [self.delegate lh_didClickView:_viewTag];
        }
        if ([self.delegate respondsToSelector:@selector(lh_tochEnd)]) {
            [self.delegate lh_tochEnd];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(lh_tochEnd)]) {
            [self.delegate lh_tochEnd];
    }
    }
    
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([self respondsToSelector:@selector(lh_tochEnd)]) {
        [self.delegate lh_tochEnd];
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
