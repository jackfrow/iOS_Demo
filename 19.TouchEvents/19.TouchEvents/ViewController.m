//
//  ViewController.m
//  19.TouchEvents
//
//  Created by yy on 2019/8/29.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

#import "ViewController.h"
#import "GSTViewController.h"
#import "ControlViewController.h"

NSString* const gestureID = @"手势";
NSString* const control = @"控件";

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    NSString* title = [self.dataSource objectAtIndex:indexPath.row];
    
    UIViewController* vc = nil;
    
    if ([title isEqualToString:gestureID]) {
      vc = [[GSTViewController alloc] init];
    }else if ([title isEqualToString:control]){
      vc = [[ControlViewController alloc] init];
    }
    if (vc) {
       [self.navigationController pushViewController:vc animated:true];
    }
    
    
}

-(NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
        [_dataSource addObjectsFromArray:@[gestureID,control]];
    }
    return _dataSource;
}

@end
