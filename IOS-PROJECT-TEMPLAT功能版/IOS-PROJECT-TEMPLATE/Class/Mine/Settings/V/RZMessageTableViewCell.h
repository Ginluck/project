//
//  RZMessageTableViewCell.h
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/22.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "TPBaseTableViewCell.h"
#import "RZMessageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RZMessageTableViewCell : TPBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIButton *lookBtn;
@property (weak, nonatomic) IBOutlet UIButton *cencelBtn;
-(void)setModel:(RZMessageModel *)model type:(NSString *)type;
@end

NS_ASSUME_NONNULL_END
