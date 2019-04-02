//
//  LHTouchView.h
//  LHTopScrollBar
//
//  Created by 李辉 on 2019/3/14.
//  Copyright © 2019 李辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol LHTouchViewDelegate <NSObject>
@optional
-(void)lh_didClickView:(NSInteger)viewTag;
-(void)lh_touchBegin;
-(void)lh_tochEnd;

@end
@interface LHTouchView : UIView
@property(nonatomic,assign)NSInteger viewTag;
@property(nonatomic,strong)id<LHTouchViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
