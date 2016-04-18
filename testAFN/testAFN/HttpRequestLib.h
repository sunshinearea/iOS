//
//  HttpRequestLib.h
//  HttpRequestLib
//
//  Created by rxhui on 15/12/10.
//  Copyright © 2015年 yanli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"


typedef NS_ENUM(NSInteger,HttpRequestMethod){
    HTTRequestGET = 1,
    HTTRequestPOST = 2
};



typedef void(^SuccessCompletion)(id data);
typedef void(^FailureCompletion)(id data);

@interface HttpRequestLib : NSObject
//json xml plist
//缓存
@property (nonatomic,copy) NSString * urlString;
@property (nonatomic,retain) id paramers;
@property (nonatomic,assign) HttpRequestMethod method;
@property (nonatomic,weak) id delegate;

@property (nonatomic,assign) SuccessCompletion successCompletionBlock;
@property (nonatomic,assign) FailureCompletion failuerCompletionBlock;


- (void)initWithUrlString:(NSString *)urlString paramers:(id)aparamers requestMethod:(HttpRequestMethod)method;

- (void)sendRequestWithSuccess:(void (^)(id successData))successCallBack failure:(void (^)(id failureData))failureCallBack;

- (void)sendSecondRequestWithSuccess:(void (^)(id successData))successCallBack failure:(void (^)(id failureData))failureCallBack;

- (void)cancelRequest;

- (void)reconnectWithUrlString:(NSString*)url requestMethod:(HttpRequestMethod)method;

@end









