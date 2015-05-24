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
@property (nonatomic, strong) NSArray *attachments;

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
    
    //NSLog(@"1");
    
    self.posts = [dataDictionary objectForKey:@"posts"];
    
    
    self.attachments = [[self.posts objectAtIndex:0]valueForKey:@"attachments"];
    
    //NSString *img = [[self.attachments objectAtIndex:0]valueForKey:@"url"];
    
    
    
    //NSLog(@"%@", img);
    
    
    //NSLog(@"%@", posts);
    
    //NSArray* post1 = [posts objectForKey:@"title"];
    
    NSString *title = [[self.posts objectAtIndex:0]valueForKey:@"title_plain"];
    NSString *date = [[self.posts objectAtIndex:0]valueForKey:@"date"];
    
    NSString *content = [[self.posts objectAtIndex:0]valueForKey:@"excerpt"];
    
    
    NSLog(@"%@", title);
    NSLog(@"%@", date);
    NSLog(@"%@", content);
    
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
    
    cell.textLabel.text = [[self.posts objectAtIndex:indexPath.row]valueForKey:@"title_plain"];
    
    NSString* myurl = [[self.attachments objectAtIndex:0]valueForKey:@"url"];
    
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: myurl]];
    
    cell.imageView.image = [UIImage imageWithData: imageData];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.section == 0) {
//        if (indexPath.row == 1) {
//            return 120;
//        }
//    }
    
//    CGSize rowSize=[self calculateLabelHeightWith:320 text:[[self.posts objectAtIndex:indexPath.row]valueForKey:@"title_plain"]];
//    
//    return (rowSize.height+20);
    
    return 80;
    
}


@end
