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
@property (nonatomic, strong) NSMutableArray *attachments;
@property (nonatomic, strong) NSMutableArray *urls;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //NSLog(@"hello, world");
    
    // Do any additional setup after loading the view, typically from a nib.
    
    //iAd
    
    
    bannerView = [[ADBannerView alloc]initWithFrame:
                  CGRectMake([[UIScreen mainScreen] bounds].size.width-375, [[UIScreen mainScreen] bounds].size.height-50, 320, 50)];
    // Optional to set background color to clear color
    [bannerView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview: bannerView];

    //NSURL *blogURL = [NSURL URLWithString:@"http://ioshacker.com/?json=1"];
    
    [self fetchPosts];
    
//    NSString *title = [[self.posts objectAtIndex:0]valueForKey:@"title_plain"];
//    NSString *date = [[self.posts objectAtIndex:0]valueForKey:@"date"];
//    
//    NSString *content = [[self.posts objectAtIndex:0]valueForKey:@"excerpt"];
//    
//    
//    NSLog(@"%@", title);
//    NSLog(@"%@", date);
//    NSLog(@"%@", content);
}

-(void)fetchPosts{
    
    //code to fetch JSON data and parse it to foundation objects
    
    
    NSURL *blogURL = [NSURL URLWithString:@"http://ioshacker.com/?json=1"];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:blogURL];
    
    NSError *error = nil;
    
    
    //fetching JSON data and storing it in NSDictionary
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    //NSLog(@"1");
    
    
    //storing all the post objects in posts array
    self.posts = [dataDictionary objectForKey:@"posts"];
    
    self.attachments = [[NSMutableArray alloc] init];
    
    
    //storing all the attachments in attachments array
    for (int i = 0; i< self.posts.count; i++) {
        [self.attachments addObject:[[self.posts objectAtIndex:i]valueForKey:@"attachments"]];
    }
    
    
    //logging all the image URLS for testing
    for (int i = 0; i< self.attachments.count; i++) {
        
        NSLog(@"URL: %@", [[self.attachments objectAtIndex:i]valueForKey:@"url"]);
    }
    
    
    //here's the problem, we need to kick out all the clutter from content.
    NSString *content = [[self.posts objectAtIndex:0]valueForKey:@"content"];
    
    NSLog(@"%@", content);
}



-(void)refreshView:(UIRefreshControl *)refresh {
    
        refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing data..."];
    
        // custom refresh logic would be placed here...
        [self fetchPosts];
    
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *lastUpdated = [NSString stringWithFormat:@"Last updated on %@",[formatter stringFromDate:[NSDate date]]];
        refresh.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
        [refresh endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.posts.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"post";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont systemFontOfSize:16.0];
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    
    //displays titles in UITableView cells
    
    NSString *title = [[self.posts objectAtIndex:indexPath.row]valueForKey:@"title_plain"];
    
    NSString *tempTitle = [title stringByReplacingOccurrencesOfString:@"&#8217;" withString:@"'"];
    
    NSString *tempTitle2 = [tempTitle stringByReplacingOccurrencesOfString:@"&#8216;" withString:@"'"];
    
    cell.textLabel.text = tempTitle2;
    

    //NSString* url = [[self.attachments objectAtIndex:0] valueForKey:@"url"];
    
    //code to convert image urls to viewable images.
    
    NSURL* myURL = [NSURL URLWithString: self.attachments[indexPath.row][0][@"url"]];
    
    //NSLog(@"myURL: %@", myURL);
    
    //NSData * imageData = [[NSData alloc] initWithContentsOfURL: myURL];
    
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:myURL]];
    
    //UIImage *thumb = [img makeThumbnailOfSize:CGSizeMake(32,32)];
    
    cell.imageView.image = img;
    
    //cell.imageView.frame = CGRectMake(0,0,16,16);
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
    
}


@end
