//
//  TravelWebTableViewCell.h
//  路丫租车-三期
//
//  Created by Apple on 2018/10/15.
//  Copyright © 2018年 ginluck. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^ReloadBlock)(void);
@interface TravelWebTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *CWebView;
@property (weak, nonatomic) IBOutlet UIView *WebOutSideView;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (strong, nonatomic)NSString *htmlString;
@property(nonatomic,copy)ReloadBlock reloadBlock;
+(CGFloat)cellHeight;
@end

NS_ASSUME_NONNULL_END
