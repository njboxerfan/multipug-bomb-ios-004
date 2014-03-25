//
//  FISImagesTableViewController.m
//  NSOperationQueue
//
//  Created by Joe Burgess on 3/24/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISImagesTableViewController.h"
#import "FISPugCell.h"
#import <AFNetworking.h>

@interface FISImagesTableViewController ()
@property (strong, atomic) NSMutableDictionary *images;
@property (strong, nonatomic) NSMutableDictionary *imageOperations;
@property (strong, nonatomic) NSOperationQueue *queue;

- (void)configureCell:(FISPugCell *)cell forIndexPath:(NSIndexPath *)indexPath;
@end

@implementation FISImagesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.queue = [[NSOperationQueue alloc] init];
    self.images = [[NSMutableDictionary alloc] init];

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
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FISPugCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pugCell" forIndexPath:indexPath];

    NSString *randomPugURL = @"http://pugme.herokuapp.com/random";

    if ([self.images objectForKey:indexPath]==nil) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:randomPugURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSDictionary *responseDictionary = (NSDictionary *)responseObject;
            NSLog(@"Request!");

            NSOperation *imageOp = [NSBlockOperation blockOperationWithBlock:^{
                NSData *pugData = [NSData dataWithContentsOfURL:[NSURL URLWithString:responseDictionary[@"pug"]]];
                NSLog(@"%@",responseDictionary[@"pug"]);
                UIImage *pugImage = [UIImage imageWithData:pugData];
                if (pugImage==nil) {
                    self.images[indexPath]= [UIImage imageNamed:@"placeholder"];
                } else
                {
                    self.images[indexPath]=pugImage;
                }
                [self configureCell:cell forIndexPath:indexPath];
            }];
            self.imageOperations[indexPath] = imageOp;
            [self.queue addOperation:imageOp];
        } failure:nil];
    } else {
        [self configureCell:cell forIndexPath:indexPath];
    }
    return cell;
}

- (void)configureCell:(FISPugCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{

            FISPugCell *pugCell = (FISPugCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            pugCell.pugImageView.image= self.images[indexPath];

        }];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    FISPugCell *pugCell = (FISPugCell *)cell;
    if (![self.images objectForKey:indexPath]) {
        NSOperation *imageOp = self.imageOperations[indexPath];
        [imageOp cancel];
        [self.queue cancelAllOperations];
    }
    pugCell.pugImageView.image = [UIImage imageNamed:@"placeholder"];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
