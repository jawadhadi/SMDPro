//
//  TodayTableViewController.m
//  iOSHacker
//
//  Created by Hadi on 07/06/2015.
//
//

#import "TodayTableViewController.h"
#define blogURL @"http://ioshacker.com/?json=1"

@interface TodayTableViewController ()

@end

@implementation TodayTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self fetchPosts];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
        NSLog(@"YES");
        
        //        cell.textLabel.numberOfLines = 0;
        //        cell.textLabel.font = [UIFont systemFontOfSize:8.0];
        //        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    
    //displays titles in UITableView cells
    
    NSString *title = [[self.posts objectAtIndex:indexPath.row]valueForKey:@"title_plain"];
    
    //NSLog(@"%@", title);
    
    NSString *tempTitle = [title stringByReplacingOccurrencesOfString:@"&#8217;" withString:@"'"];
    
    NSString *tempTitle2 = [tempTitle stringByReplacingOccurrencesOfString:@"&#8216;" withString:@"'"];
    
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.textColor = [UIColor whiteColor];
    
    cell.textLabel.text = tempTitle2;
    
    self.preferredContentSize = self.tableView.contentSize;
    
    NSLog(@"%@", cell.textLabel.text);
    
    //code to convert image urls to viewable images.
    
    UIImage *img;
    
    @try {
        NSURL* myURL = [NSURL URLWithString: self.attachments[indexPath.row][0][@"url"]];
        
        img = [UIImage imageWithData:[NSData dataWithContentsOfURL:myURL]];
        
    }
    @catch (NSException *exception) {
        img = [UIImage imageNamed:@"alpha.png"];
    }
    @finally {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(50,50), YES, 0);
        [img drawInRect:CGRectMake(0,0,50,50)];
        img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        cell.imageView.image = img;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return cell;
}

-(void)fetchPosts{
    
    //code to fetch JSON data and parse it to foundation objects
    
    NSURL *bURL = [NSURL URLWithString:blogURL];
    
    NSData *jsonData;

    
    //fetching JSON data and storing it in NSDictionary
    NSDictionary *dataDictionary;
    
    
    @try
    {
        jsonData = [NSData dataWithContentsOfURL:bURL];
        
        NSError *error = nil;
        
        
        //fetching JSON data and storing it in NSDictionary
        dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        
        //storing all the post objects in posts array
        self.posts = [dataDictionary objectForKey:@"posts"];
        
        self.attachments = [[NSMutableArray alloc] init];
        
        
        //storing all the attachments in attachments array
        for (int i = 0; i< 2; i++) {
            [self.attachments addObject:[[self.posts objectAtIndex:i]valueForKey:@"attachments"]];
        }
        
    }
    @catch (NSException *exception)
    {
        NSLog(@"Connection Error!");
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSURL* url = [NSURL URLWithString:@"ioshacker://recent"];
    [self.extensionContext openURL:url completionHandler:nil];
    
}

@end
