//
//  GusetChooseCityView.h
//  HouseAssistantAPP
//
//  Created by Apple on 2019/7/19.
//  Copyright © 2019 Apple. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN
typedef void (^CityModelBlock)(NSString *shengId,NSString *shengName,NSString *shiId,NSString *shiName,NSString *xianId,NSString *xianName);
@interface GusetChooseCityView : UIView
@property (weak, nonatomic) IBOutlet UIButton *CencelBtn;
@property (strong, nonatomic) CityModelBlock CMBlock;
@end

NS_ASSUME_NONNULL_END
