//
//  UIVIewAnimationVc.m
//  42.Animations
//
//  Created by jackfrow on 2021/4/22.
//

#import "UIVIewAnimationVc.h"

@interface UIVIewAnimationVc ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation UIVIewAnimationVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
   
}



#pragma mark - UITableViewDataSource


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *dic = _dataSource[section];
    NSArray *array = dic[@"value"];
    return array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (nil == cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.textLabel.text = _dataSource[indexPath.section][@"value"][indexPath.row];
    return cell;
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary *dic = _dataSource[section];
    return dic[@"title"];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString* text = _dataSource[indexPath.section][@"value"][indexPath.row];
    
    NSLog(@"text == %@",text);
//    if ([text isEqualToString:@"UIView动画"]) {
//        NSLog(@"UIView动画");
//    }else if ([text isEqualToString:@"帧动画"]){
//        NSLog(@"帧动画");
//    }else if ([text isEqualToString:@"自定义转场动画"]){
//        NSLog(@"自定义转场动画");
//    }else if ([text isEqualToString:@"核心动画"]){
//        NSLog(@"核心动画");
//    }
//
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
}


#pragma mark - lazy

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


-(NSArray *)dataSource{
    if (_dataSource == nil) {
        
        NSArray *array_1 = [NSArray arrayWithObjects:@"属性变化",@"转场动画", nil];
        NSMutableDictionary *dic_1 = [NSMutableDictionary dictionaryWithObject:array_1 forKey:@"value"];
        [dic_1 setValue:@"无block实现" forKey:@"title"];
        
        NSArray *array_2 = [NSArray arrayWithObjects:@"属性变化-1",@"Spring动画-1",@"Keyframes动画-1",@"转场动画-1", nil];
        NSMutableDictionary *dic_2 = [NSMutableDictionary dictionaryWithObject:array_2 forKey:@"value"];
        [dic_2 setValue:@"带block实现" forKey:@"title"];
        
    
        _dataSource = [NSArray arrayWithObjects:dic_1,dic_2, nil];
    }
    return _dataSource;
}

@end
