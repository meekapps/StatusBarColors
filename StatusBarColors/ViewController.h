//
//  ViewController.h
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

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    IBOutlet UITableView *myTableView;
    IBOutlet UIView *statusBarBG;
    
    NSString *_selectedColor;
    
    NSDictionary *_allColors;
    NSArray *_sortedColorKeys;
}

- (IBAction)changeAlpha:(id)sender;

@property (nonatomic, retain) NSString *selectedColor;

@property (nonatomic, retain) NSDictionary *allColors;
@property (nonatomic, retain) NSArray *sortedColorKeys;

@end
