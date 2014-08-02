//
//  WebFetcher.h
//  JsonFetcher
//
//  Created by Zachary Barryte on 8/2/14.
//  Copyright (c) 2014 Zachary Barryte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsonReceiverDelegate.h"

@interface WebFetcher : NSObject

// This delegate will receive the json
@property (nonatomic,weak) id<JsonReceiverDelegate> delegate;

+(id)sharedInstance;

-(void)loadJsonFromUrlWithString:(NSString *)string;

@end
