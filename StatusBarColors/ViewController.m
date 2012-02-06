//
//  ViewController.m
//  StatusBarColors
//
//  Created by Mike Keller on 1/31/12.
//  Copyright (c) 2012 Meek Apps. All rights reserved.
//
//  A little hack to "change" the color of the UIStatusBar. 
//    It actually just sets the status bar to "Transparent black style (alpha of 0.5)"
//    And changes the background color of a UIView placed behind it. Note that because
//    the Status Bar is black with alpha 0.5, the color that appears is quite a bit 
//    darker than the UIColor.

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation ViewController

@synthesize allColors = _allColors;
@synthesize sortedColorKeys = _sortedColorKeys;
@synthesize selectedColor = _selectedColor;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction)changeAlpha:(id)sender {
    UISlider *alphaSlider = (UISlider*)sender;
    
    statusBarBG.alpha = alphaSlider.value;
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    //Set up the Color Dictionary    
    NSArray *colorKeys = [NSArray arrayWithObjects:@"White",
                                                   @"Red", 
                                                   @"Green",
                                                   @"Blue",
                                                   @"Cyan",
                                                   @"Yellow",
                                                   @"Magenta",
                                                   @"Orange",
                                                   @"Purple",
                                                   @"Brown", nil];
    
    NSArray *colorObjects = [NSArray arrayWithObjects:[UIColor whiteColor],
                                                      [UIColor redColor],
                                                      [UIColor greenColor],
                                                      [UIColor blueColor],
                                                      [UIColor cyanColor],
                                                      [UIColor yellowColor],
                                                      [UIColor magentaColor],
                                                      [UIColor orangeColor],
                                                      [UIColor purpleColor],
                                                      [UIColor brownColor], nil];
    
    self.allColors = [NSDictionary dictionaryWithObjects:colorObjects forKeys:colorKeys];
    
    //Sort the keys into alphabetical order
    self.sortedColorKeys = [[self.allColors allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    //initial status bar color is green
    self.selectedColor = @"Green";
    statusBarBG.backgroundColor = [UIColor greenColor];
    self.title = @"Green";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    statusBarBG.frame = CGRectMake(0, 
                                   0 - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height, 
                                   self.view.frame.size.width, 
                                   [UIApplication sharedApplication].statusBarFrame.size.height);
    
    // Return YES for supported orientations
    return YES;
}

#pragma mark - UITableView

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sortedColorKeys count];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.imageView.image = [UIImage imageNamed:@"placeholder.png"];
        
        [cell.imageView.layer setBorderColor:[UIColor grayColor].CGColor];
        [cell.imageView.layer setBorderWidth:1.0f];
    }
    
    //Text Label
    NSString *thisColorKey = [self.sortedColorKeys objectAtIndex:indexPath.row];
    cell.textLabel.text = thisColorKey;
    
    //Color Thumbnail
    UIColor *thisColor = [self.allColors objectForKey:thisColorKey];
    cell.imageView.backgroundColor = thisColor;
    
    //Checkmark
    if (self.selectedColor == thisColorKey) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //change the selected color
    NSString *thisColorKey = [self.sortedColorKeys objectAtIndex:indexPath.row];
    self.selectedColor = thisColorKey;
    [tableView reloadData];
    
    
    //change the color of the status bar
    UIColor *thisColor = [self.allColors objectForKey:thisColorKey];
    statusBarBG.backgroundColor = thisColor;
    
    //change the nav bar title
    self.title = thisColorKey;
}

@end
