//
//  JsonReceiverDelegate.h
//  JsonFetcher
//
//  Created by Zachary Barryte on 8/2/14.
//  Copyright (c) 2014 Zachary Barryte. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JsonReceiverDelegate <NSObject>

-(void)receiveJson:(NSDictionary *)jsonDictionary;

@end
