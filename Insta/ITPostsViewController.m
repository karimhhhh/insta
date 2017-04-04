//
//  ITPostsViewController.m
//  Insta
//
//  Copyright © 2017 Karim. All rights reserved.
//

#import "ITPostsViewController.h"
#import <InstagramKit.h>
#import "ITPostCell.h"

@implementation ITPostsViewController {
    NSArray *posts;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Posts";
    
    posts = [NSArray array];
    [[InstagramEngine sharedEngine] getSelfRecentMediaWithSuccess:^(NSArray<InstagramMedia *> *media, InstagramPaginationInfo *paginationInfo){
        posts = media;
        [self.tableView reloadData];
    } failure:^(NSError* error, NSInteger serverStatusCode){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:error.localizedDescription message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:true completion:nil];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ITPostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    cell.media = posts[indexPath.item];
    //cell.postImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[posts[indexPath.item] thumbnailURL]]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return posts.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size.width;
}

@end
