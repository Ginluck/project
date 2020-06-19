//
//  AddrChooseController.m
//  IOS-PROJECT-TEMPLATE
//
//  Created by ginluck on 2020/5/19.
//  Copyright © 2020年 梦境网络. All rights reserved.
//

#import "AddrChooseController.h"
//引入地图库头文件

@interface AddrChooseController ()<QMapViewDelegate,QMSSearchDelegate>
@property(nonatomic,weak)IBOutlet UITableView * tableView;

@property(nonatomic,weak)IBOutlet UITableView * tableView1;
@property (nonatomic, strong) QMapView *mapView;
@property (nonatomic, strong) QMSSearcher *searcher;
@property (nonatomic, strong) NSArray *dataAry;
@property (nonatomic, strong) NSArray *dataAry1;
@property(nonatomic,weak)IBOutlet UITextField * searchTF;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong)  QMSSuggestionSearchOption*sugOption;
@end

@implementation AddrChooseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUIComeoents];
}
-(IBAction)backCLick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(QMSSearcher*)searcher
{
    if (!_searcher) {
        _searcher =[[QMSSearcher alloc]init];
        _searcher.delegate=self;
    }
    return _searcher;
}
-(QMSSuggestionSearchOption *)sugOption
{
    if (!_sugOption)
    {
        _sugOption =[[QMSSuggestionSearchOption alloc]init];
    }
    return _sugOption;
}
-(void)setUIComeoents
{

    self.KNavHeight.constant=kNavagationBarH;
    [self.KNavView setNeedsLayout];
    self.mapView = [[QMapView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-kNavagationBarH-200-kBottomLayout)];
    //接受地图的delegate回调
    self.mapView.delegate = self;
    //把mapView添加到view中进行显示
    // 开启定位
    [self.mapView setShowsUserLocation:YES];
    [self.mapView setUserTrackingMode:QUserTrackingModeFollow];
    [self.midView addSubview:self.mapView];

    
  
    [self.searchTF addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:(UIControlEventEditingChanged)];
}


- (void)textFieldValueChanged:(UITextField *)textField
{
    if (textField.text.length)
    {
           self.sugOption.keyword =textField.text;
        [self.searcher searchWithSuggestionSearchOption:self.sugOption];
    }
}
- (void)searchWithSuggestionSearchOption:(QMSSuggestionSearchOption *)suggestionSearchOption didReceiveResult:(QMSSuggestionResult *)suggestionSearchResult
{
    NSLog(@"suggest result:%@", suggestionSearchResult);
    self.dataAry1=suggestionSearchResult.dataArray;
    if (self.dataAry1.count >0)
    {
        self.tableView1.hidden =NO;
        [self.tableView1 reloadData];
    }
    else
    {
        self.tableView1.hidden=YES;
    }

}
- (void)mapView:(QMapView *)mapView regionDidChangeAnimated:(BOOL)animated gesture:(BOOL)bGesture
{
    CLLocationCoordinate2D centerCoordinate = self.mapView.centerCoordinate;
    [mapView removeAnnotations:mapView.annotations];
    QPointAnnotation *pointAnnotation = [[QPointAnnotation alloc] init];
    pointAnnotation.coordinate = centerCoordinate;
    
    // 将点标记添加到地图中
    [self.mapView addAnnotation:pointAnnotation];
    
    
    QMSReverseGeoCodeSearchOption *revGeoOption = [[QMSReverseGeoCodeSearchOption alloc] init];
    [revGeoOption setLocationWithCenterCoordinate:centerCoordinate];
   [ revGeoOption setGet_poi:YES];
    
    revGeoOption.poi_options = @"page_size=20;page_index=1";

    [self.searcher searchWithReverseGeoCodeSearchOption:revGeoOption];
    
 }
- (void)searchWithReverseGeoCodeSearchOption:(QMSReverseGeoCodeSearchOption *)reverseGeoCodeSearchOption didReceiveResult:(QMSReverseGeoCodeSearchResult *)reverseGeoCodeSearchResult
{
   
    NSLog(@"get result %@",reverseGeoCodeSearchResult);
    self.dataAry =reverseGeoCodeSearchResult.poisArray;
    [self.tableView reloadData];
}

- (void)searchWithSearchOption:(QMSSearchOption *)searchOption didFailWithError:(NSError*)error;
{
    MKLog(@"%@",error);
}
- (void)mapView:(QMapView *)mapView didUpdateUserLocation:(QUserLocation *)userLocation fromHeading:(BOOL)fromHeading
{
    NSLog(@"%s fromHeading = %d, location = %@, heading = %@", __FUNCTION__, fromHeading, userLocation.location, userLocation.heading);
     CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation: userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
         if (placemarks.count > 0) {
              CLPlacemark *placemark = [placemarks objectAtIndex:0];
             if (placemark!=nil)
             {
                 self.cityName = placemark.locality;
                 self.sugOption.region =self.cityName;
             }
         }
    }];
}

- (QAnnotationView *)mapView:(QMapView *)mapView viewForAnnotation:(id<QAnnotation>)annotation {
    if ([annotation isKindOfClass:[QPointAnnotation class]]) {
        static NSString *annotationIdentifier = @"pointAnnotation";
        QPinAnnotationView *pinView = (QPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
      
        if (pinView == nil) {
            pinView = [[QPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
//            pinView.image=KImageNamed(@"locate");
            pinView.canShowCallout = YES;
        }
        
        return pinView;
    }
    
    return nil;
}
//-(void)regisNib
//{
//    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CitangCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CitangCell class])];
//}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.tableView)
    {
          return self.dataAry.count;
    }
    else
    {
        return self.dataAry1.count;
    }
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tableView) {
        UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"str"];
        if (!cell) {
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"str"];
        }
        QMSReGeoCodePoi * model=self.dataAry [indexPath.row];
        cell.textLabel.text =model.title;
        cell.textLabel.font =MKFont(14);
        cell.detailTextLabel.font =MKFont(12);
        cell.detailTextLabel.text =model.address;
        return cell;
    }
    else
    {
        UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"str1"];
        if (!cell) {
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"str1"];
        }
        QMSSuggestionPoiData * model=self.dataAry1 [indexPath.row];
        cell.textLabel.text =model.title;
        cell.textLabel.font =MKFont(14);
        cell.detailTextLabel.font =MKFont(12);
        cell.detailTextLabel.text =model.address;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tableView)
    {
        self.selectedRoomBlock(self.dataAry[indexPath.row]);
    }
    else
    {
        self.selectedRoomBlock(self.dataAry1[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

@end
