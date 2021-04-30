//
//  JRListViewController.m
//  JRListView
//
//  Created by jackfrow on 2020/2/3.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import "JRListViewController.h"
#import "JRListProtocol.h"
#import "JRUIProtocol.h"


typedef Class<JRUIProtocol> _Nullable (^MapBlock)(JRBaseModel* model);

@interface JRListViewController ()

@property (nonatomic, strong) NSMutableDictionary *modelCellBlockMap;

@end

@implementation JRListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadCellModelMapping];
    
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.models.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JRBaseModel* model = [self modelAtIndexPath:indexPath];
    Class cellClass = [self mappedCellClassForModel:model];
    NSString* reuseIdentifier = [self reuseIdentifierWithCellClass:cellClass];
    
    UITableViewCell<JRListProtocol>* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    cell.model = model;
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JRBaseModel* model = [self modelAtIndexPath:indexPath];
    Class cellClass = [self mappedCellClassForModel:model];
    return  [cellClass cellHeightWithModel:model contentWidth:tableView.bounds.size.width];
     
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JRBaseModel* model = [self modelAtIndexPath:indexPath];
    Class cellClass = [self mappedCellClassForModel:model];
    return  [cellClass cellHeightWithModel:model contentWidth:tableView.bounds.size.width];
    
}


#pragma mark - API
-(JRBaseModel*)modelAtIndexPath:(NSIndexPath*)indexPath{
    
    JRBaseModel* model = indexPath.row < self.models.count ? self.models[indexPath.row] : nil;
    return model;
    
}

-(Class<JRUIProtocol>)mappedCellClassForModel:(JRBaseModel*)model{
     
    MapBlock block = self.modelCellBlockMap[NSStringFromClass(model.class)];
    return block ? block(model) : nil;
    
}

-(NSString*)reuseIdentifierWithCellClass:(Class)cellClass{
    return cellClass ? NSStringFromClass(cellClass) : nil;
}


-(void)configureCell:(UITableViewCell<JRListProtocol>*)cell forIndexPath:(NSIndexPath*)indexPath{
    //子类实现
}

-(void)loadCellModelMapping{
    //子类实现
}

-(void)registerModelClass:(Class)modelClass mappedCellClass:(Class)cellClass{
    
    NSString* desc = [NSString stringWithFormat:@"Failed to register model and cell classes.%@ doesn't confirm JRListProtocol",cellClass];
    NSAssert([cellClass conformsToProtocol:@protocol(JRListProtocol)], desc);
    [self registerModelClass:modelClass mappedCellBlock:^Class(id model) {
        return cellClass;
    }];
}


-(void)registerModelClass:(Class)modelClass mappedCellBlock:(Class (^)(id model))cellBlock{
    
    NSString* desc = [NSString stringWithFormat:@"Failed to register model and cell classes.%@ doesn't sub of JRBaseModel",modelClass];
    NSAssert([modelClass isSubclassOfClass:JRBaseModel.class], desc);
    
    NSString* classString = NSStringFromClass(modelClass);
    self.modelCellBlockMap[classString] = cellBlock;
    
}


#pragma mark - lazy

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

-(NSMutableArray<JRBaseModel *> *)models{
    if (_models == nil) {
        _models = [[NSMutableArray alloc] init];
    }
    return _models;
}


-(NSMutableDictionary *)modelCellBlockMap{
    
    if (_modelCellBlockMap == nil) {
        _modelCellBlockMap = [[NSMutableDictionary alloc] init];
    }
    return _modelCellBlockMap;
}


@end
