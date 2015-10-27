//
//  TeacherEntity.h
//  ZMMagicalRecordViewerDemo
//
//  Created by zm on 15/10/27.
//  Copyright (c) 2015年 zm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TeacherEntity : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * age;
@property (nonatomic, retain) NSString * magor;

@end
