//
//  ImagesTableViewController.m
//  NSOperationQueue
//
//  Created by Al Tyus on 3/26/14.
//  Copyright (c) 2014 al-tyus.com. All rights reserved.
//

#import "ImagesTableViewController.h"
#import "FISPugCell.h"
#import "FISPugOperation.h"
#import <AFNetworking/AFNetworking.h> 
#import "pugAPI.h"

@interface ImagesTableViewController ()

@end

@implementation ImagesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pugs = [[NSMutableArray alloc] init];
    
    for (NSUInteger i = 1 ; i < 11 ; i++ )
    {
        NSString *imageName = [NSString stringWithFormat:@"pug%ld.jpg",i];
        
        UIImage *pugImage = [UIImage imageNamed:imageName];

        [self.pugs addObject:pugImage];
    }
    
    NSOperationQueue *pugOperationQueue = [[NSOperationQueue alloc] init];
    pugOperationQueue.maxConcurrentOperationCount = 10;
    
    for ( NSUInteger i = 0 ; i < 20 ; i++ )
    {
        FISPugOperation *pugOperation = [[FISPugOperation alloc] init];
        
        pugOperation.pugBlock = ^void(UIImage *pugImage) {
            
            if ( i < 10 )
            {
                [self.pugs replaceObjectAtIndex:i withObject:pugImage];
            }
            else
            {
                [self.pugs addObject:pugImage];
            }
            
            [self.tableView reloadData];
        };

        [pugOperationQueue addOperation:pugOperation];
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
