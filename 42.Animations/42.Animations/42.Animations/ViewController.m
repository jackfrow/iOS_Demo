//
//  ViewController.m
//  42.Animations
//
//  Created by jackfrow on 2021/4/22.
//

#import "ViewController.h"

#import "UIVIewAnimationVc.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"iOS动画";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    

}

#pragma mark - UITableViewDataSource


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (nil == cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString* text = [self.dataSource objectAtIndex:indexPath.row];
    if ([text isEqualToString:@"UIView动画"]) {
        
        UIVIewAnimationVc* vc = [[UIVIewAnimationVc alloc] init];
        [self.navigationController pushViewController:vc animated:true];
        NSLog(@"UIView动画");
    }else if ([text isEqualToString:@"帧动画"]){
        NSLog(@"帧动画");
    }else if ([text isEqualToString:@"自定义转场动画"]){
        NSLog(@"自定义转场动画");
    }else if ([text isEqualToString:@"核心动画"]){
        NSLog(@"核心动画");
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
}


#pragma mark - lazy

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.backgroundColor = [UIColor redColor];
    }
    return _tableView;
}


-(NSArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSArray arrayWithObjects:@"UIView动画",@"帧动画",@"自定义转场动画",@"核心动画", nil];
    }
    return _dataSource;
}

@end
