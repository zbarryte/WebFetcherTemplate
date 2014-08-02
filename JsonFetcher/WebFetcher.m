//
//  WebFetcher.m
//  JsonFetcher
//
//  Created by Zachary Barryte on 8/2/14.
//  Copyright (c) 2014 Zachary Barryte. All rights reserved.
//

#import "WebFetcher.h"

@implementation WebFetcher

// We'd like Web Fetcher to be a singleton, meaning we'd only ever like to instantiate it once
// Here we call on a global constant, which will be the same instance wherever it is called
+(id)sharedInstance {
    // Don't worry if the code below looks confusing.
    // This code returns the singleton object for you when you call the sharedInstance method
    // You can treat it as a black-box
    static id _sharedInstance;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

-(void)loadJsonFromUrlWithString:(NSString *)string {
    
    NSURL *url = [NSURL URLWithString:string];
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url ] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSAssert(!connectionError,@"*** Fetch Failed : double-check your url or Internet connection ***");
        
        [self receivedJson:data];
    }];
}

-(void)receivedJson:(NSData *)data {
    
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSAssert(self.delegate,@"*** WebFetcher's JsonReceiverDelegate is null: be sure you assigned it ***");
    
    [self.delegate receiveJson:jsonDictionary];
}


@end
