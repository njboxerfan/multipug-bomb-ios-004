//
//  FISPugOperation.m
//  Multi-Pug-Bomb
//
//  Created by Bert Carr on 3/19/15.
//  Copyright (c) 2015 Joe Burgess. All rights reserved.
//

#import "FISPugOperation.h"
#import "pugAPI.h"

@implementation FISPugOperation

-(void)main
{
    [pugAPI getPugWithCompletion:^(NSDictionary *pugDictionary) {
        
        NSURL *pugImageURL = [NSURL URLWithString:pugDictionary[@"pug"]];
        
        UIImage *pugImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:pugImageURL]];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.pugBlock(pugImage);
        }];
    }];
}

@end
