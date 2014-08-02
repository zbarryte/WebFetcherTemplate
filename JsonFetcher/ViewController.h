//
//  ViewController.h
//  JsonFetcher
//
//  Created by Zachary Barryte on 8/2/14.
//  Copyright (c) 2014 Zachary Barryte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JsonReceiverDelegate.h"

// ViewController is the class
// UIViewController is the super class
// UITableviewDataSource, UITableViewDelegate, UITextFieldDelegate, and JsonReceiverDelegate are protocols to which this class conforms
// ViewController needs to conform to those protocols in order to be various delegates
@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, JsonReceiverDelegate>

@end
