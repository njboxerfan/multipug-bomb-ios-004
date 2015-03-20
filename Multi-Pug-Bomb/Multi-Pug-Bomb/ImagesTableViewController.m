//
//  ImagesTableViewController.m
//  NSOperationQueue
//
//  Created by Al Tyus on 3/26/14.
//  Copyright (c) 2014 al-tyus.com. All rights reserved.
//

#import "ImagesTableViewController.h"
#import "FISPugCell.h"
#import "pugAPI.h"
#import <AFNetworking/AFNetworking.h>

@interface ImagesTableViewController ()

@end

@implementation ImagesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pugs = [[NSMutableArray alloc] init];
    
    NSOperationQueue *pugOperationQueue = [[NSOperationQueue alloc] init];
    pugOperationQueue.maxConcurrentOperationCount = 1;

    for ( NSUInteger i = 0 ; i < 20 ; i++ )
    {
        [self.pugs addObject:[UIImage imageNamed:@"pug1.jpg"]];

        AFHTTPRequestOperation *pugRequestOperation = [pugAPI getPugWithCompletion:^(NSDictionary *pugDictionary) {
    
            NSURL *pugImageURL = [NSURL URLWithString:pugDictionary[@"pug"]];
    
            UIImage *pugImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:pugImageURL]];
    
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                
                [self.pugs replaceObjectAtIndex:i withObject:pugImage];
                
                [self.tableView reloadData];
            }];
        }];
    
        [pugOperationQueue addOperation:pugRequestOperation];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.pugs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FISPugCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pugCell" forIndexPath:indexPath];
    
    cell.pugImageView.image = self.pugs[indexPath.row];
    
    return cell;
}

@end
