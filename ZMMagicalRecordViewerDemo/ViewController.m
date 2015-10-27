//
//  ViewController.m
//  ZMMagicalRecordViewerDemo
//
//  Created by zm on 15/10/27.
//  Copyright (c) 2015年 zm. All rights reserved.
//

#import "ViewController.h"
#import "ZMMagicalRecordViewer.h"

#import "TeacherEntity.h"
#import "StudentEntity.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //[self testData];
    
}

- (void)testData
{
    for (int i = 0; i < 5; ++i) {
        TeacherEntity *t = [TeacherEntity MR_createEntity];
        t.name = [NSString stringWithFormat:@"teacher%d", i];
        t.address = [NSString stringWithFormat:@"address%d", i];
        t.age = [NSString stringWithFormat:@"%d", 20 + i * 2];
        t.magor = [NSString stringWithFormat:@"magor%d", i];
        t.phone = [NSString stringWithFormat:@"135089732%d", 20 + i * 2];
        
        StudentEntity *s = [StudentEntity MR_createEntity];
        s.name = [NSString stringWithFormat:@"student%d", i];
        s.address = [NSString stringWithFormat:@"address%d", i];
        s.age = @(20 + i * 2);
        s.magor = [NSString stringWithFormat:@"magor%d", i];
        s.math = @(70 + i * 3);
        s.chinese = @(70 + i * 4);
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnMagicalRecordViewerToggle:(id)sender {
    ZMMagicalRecordViewer *view = [[ZMMagicalRecordViewer alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}
@end
