//
//  ZMMagicalRecordViewer.m
//  test
//
//  Created by zm on 15/10/22.
//  Copyright (c) 2015年 zhangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZMMagicalRecordViewer.h"

#define CONST_FIELDS_WIDTH 100
#define CONST_FIELDS_HEIGHT 22.0f

@implementation ZMMagicalRecordViewer
{
    NSArray* entities;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    //获取实体列表
    NSManagedObjectModel *model = [NSManagedObjectModel MR_defaultManagedObjectModel];
    entities = model.entitiesByName.allKeys;
    
    UITableView *mytableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    mytableView.dataSource = self;
    mytableView.delegate = self;
    mytableView.backgroundColor = [UIColor darkGrayColor];
    mytableView.separatorColor = [UIColor darkGrayColor];
    [self.view addSubview:mytableView];
    
    //右滑返回
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    [self.view addGestureRecognizer:rightSwipeGestureRecognizer];
}

-(void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return entities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
        [cell setBackgroundColor:[UIColor grayColor]];
    }
    cell.textLabel.text = [entities objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [NSString  stringWithFormat:@"records:%ld", [NSClassFromString(cell.textLabel.text) MR_countOfEntities]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZMMagicalRecordEntity *view = [[ZMMagicalRecordEntity alloc] init];
    [view setEntityName:entities[indexPath.row]];
    [self.navigationController pushViewController:view animated:YES];
}
@end


@implementation ZMMagicalRecordEntity
{
    NSArray *fields;//实体字段名称
    NSMutableArray *records;//实体记录
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    records = [[NSMutableArray alloc] init];
    
    //获取实体字段名
    NSEntityDescription *des = [NSEntityDescription entityForName:self.entityName inManagedObjectContext:[NSManagedObjectContext MR_defaultContext]];
    fields = [des.propertiesByName allKeys];
    [records setArray:[NSClassFromString(self.entityName) MR_findAll]];
    
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
    CGRect rt = self.view.frame;
    rt.size.width = CONST_FIELDS_WIDTH * fields.count + 8;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:rt collectionViewLayout:flowLayout];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    collectionView.backgroundColor = [UIColor darkGrayColor];

    self.buttomScrollView = [[UIScrollView alloc] init];
    self.buttomScrollView.frame = self.view.frame;
    self.buttomScrollView.contentSize = rt.size;
    self.buttomScrollView.backgroundColor = [UIColor darkGrayColor];
    self.buttomScrollView.bounces = NO;
    
    [self.buttomScrollView addSubview:collectionView];
    [self.view addSubview:self.buttomScrollView];
    //右滑返回
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    [self.view addGestureRecognizer:rightSwipeGestureRecognizer];
}

-(void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return  1;
    }
    else if (section == 1) {
        return fields.count;
    }
    else if (section == 2)
    {
        return records.count * fields.count;
    }
    return 0;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
-(CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    UILabel *lb = (UILabel *)[cell viewWithTag:1];
    if (!lb) {
        lb = [[UILabel alloc] initWithFrame:CGRectMake(0,0, CONST_FIELDS_WIDTH, CONST_FIELDS_HEIGHT)];
        [lb setTag:1];
        [cell.contentView addSubview:lb];
    }

    if(indexPath.section==0)
    {
        lb.text = @" < back ";
        [lb setTextColor:[UIColor whiteColor]];
        cell.backgroundColor = [UIColor darkGrayColor];
    }
    else if(indexPath.section==1)
    {
        lb.text = fields[indexPath.row];
        [lb setTextColor:[UIColor darkTextColor]];
        cell.backgroundColor = [UIColor grayColor];
    }
    else if(indexPath.section==2)
    {
        NSString *fieldName = [fields objectAtIndex:indexPath.row % fields.count ];
        NSManagedObject * p = records[indexPath.row / fields.count];
        [lb setTextColor:[UIColor darkTextColor]];
        lb.text = [NSString stringWithFormat:@"%@", [p valueForKey:fieldName]];
        cell.backgroundColor = [UIColor lightGrayColor];
    }
    
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout   

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CONST_FIELDS_WIDTH, CONST_FIELDS_HEIGHT);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 1, 0);
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 0) {
        //back
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (indexPath.section == 2) {
        UICollectionViewCell *cell =  [collectionView cellForItemAtIndexPath:indexPath];
        UILabel *lb = (UILabel *)[cell viewWithTag:1];
        UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:fields[indexPath.row % fields.count] message:lb.text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [dialog show];
    }
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end







