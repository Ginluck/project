//
//  GongPinDetialTopView.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by Apple on 2020/5/11.
//  Copyright © 2020 梦境网络. All rights reserved.
//

#import "GongPinDetialTopView.h"
#import "CusPageControlWithView.h"
@interface GongPinDetialTopView ()<SDCycleScrollViewDelegate>
{
    CusPageControlWithView *pageView;
    
}
@end
@implementation GongPinDetialTopView
-(void)awakeFromNib
{
    [super  awakeFromNib];
     [self requestBanner];
}
-(void)requestBanner
{
//    [RequestHelp POST:HOMEPAGE_ROTATION_URL parameters:@{} success:^(id result) {
//        DLog(@"result %@",result);
//        NSMutableArray *arr=[NSMutableArray array];
//        for (int i =0; i<[result[@"list"]count]; i++) {
//            [arr addObject:result[@"list"][i][@"url"] ];
//        }
//        [self setArrBanners:[NSArray arrayWithArray:arr]];
//    } failure:^(NSError *error) {
//
//    }];
}
- (void)setArrBanners:(NSArray *)arrBanners{
    //    arrBanners = arrBanners;
    
    CGRect rectValue=CGRectMake(self.bannerView.frame.size.width-16-25*arrBanners.count, self.bannerView.frame.size.height-70, 25*arrBanners.count, 33);
    UIImage *currentImage=[UIImage imageNamed:@"slidePoint"];
    UIImage *pageImage=[UIImage imageNamed:@"slideCirclePoint"];
    if (!pageView) {
        pageView=[CusPageControlWithView cusPageControlWithView:rectValue pageNum:arrBanners.count currentPageIndex:0 currentShowImage:currentImage pageIndicatorShowImage:pageImage];
    }
    [self.bannerView addSubview:pageView];
    self.bannerView.delegate =self;
    self.bannerView.imageURLStringsGroup = arrBanners;
    [self.bannerView setPlaceholderImage:[UIImage imageNamed:@"home_header"]];
    //    self.bannerView.pageControlBottomOffset = 35;
    self.bannerView.currentPageDotColor = NavigationBar_BGCOLOR;
    self.bannerView.pageDotColor = [UIColor whiteColor];
    self.bannerView.autoScroll = YES;
    
    
    self.bannerView.itemDidScrollOperationBlock = ^(NSInteger currentIndex) {
        self->pageView.indexNumWithSlide=currentIndex;
    };
    
    self.bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.bannerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    self.bannerView.showPageControl=NO;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
