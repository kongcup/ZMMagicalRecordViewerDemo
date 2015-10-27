//
//  StudentEntity.h
//  ZMMagicalRecordViewerDemo
//
//  Created by zm on 15/10/27.
//  Copyright (c) 2015年 zm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface StudentEntity : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * math;
@property (nonatomic, retain) NSNumber * chinese;
@property (nonatomic, retain) NSString * magor;

@end
