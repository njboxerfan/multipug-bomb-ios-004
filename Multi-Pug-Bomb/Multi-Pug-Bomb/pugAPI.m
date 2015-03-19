//
//  pugAPI.m
//  NSOperationQueue
//
//  Created by Joe Burgess on 4/11/14.
//  Copyright (c) 2014 al-tyus.com. All rights reserved.
//

#import "pugAPI.h"
#import <AFNetworking.h>

@implementation pugAPI

+(void)getPugWithCompletion:(void (^)(NSDictionary *pugDictionary))completionBlock
{
    NSString *pugURL = @"http://pugme.herokuapp.com/random";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:pugURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         //NSLog(@"%@", responseObject);
         
         completionBlock(responseObject);
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"Fail: %@",error.localizedDescription);
     }];
    
}

@end
