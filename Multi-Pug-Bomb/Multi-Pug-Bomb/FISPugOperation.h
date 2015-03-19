//
//  FISPugOperation.h
//  Multi-Pug-Bomb
//
//  Created by Bert Carr on 3/19/15.
//  Copyright (c) 2015 Joe Burgess. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FISPugOperation : NSOperation

@property (nonatomic, strong) void(^pugBlock)(UIImage *pugImage);

@end
