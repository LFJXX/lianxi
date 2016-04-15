//
//  MapViewController.m
//  OTO
//
//  Created by apple on 16/3/18.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()<BMKRadarManagerDelegate,BMKPoiSearchDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,UITableViewDelegate,UITableViewDataSource>
{
    BMKRadarManager *_radarManager;
    BMKPoiSearch *_searcher;
    BMKLocationService *_locService;
    BMKUserLocation *_location;
    BMKGeoCodeSearch *_geoSearcher;

}
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self creatLocation];
//    [self creatSearcher];
    [self creatGeoSearch];
//    [self creatPoiSearch];
}
- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [BMKRadarManager releaseRadarManagerInstance];
    [_radarManager removeRadarManagerDelegate:self];
    _searcher.delegate = nil;
}



- (void)creatLocation{

    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
}
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    _location = userLocation;

        // 发起反向地理编码检索
    CLLocationCoordinate2D pt = userLocation.location.coordinate;
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
    BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag1 = [_geoSearcher reverseGeoCode:reverseGeoCodeSearchOption];
 
    if(flag1)
    {
      NSLog(@"反geo检索发送成功");
    }
    else
    {
      NSLog(@"反geo检索发送失败");
    }
    
}
//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
  if (error == BMK_SEARCH_NO_ERROR) {
 
  }
  else {
      NSLog(@"抱歉，未找到结果");
  }
    [_locService stopUserLocationService];
}
// 地理编码
- (void)creatGeoSearch{
    _geoSearcher =[[BMKGeoCodeSearch alloc]init];
    _geoSearcher.delegate = self;
    
}
// poi检索 必须有一个 keyword
- (void)creatSearcher{
    _searcher =[[BMKPoiSearch alloc]init];
    _searcher.delegate = self;
    //发起检索
//    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
//    option.pageIndex = 0;
//    option.pageCapacity = 10;
//    option.location = CLLocationCoordinate2DMake(39.916, 116.404);
//    option.keyword = @"建筑物";
//    BOOL flag = [_searcher poiSearchNearBy:option];
//    if(flag)
//    {
//        NSLog(@"周边检索发送成功");
//    }
//    else
//    {
//        NSLog(@"周边检索发送失败");
//    }
}

- (void)creatPoiSearch{

    _searcher = [[BMKPoiSearch alloc] init];
    _searcher.delegate = self;
    //POI详情检索
    BMKPoiDetailSearchOption* option = [[BMKPoiDetailSearchOption alloc] init];
    option.poiUid = @"05dd7d5f2d8a4a18ad080f78";//POI搜索结果中获取的uid
    BOOL flag = [_searcher poiDetailSearch:option];

    if(flag)
    {
        //详情检索发起成功
        NSLog(@"周边检索发送成功");
    }
    else
    {
        //详情检索发送失败
         NSLog(@"周边检索发送失败");
    }
}
-(void)onGetPoiDetailResult:(BMKPoiSearch *)searcher result:(BMKPoiDetailResult *)poiDetailResult errorCode:(BMKSearchErrorCode)errorCode
{
    if(errorCode == BMK_SEARCH_NO_ERROR){
        //在此处理正常结果
    }
}
//实现PoiSearchDeleage处理回调结果
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
    }
    [_locService stopUserLocationService];
}

- (void)creatRedarManger{
    _radarManager = [BMKRadarManager getRadarManagerInstance];
    
    [_radarManager addRadarManagerDelegate:self];//添加radar delegate
    _radarManager.userId = @"我最大";

}


// 发送位置
- (void)sendMyLocation{
    BMKRadarUploadInfo *myinfo = [[BMKRadarUploadInfo alloc] init];
    myinfo.extInfo = @"元嘉";//扩展信息
    myinfo.pt = CLLocationCoordinate2DMake(39.916, 116.404);//我的地理坐标
    //上传我的位置信息
    BOOL res = [_radarManager uploadInfoRequest:myinfo];
    if (res) {
        NSLog(@"upload 成功");
    } else {
        NSLog(@"upload 失败");
    }
    
    //启动自动上传用户位置信息,需要实现getRadarAutoUploadInfo获取我的位置信息
    [_radarManager startAutoUpload:5];
}


// 搜索附近的信息
- (void)searchOption{
    BMKRadarNearbySearchOption *option = [[BMKRadarNearbySearchOption alloc] init]
    ;
    option.radius = 8000;//检索半径
    option.sortType = BMK_RADAR_SORT_TYPE_DISTANCE_FROM_NEAR_TO_FAR;//排序方式
    option.centerPt = CLLocationCoordinate2DMake(39.916, 116.404);//检索中心点
    //发起检索
    BOOL res = [_radarManager getRadarNearbySearchRequest:option];
    if (res) {
        NSLog(@"get 成功");
    } else {
        NSLog(@"get 失败");
    }
}

- (void)onGetRadarNearbySearchResult:(BMKRadarNearbyResult *)result error:(BMKRadarErrorCode)error {
    NSLog(@"onGetRadarNearbySearchResult  %d", error);
    if (error == BMK_RADAR_NO_ERROR) {
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hello"];
    
   
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark  懒加载
- (UITableView *)tableView{

    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
