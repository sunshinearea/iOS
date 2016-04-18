//
//  HttpRequestLib.m
//  HttpRequestLib
//
//  Created by rxhui on 15/12/10.
//  Copyright © 2015年 yanli. All rights reserved.
//

#import "HttpRequestLib.h"

@interface HttpRequestLib()
{
    AFHTTPSessionManager * _manager;
    NSString * _alertStr;
}
@end

@implementation HttpRequestLib

-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)initWithUrlString:(NSString *)urlString paramers:(id)aparamers requestMethod:(HttpRequestMethod)method{
//    if (self = [super init]) {
        self.urlString = urlString;
        self.paramers = aparamers;
        self.method = method;
//    }
//    return self;
}

- (void)sendRequestWithSuccess:(void (^)(id successData))successCallBack failure:(void (^)(id failureData))failureCallBack{
    self.successCompletionBlock = successCallBack;
    self.failuerCompletionBlock = failureCallBack;
    
    _manager = [AFHTTPSessionManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _manager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    
    if (self.urlString) {
        if (self.method == HTTRequestGET) {
            [_manager GET:self.urlString parameters:self.paramers success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                //请求成功的回调
//                self.successCompletionBlock(responseObject);
                successCallBack(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                self.failuerCompletionBlock(error.description);
                failureCallBack(error.description);
            }];
        }
        else{
            
            [_manager POST:self.urlString parameters:self.paramers success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        }

    }
}

- (NSString*)monitorNet{
    //1.请求队列管理者 数据请求的工具
    AFHTTPSessionManager * manger = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    _alertStr = [[NSString alloc] init];

    
    //2.发送请求 监测网络
    [manger.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {

        //判断状态
        if (status == AFNetworkReachabilityStatusNotReachable) {
            //NSLog(@"网络未连接");
            _alertStr = @"网络未连接";
        }
        else if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
            //NSLog(@"WIFI");
            _alertStr = @"WIFI";
        }
        else if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
            //NSLog(@"网络已连接");
            _alertStr = @"网络已连接";
        }
        else if (status == AFNetworkReachabilityStatusUnknown) {
            //NSLog(@"未知网络");
            _alertStr = @"未知网络";
        }
    }];
    
    //启动网络监测
    [manger.reachabilityManager startMonitoring];
    
    return _alertStr;
}


- (void)cancelRequest{
    [_manager.operationQueue cancelAllOperations];
    [self clear];
}

- (void)clear{
    self.urlString = nil;
    self.paramers = nil;
    self.delegate = nil;
    _manager = nil;

}

-(void)dealloc{
//    [self clear];
}

- (void)sendSecondRequestWithSuccess:(void (^)(id successData))successCallBack failure:(void (^)(id failureData))failureCallBack{
//    self.successCompletionBlock = successCallBack;
//    self.failuerCompletionBlock = failureCallBack;
    
    _manager = [AFHTTPSessionManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _manager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    
    if (self.urlString) {
        if (self.method == HTTRequestGET) {
            [_manager GET:self.urlString parameters:self.paramers success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                //请求成功的回调
                //                self.successCompletionBlock(responseObject);
                successCallBack(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                //                self.failuerCompletionBlock(error.description);
                failureCallBack(error.description);
            }];
        }
        else{
            
            [_manager POST:self.urlString parameters:self.paramers success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        }
        
    }
}

- (void)reconnectWithUrlString:(NSString*)url requestMethod:(HttpRequestMethod)method{
    [self initWithUrlString:url paramers:nil requestMethod:method];
    [self sendRequestWithSuccess:^(id successData) {
//        self.successCompletionBlock(successData);
    } failure:^(id failureData) {
//        self.failuerCompletionBlock(nil);
    }];


}



@end









