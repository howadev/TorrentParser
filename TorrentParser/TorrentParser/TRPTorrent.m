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
    
    self = [super init];
    if (self) {
        if (![url checkResourceIsReachableAndReturnError:nil]) {
            return nil;
        }
        
        self.fileName = url.lastPathComponent;
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSString *encoded = [TRPTorrent parseData:data];
        
        TRPElement *element = [TRPParser decodeWithData:encoded];
        
        if (![element.value isKindOfClass:[NSDictionary class]]) {
            return nil;
        }
        
        NSDictionary *dictionary = (NSDictionary *)element.value;
        [self parseDictionary:dictionary];
    }
    
    return self;
}

+ (NSString *)parseData:(NSData *)data {
    
    const size_t size = data.length;
    const char *pointer = data.bytes;
    const char *end = pointer + size;
    
    NSMutableString *result = [NSMutableString string];
    
    NSUInteger matchCount = 0;
    NSString *pattern = @"6:pieces";
    
    while (pointer < end) {
        NSString *charString = [NSString stringWithFormat:@"%c" , *pointer];
        [result appendString:charString];
        pointer++;
        
        if (matchCount < pattern.length) {
            if ([[pattern substringWithRange:NSMakeRange(matchCount, 1)] isEqualToString:charString]) {
                matchCount++;
                
                if (matchCount == pattern.length) {
                    result = [[result substringToIndex:result.length - pattern.length] mutableCopy];
                    NSUInteger piecesLength = 0;
                    while (pointer < end) {
                        NSString *piecesChar = [NSString stringWithFormat:@"%c" , *pointer];
                        if ([piecesChar isEqualToString:@":"]) {
                            pointer = pointer + (piecesLength + 1);
                            break;
                        } else {
                            piecesLength = piecesLength * 10 + piecesChar.integerValue;
                            pointer++;
                        }
                    }
                }
            } else {
                matchCount = 0;
            }
        }
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
    
    NSString *comment = dictionary[@"comment"];
    if (comment) {
        self.comment = comment;
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

- (NSString *)description {
    NSMutableString *result = [NSMutableString string];
    
    if (self.date) {
        [result appendString:[NSString stringWithFormat:@"Creation Date: %@\n\n", self.date]];
    }
    
    if (self.creator) {
        [result appendString:[NSString stringWithFormat:@"Created by: %@\n\n", self.creator]];
    }
    
    if (self.trackerURL) {
        [result appendString:[NSString stringWithFormat:@"Tracker URL: %@\n\n", self.trackerURL]];
    }
    
    if (self.files) {
        NSString *title = @"[File]\n\n";
        if (self.files.count > 1) {
            title = @"[Files]\n\n";
        }

        [result appendString:title];
    }
    for (TRPFile *file in self.files) {
        if (file.name) {
            [result appendString:[NSString stringWithFormat:@"Name: %@\n", file.name]];
        }
        if (file.length) {
            [result appendString:[NSString stringWithFormat:@"Length: %@\n", file.length]];
        }
        if (file.checksum) {
            [result appendString:[NSString stringWithFormat:@"Checksum: %@\n", file.checksum]];
        }
        if (file.name || file.length || file.checksum) {
            [result appendString:@"\n"];
        }
    }
    
    return result;
}

@end
