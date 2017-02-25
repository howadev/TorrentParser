//
//  TRPTorrent.m
//  TorrentParser
//
//  Created by Haohua Li on 2017-02-24.
//  Copyright © 2017 Haohua Li. All rights reserved.
//

#import "TRPTorrent.h"
#import "TRPFile.h"
#import "TRPParser.h"
#import "TRPElement.h"

@implementation TRPTorrent

- (instancetype)initWithFileURL:(NSURL *)url {
    if (![url checkResourceIsReachableAndReturnError:nil]) {
        return nil;
    }
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSString *encoded = [TRPTorrent parseData:data];
    
    TRPElement *element = [TRPParser decodeWithData:encoded];

    if (![element.value isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    NSDictionary *dictionary = (NSDictionary *)element.value;
    return [self initWithDictionary:dictionary];
}

+ (NSString *)parseData:(NSData *)data {
    
    const size_t size = data.length;
    const char *pointer = data.bytes;
    const char *end = pointer + size;
    
    NSMutableString *result = [NSMutableString string];
    
    while (pointer < end) {
        [result appendString:[NSString stringWithFormat:@"%c" , *pointer]];
        pointer++;
    }
    
    return result;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self parseDictionary:dictionary];
    }
    return self;
}

- (void)parseDictionary:(NSDictionary *)dictionary {
    NSNumber *creationDate = dictionary[@"creation date"];
    if (creationDate) {
        self.date = [NSDate dateWithTimeIntervalSince1970:[creationDate integerValue]];
    }
    
    NSString *createdBy = dictionary[@"created by"];
    if (createdBy) {
        self.creator = createdBy;
    }
    
    NSString *announce = dictionary[@"announce"];
    if (announce) {
        self.trackerURL = [NSURL URLWithString:announce];
    }
    
    NSDictionary *info = dictionary[@"info"];
    if (info) {
        NSArray *files = info[@"files"];
        if (files) {
            NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:files.count];
        
            for (NSDictionary *fileDict in files) {
                TRPFile *file = [TRPFile new];
                file.length = fileDict[@"length"];
                file.checksum = fileDict[@"md5sum"];
                
                NSArray *path = fileDict[@"path"];
                if (path) {
                    file.name = path.lastObject;
                }
                
                [results addObject:file];
            }
            
            self.files = results;
            
            return;
        }
        
        TRPFile *file = [TRPFile new];
        file.name = info[@"name"];
        file.length = info[@"length"];
        file.checksum = info[@"md5sum"];
        
        self.files = @[file];
    }
}

@end
