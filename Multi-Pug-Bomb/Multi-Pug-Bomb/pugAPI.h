//
//  pugAPI.h
//  NSOperationQueue
//
//  Created by Joe Burgess on 4/11/14.
//  Copyright (c) 2014 al-tyus.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface pugAPI : NSObject

+(AFHTTPRequestOperation *)getPugWithCompletion:(void (^)(NSDictionary *pugDictionary))completionBlock;

@end
