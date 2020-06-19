//
//  UIView+CornerRdius.h
//  apple
//
//  Created by he on 16/3/29.
//
//

#import <UIKit/UIKit.h>

@interface UIView (CornerRdius)

@property (nonatomic) IBInspectable CGFloat cornerRadius;

/** 头像圆角 */
@property (nonatomic) IBInspectable BOOL avatarCorner;

/** 边框 */
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

/** 1px线 */
@property (nonatomic, getter=isLineView) IBInspectable BOOL lineView;

/** 1px边框 */
@property (nonatomic, getter=isLineBorder) IBInspectable BOOL lineBorder;
@end
