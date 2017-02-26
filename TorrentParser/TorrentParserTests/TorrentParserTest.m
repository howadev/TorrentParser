//
//  TorrentParserTest.m
//  TorrentParser
//
//  Created by Haohua Li on 2017-02-25.
//  Copyright © 2017 Haohua Li. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TRPTorrent.h"
#import "TRPFile.h"

@interface TorrentParserTest : XCTestCase

@end

@implementation TorrentParserTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testChecksum {
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource: @"QQ8.7.exe" withExtension:@"torrent"];
    TRPTorrent *torrent = [[TRPTorrent alloc] initWithFileURL:fileURL];
    
    XCTAssert(torrent.files.count == 1);
    
    TRPFile *first = torrent.files.firstObject;
    XCTAssert([first.name isEqualToString:@"QQ8.7.exe"]);
    XCTAssert(first.length.integerValue == 59006272);
    XCTAssert([first.checksum isEqualToString:@"5861fff0e082cabbfff6ae5532765f57"]);
}

- (void)testSingleFile {
    
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource: @"debian-8.7.1-arm64-CD-1.iso" withExtension:@"torrent"];
    TRPTorrent *torrent = [[TRPTorrent alloc] initWithFileURL:fileURL];
    
    XCTAssert([torrent.date isEqualToDate:[NSDate dateWithTimeIntervalSince1970:1484590507]]);
    
    XCTAssert(torrent.creator == nil);
    
    XCTAssert([torrent.trackerURL.absoluteString isEqualToString:@"http://bttracker.debian.org:6969/announce"]);
    
    XCTAssert(torrent.files.count == 1);
    
    TRPFile *first = torrent.files.firstObject;
    XCTAssert([first.name isEqualToString:@"ABCdebian-8.7.1-arm64-CD-1.iso"]);
    XCTAssert(first.length.integerValue == 678428672);
    XCTAssert(first.checksum == nil);
}

- (void)testMultipleFiles {

    NSURL *fileURL = [[NSBundle mainBundle] URLForResource: @"Fedora-KDE-Live-x86_64-25" withExtension:@"torrent"];
    TRPTorrent *torrent = [[TRPTorrent alloc] initWithFileURL:fileURL];
    
    XCTAssert([torrent.date isEqualToDate:[NSDate dateWithTimeIntervalSince1970:1479762880]]);
    
    XCTAssert(torrent.creator == nil);
    
    XCTAssert([torrent.trackerURL.absoluteString isEqualToString:@"http://torrent.fedoraproject.org:6969/announce"]);
    
    XCTAssert(torrent.files.count == 2);
    
    TRPFile *first = torrent.files.firstObject;
    XCTAssert([first.name isEqualToString:@"Fedora-KDE-Live-x86_64-25-1.3.iso"]);
    XCTAssert(first.length.integerValue == 1389363200);
    XCTAssert(first.checksum == nil);
    
    
    TRPFile *second = torrent.files.lastObject;
    XCTAssert([second.name isEqualToString:@"Fedora-Spins-25-1.3-x86_64-CHECKSUM"]);
    XCTAssert(second.length.integerValue == 1526);
    XCTAssert(second.checksum == nil);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource: @"Fedora-KDE-Live-x86_64-25" withExtension:@"torrent"];
        __unused TRPTorrent *torrent = [[TRPTorrent alloc] initWithFileURL:fileURL];
    }];
}

@end
