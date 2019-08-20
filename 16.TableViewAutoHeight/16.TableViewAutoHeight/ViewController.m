//
//  ViewController.m
//  16.TableViewAutoHeight
//
//  Created by yy on 2019/8/19.
//  Copyright © 2019 xufanghao. All rights reserved.
//

#import "ViewController.h"
#import "AutoHeightCell.h"
#import "AutoHeightCell2.h"
#import "AutoHeightCell3.h"
//self-size在自动算高时,会循环遍历子视图的所有子视图,拿到最大的高度，用来返回给cell做高度。

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *models;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}


#pragma mark - tableView
static NSString * const cellId = @"cellId";
static NSString * const cellId2 = @"cellId2";
static NSString * const cellId3 = @"cellId3";
- (UIView *)tableView {
    if (!_tableView) {
        _tableView = ({
            UITableView *tableView = [[UITableView alloc] init];
            tableView.frame = self.view.bounds;
            tableView.delegate = self;
            tableView.dataSource = self;
            [tableView registerNib:[UINib nibWithNibName:@"AutoHeightCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
            [tableView registerNib:[UINib nibWithNibName:@"AutoHeightCell2" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId2];
            [tableView registerNib:[UINib nibWithNibName:@"AutoHeightCell3" bundle:[NSBundle mainBundle]] forCellReuseIdentifier: cellId3];
            [self.view addSubview:tableView];
            tableView;
        });
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AutoHeightCell3 *cell = [tableView dequeueReusableCellWithIdentifier:cellId3 forIndexPath:indexPath];
    //    [cell setContentTitle:self.models[indexPath.row]];
    [cell random];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(NSMutableArray *)models{
    if (_models == nil) {
        
        NSString* string = @"赵客缦胡缨②，吴钩霜雪明③。银鞍照白马，飒沓如流星④。十步杀一人， 千里不留行⑤。事了拂衣去，深藏身与名。闲过信陵饮⑥，脱剑膝前横。 将炙啖朱亥，持觞劝侯嬴⑦。三杯吐然诺，五岳倒为轻⑧。眼花耳热后，意气素霓生⑨。救赵挥金锤， 邯郸先震惊⑩。千秋二壮士，烜赫大梁城。纵死侠骨香， 不惭世上英。 谁能书阁下，白首太玄经⑾。";
        
        _models = [NSMutableArray array];
        
        for (int i = 0; i < 20; i++) {
            
            NSInteger index = (arc4random() % string.length - 1);
            NSString* subString = [string substringToIndex: index];
            [_models addObject:subString];
        }
        
    }
    return _models;
}

@end

