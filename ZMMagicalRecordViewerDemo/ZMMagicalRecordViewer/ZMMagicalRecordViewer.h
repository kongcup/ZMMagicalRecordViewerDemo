//
//  ZMMagicalRecordViewer.h
//  test
//
//  Created by zm on 15/10/22.
//  Copyright (c) 2015年 zhangmin. All rights reserved.
//

#ifndef test_ZMMagicalRecordViewer_h
#define test_ZMMagicalRecordViewer_h

@interface ZMMagicalRecordViewer : UIViewController<UITableViewDelegate, UITableViewDataSource>

@end


@interface ZMMagicalRecordEntity : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSString *entityName;
@property (nonatomic,strong) UIScrollView *buttomScrollView;
@end


#endif
