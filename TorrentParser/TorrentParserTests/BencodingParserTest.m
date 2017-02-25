//
//  BencodingParserTest.m
//  TorrentParser
//
//  Created by Haohua Li on 2017-02-25.
//  Copyright © 2017 Haohua Li. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TRPParser.h"
#import "TRPElement.h"

@interface BencodingParserTest : XCTestCase

@end

@implementation BencodingParserTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSimpleValues {
    NSString *encoded = @"d3:bar4:spam3:fooi42ee";
    TRPElement *element = [TRPParser decodeWithData:encoded];
    NSLog(@"%@", element);
    XCTAssert([element.value isKindOfClass:[NSDictionary class]]);
    
    NSDictionary *dict = (NSDictionary *)element.value;
    XCTAssert([dict[@"bar"] isEqualToString:@"spam"]);
    XCTAssert([dict[@"foo"] isEqualToNumber:@(42)]);
}

- (void)testKnownValues {
    NSDictionary *knownValues = @{
                                  @(0) : @"i0e",
                                  @(1) : @"i1e",
                                  @(10) : @"i10e",
                                  @(42) : @"i42e",
                                  @(-42) : @"i-42e",
                                  @(YES) : @"i1e",
                                  @(NO) : @"i0e",
                                  @"spam" : @"4:spam",
                                  @"parrot sketch" : @"13:parrot sketch",
                                  @{@"foo" : @(42), @"bar" : @"spam"} : @"d3:bar4:spam3:fooi42ee"
                                  };
    
    for (NSObject *plain in knownValues) {
        NSString *encoded = knownValues[plain];
        TRPElement *resultElement = [TRPParser decodeWithData:encoded];
        TRPElement *plainElement = [[TRPElement alloc] initWithValue:plain];
        XCTAssert([resultElement isEqual:plainElement]);
    }
}

- (void)testKnownValuesPerformance {
    NSDictionary *knownValues = @{
                                  @(0) : @"i0e",
                                  @(1) : @"i1e",
                                  @(10) : @"i10e",
                                  @(42) : @"i42e",
                                  @(-42) : @"i-42e",
                                  @(YES) : @"i1e",
                                  @(NO) : @"i0e",
                                  @"spam" : @"4:spam",
                                  @"parrot sketch" : @"13:parrot sketch",
                                  @{@"foo" : @(42), @"bar" : @"spam"} : @"d3:bar4:spam3:fooi42ee"
                                  };
    
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        for (NSObject *plain in knownValues) {
            NSString *encoded = knownValues[plain];
            [TRPParser decodeWithData:encoded];
        }
    }];
}

@end
