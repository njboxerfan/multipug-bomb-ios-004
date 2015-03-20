//
//  pugAPI.m
//  NSOperationQueue
//
//  Created by Joe Burgess on 4/11/14.
//  Copyright (c) 2014 al-tyus.com. All rights reserved.
//

#import "pugAPI.h"

@implementation pugAPI

+(AFHTTPRequestOperation *)getPugWithCompletion:(void (^)(NSDictionary *pugDictionary))completionBlock
{
    NSURL *pugURL = [NSURL URLWithString:@"http://pugme.herokuapp.com/random"];
    
    NSURLRequest *pugRequest = [[NSURLRequest alloc] initWithURL:pugURL];
    
    AFHTTPRequestOperation *pugOperation = [[AFHTTPRequestOperation alloc] initWithRequest:pugRequest];
    
    pugOperation.responseSerializer = [[AFJSONResponseSerializer alloc] init];
    
    [pugOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Fail: %@",error.localizedDescription);
    }];
    
    return pugOperation;
}

@end
