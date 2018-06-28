//
//  CDLabelTests.m
//  CDLabelTests
//
//  Created by chdo002 on 12/01/2017.
//  Copyright (c) 2017 chdo002. All rights reserved.
//

@import XCTest;


NSMutableString * generageStr(NSUInteger size){
    NSMutableString *str = [NSMutableString stringWithCapacity:size];
    while (str.length < size) {
        [str appendFormat:@"%d",arc4random() % 10];
    }
    return str;
}


void testString(){
    for (int i = 100000 ; i< 60000000; i += 100) {
        
        NSMutableString *str = generageStr(i);
        
        NSMutableString *str2 = [str mutableCopy];
        //        [str2 replaceCharactersInRange:NSMakeRange(str.length - 2, 1) withString:@"f"];
        
        NSTimeInterval stat = [[NSDate date] timeIntervalSince1970];
        
        BOOL res = [str isEqualToString:str2];
        
        NSTimeInterval stat2 = [[NSDate date] timeIntervalSince1970];
        
        NSLog(@"time:%f,res:%d,len1:%lu,len2:%lu",stat2 - stat, res,(unsigned long)str.length, (unsigned long)str2.length);
    }
}



NSString *colorr(CGColorRef color){
    
    NSUInteger num = CGColorGetNumberOfComponents(color);
    const CGFloat *colorComponents = CGColorGetComponents(color);
    
    NSMutableString *str = [NSMutableString string];
    for (int i = 0; i < num; ++i) {
        [str appendFormat:@"%.3f",colorComponents[i]];
    }
    return [str copy];
}


@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
//    testString();
    
    [self colorTest];
}

-(void)colorTest{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 10000; i++) {
        UIColor *color = [UIColor colorWithRed: 0.001 * (arc4random() % 100) green:0.001 * (arc4random() % 100) blue:0.001 * (arc4random() % 100) alpha:0.001 * (arc4random() % 100)];
        NSTimeInterval t1 = [[NSDate date] timeIntervalSince1970];
        colorr(color.CGColor);
        NSTimeInterval t2 = [[NSDate date] timeIntervalSince1970];
        NSNumber *num = [NSNumber numberWithFloat:t2 - t1];
        [arr addObject:num];
    }
    
    for (NSNumber *n in arr) {
        NSLog(@"%f ",n.floatValue);
    }
}

@end

