//
//  JRListViewController.h
//  JRListView
//
//  Created by jackfrow on 2020/2/3.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRListProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface JRListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<JRBaseModel*> *models;

-(void)configureCell:(UITableViewCell<JRListProtocol>*)cell forIndexPath:(NSIndexPath*)indexPath;

-(void)loadCellModelMapping;

-(void)registerModelClass:(Class)modelClass mappedCellClass:(Class)cellClass;


-(JRBaseModel*)modelAtIndexPath:(NSIndexPath*)indexPath;




@end

NS_ASSUME_NONNULL_END
