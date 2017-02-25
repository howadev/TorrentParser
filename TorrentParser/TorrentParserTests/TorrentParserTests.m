//
//  TorrentParserTests.m
//  TorrentParserTests
//
//  Created by Haohua Li on 2017-02-24.
//  Copyright © 2017 Haohua Li. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TRPParser.h"
#import "TRPElement.h"

@interface TorrentParserTests : XCTestCase

@end

@implementation TorrentParserTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    NSString *data = @"d3:bar4:spam3:fooi42ee";
    TRPElement *element = [TRPParser decodeWithData:data atIndex:0];
    NSLog(@"%@", element);
    XCTAssert([element.value isKindOfClass:[NSDictionary class]]);
    
    NSDictionary *dict = (NSDictionary *)element.value;
    XCTAssert([dict[@"bar"] isEqualToString:@"spam"]);
    XCTAssert([dict[@"foo"] isEqualToNumber:@(42)]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
