//
//  ViewController.m
//  FindCar
//
//  Created by YTB on 15/4/13.
//  Copyright (c) 2015年 ZeroYang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CLLocationManager *locManager;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    locManager = [[CLLocationManager alloc]init];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 100)];
    [btn setTitle:@"定位" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(getMyCarLocation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 50, 100)];
    [btn1 setTitle:@"找车" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btn1 addTarget:self action:@selector(getMyCarLocation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    [self.view setBackgroundColor:[UIColor blueColor]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getMyCarLocation
{
    NSLog(@"卧槽");
    
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        return;
    }
    
    //如果没有授权则请求用户授权
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
        [locManager requestWhenInUseAuthorization];
    }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
        //设置代理
        locManager.delegate=self;
        //设置定位精度
        locManager.desiredAccuracy=kCLLocationAccuracyBest;
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance=10.0;//十米定位一次
        locManager.distanceFilter=distance;
        //启动跟踪定位
        [locManager startUpdatingLocation];
    }
    
//    //初始化位置管理器
//    locManager = [[CLLocationManager alloc]init];
//    //设置代理
//    locManager.delegate = self;
//    //设置位置经度
//    locManager.desiredAccuracy = kCLLocationAccuracyBest;
//    //设置每隔100米更新位置
//    locManager.distanceFilter = 50;
//    //开始定位服务
//    [locManager startUpdatingLocation];
    
}

- (void)findMyCar
{
    
}

//协议中的方法，作用是每当位置发生更新时会调用的委托方法
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //停止定位服务
    [locManager stopUpdatingLocation];
    
    //结构体，存储位置坐标
    CLLocationCoordinate2D loc = [newLocation coordinate];
    float longitude = loc.longitude;
    float latitude = loc.latitude;
    //self.lonLabel.text = [NSStringstringWithFormat:@"%f",longitude];
    //self.latLabel.text = [NSStringstringWithFormat:@"%f",latitude];
    
    NSString *location = [NSString stringWithFormat:@"%f,%f",longitude,latitude];

    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Location"
                                                       message:location delegate:self cancelButtonTitle:@"Ok"otherButtonTitles:nil, nil];
    [alertView show];

}

//当位置获取或更新失败会调用的方法
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSString *errorMsg = nil;
    if ([error code] == kCLErrorDenied) {
        errorMsg = @"访问被拒绝";
    }
    if ([error code] == kCLErrorLocationUnknown) {
        errorMsg = @"获取位置信息失败";
    }
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Location"
                                                      message:errorMsg delegate:self cancelButtonTitle:@"Ok"otherButtonTitles:nil, nil];
    [alertView show];
    //[alertView release];
}

@end
