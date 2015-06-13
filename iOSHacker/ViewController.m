//
//  ViewController.m
//  iOSHacker
//
//  Created by Hadi on 21/05/2015.
//
//

#import "ViewController.h"

#define blogURL @"http://ioshacker.com/?json=1"

@interface ViewController ()

@property (nonatomic, strong) DBManager * dbManager;

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
    
    //self explanatory !
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"ioshacker.sql"];
    
    [self fetchPosts];
  //  [self saveInfo];
    
    UIRefreshControl  * refresh = [[UIRefreshControl alloc] init];
    
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to refresh"];
    
    [refresh addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl = refresh;
    
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

//saving data to db
-(void) saveInfo
{
    for (int i = 0; i< self.posts.count; i++) {
        NSString* tempURL = [[[self.posts objectAtIndex:i] valueForKey:@"url"] stringByReplacingOccurrencesOfString:@"http://" withString:@""];
        NSString *query = [NSString stringWithFormat:@"INSERT INTO posts VALUES('%@', '%@', '%@')",tempURL,[[self.posts objectAtIndex:i] valueForKey:@"title_plain"],[[self.posts objectAtIndex:i] valueForKey:@"content"]];
        
        // Execute the query.

        [self.dbManager executeQuery:query];
    }

    
    
    // If the query was successfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
    }
    else{
        NSLog(@"Could not execute the query.");
    }}


-(void)loadData{
//     Form the query.
    NSString *query = @"select * from posts";
  
     NSArray * results =[[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    for(int i=0;i<results.count;i++)
    {
        [self.posts addObject:[[[results objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"url"]] valueForKey:@"url"]];
        [self.posts addObject:[[[results objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"title"]] valueForKey:@"title"]];
        [self.posts addObject:[[[results objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"content"]] valueForKey:@"content"]];
    }
    // Reload the table view.
    [self.postsView reloadData];
}
- (IBAction)crashIt:(id)sender {
    
    //[[NSThread mainThread] exit];
    strcpy(0, "bla");
    
}

-(void)fetchPosts{
    
    //code to fetch JSON data and parse it to foundation objects
    
    NSURL *bURL = [NSURL URLWithString:blogURL];
    NSData* jsonData;
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
        for (int i = 0; i< self.posts.count; i++) {
            [self.attachments addObject:[[self.posts objectAtIndex:i]valueForKey:@"attachments"]];
        }
        
        for(int i=0;i<self.posts.count;i++)
        {
            NSString * cont = [[self.posts objectAtIndex:i] valueForKey:@"content"];
            NSRange index = [cont rangeOfString:@"\r"];

            while(index.location==NSNotFound)
            {
                
            }
        }
        
    }
    @catch (NSException *exception)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error"
                                                        message:@"No Internet available. Kindly check your network connection."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        NSLog(@"%@ ",exception.name);
        NSLog(@"Reason: %@ ",exception.reason);
        
        [self loadData];
    }
    

    //NSLog(@"1");
    
  
    
    
    //logging all the image URLS for testing
    /*for (int i = 0; i< self.attachments.count; i++) {
        
        NSLog(@"URL: %@", [[self.attachments objectAtIndex:i]valueForKey:@"url"]);
    }*/
    
    
    //here's the problem, we need to kick out all the clutter from content.
//    NSString *content = [[self.posts objectAtIndex:0]valueForKey:@"content"];
//    
//    NSLog(@"%@", content);
    //[self.postsView reloadData];
}



-(void)refreshView:(UIRefreshControl *)refresh {
    
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing data..."];
    
    NSLog(@"Refreshing data...");
    //strcpy(0, "bla");
    
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
        
        NSLog(@"YES");
        
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont systemFontOfSize:8.0];
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    
    //displays titles in UITableView cells
    
    NSString *title = [[self.posts objectAtIndex:indexPath.row]valueForKey:@"title_plain"];
    
    NSString *tempTitle = [title stringByReplacingOccurrencesOfString:@"&#8217;" withString:@"'"];
    
    NSString *tempTitle2 = [tempTitle stringByReplacingOccurrencesOfString:@"&#8216;" withString:@"'"];
    
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:16.0];
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    cell.textLabel.text = tempTitle2;
    
    
    //code to convert image urls to viewable images.
    
    /*NSURL* myURL = [NSURL URLWithString: self.attachments[indexPath.row][0][@"url"]];
    
    
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:myURL]];
    
    
    cell.imageView.image = img;*/

    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //self.posts
    
    //ViewController *test = [self.storyboard instantiateViewControllerWithIdentifier:@"Testing"];
    //[self performSegueWithIdentifier:@"Test" sender:self];
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    PostViewController* pVC = [segue destinationViewController];
    
    NSIndexPath* indexPath = self.tableView.indexPathForSelectedRow;
    
    pVC.postTitle = [[self.posts objectAtIndex:indexPath.row] valueForKey:@"title"];
    
    pVC.postContent = [[self.posts objectAtIndex:indexPath.row] valueForKey:@"content"];
    
    pVC.url = [[self.posts objectAtIndex:indexPath.row] valueForKey:@"url"];
    
//    pVC.postTitle.text = pVC.title;
//    
//    NSLog(@"%@", pVC.title);
    
}



@end
