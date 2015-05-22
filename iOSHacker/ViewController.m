//
//  ViewController.m
//  iOSHacker
//
//  Created by Hadi on 21/05/2015.
//
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *posts;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"hello, world");
    
    // Do any additional setup after loading the view, typically from a nib.
    
    //code to fetch JSON data and parse it to foundation objects
    
    NSURL *blogURL = [NSURL URLWithString:@"http://ioshacker.com/?json=1"];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:blogURL];
    
    NSError *error = nil;
    
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    NSLog(@"1");
    
    self.posts = [dataDictionary objectForKey:@"posts"];
    
    //NSLog(@"%@", dataDictionary);
    
    
    //NSLog(@"%@", posts);
    
    //NSArray* post1 = [posts objectForKey:@"title"];
    
    NSString *title = [[self.posts objectAtIndex:0]valueForKey:@"title_plain"];
    NSString *date = [[self.posts objectAtIndex:0]valueForKey:@"date"];
    
    NSString *content = [[self.posts objectAtIndex:0]valueForKey:@"content"];
    
    
    NSLog(@"%@", title);
    NSLog(@"%@", date);
    NSLog(@"%@", content);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
