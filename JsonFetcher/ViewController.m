//
//  ViewController.m
//  JsonFetcher
//
//  Created by Zachary Barryte on 8/2/14.
//  Copyright (c) 2014 Zachary Barryte. All rights reserved.
//

#import "ViewController.h"
#import "WebFetcher.h"

@interface ViewController ()

@end

// this is the string of the url where the json file we want lives
static NSString *const kUrlString = @"http://www.reddit.com/user/%@/comments.json";

@implementation ViewController {
    
    // These IBOutlets were connected to code from storyboard
    IBOutlet UITableView *_table;
    IBOutlet UITextField *_usernameTextField;
    
    NSArray *_tableData;
}

- (void)viewDidLoad
{
    // super refers to the UIViewController's method's
    [super viewDidLoad];
    
    // We set up table to delegate to the ViewController
    // We need the ViewController to be table's delegate and dataSource in order to populate the table
    _table.delegate = self;
    _table.dataSource = self;
    
    // We set up usernameTextField to delegate to the ViewController
    // This allows the keyboard to close when "done" is pressed
    _usernameTextField.delegate = self;
    
    // We set up the WebFetcher to delegate to the ViewController
    WebFetcher *fetcher = [WebFetcher sharedInstance];
    fetcher.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// This IBAction is connected to a button in storyboard
// We use this method to tell our web fetcher to retreive online data
- (IBAction)fetchData:(id)sender {
    // NSStrings may be concatenated using the + operator
    // Here, however, we formatted the string to include the username (replacing the %@ with the string specified in the text field)
    NSString* completeUrlString = [NSString stringWithFormat:kUrlString,_usernameTextField.text];
    WebFetcher *fetcher = [WebFetcher sharedInstance];
    [fetcher loadJsonFromUrlWithString:completeUrlString];
}

// This method is required by the UITableViewDelegate protocol
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"uid"];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
        cell.textLabel.font = [UIFont systemFontOfSize:10];
    }
    
    if (_tableData.count > 0) {
        cell.textLabel.text = _tableData [indexPath.row];
    }
    
    return cell;
}

// This method is required by the UITableViewDataSource protocol
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _tableData.count;
}

// This method is required by JsonReceiverDelegate
-(void)receiveJson:(NSDictionary *)jsonDictionary {
    
    // This is just parsing of the Json
    // Your parsing will likely, be different, since your file will be structured differently likely
    NSDictionary *dataDictionary = jsonDictionary[@"data"];
    NSArray *childrenArray = dataDictionary[@"children"];
    NSMutableArray *bodyArray = [NSMutableArray array];
    for (NSDictionary *dictionary in childrenArray) {
        NSDictionary *dictionaryInner = dictionary[@"data"];
        NSString *bodyString = dictionaryInner[@"body"];
        [bodyArray addObject:bodyString ];
    }
    
    _tableData = bodyArray;
    
    [_table reloadData];
}

// This method is required by UITextFieldDelegate
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
