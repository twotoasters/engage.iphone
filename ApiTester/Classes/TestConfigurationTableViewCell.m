//
//  SwitchControlTableCell.m
//  ApiTester
//
//  Created by lilli on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TestConfigurationTableViewCell.h"

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);


@implementation TestConfigurationTableViewCell
@synthesize cellSwitch;
@synthesize cellTitle;
@synthesize cellSubtitle;
@synthesize cellPreview;
@synthesize previewStyle;

- (id)initTestConfigurationTableViewCellWithStyle:(TCTableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier;
{
    DLog(@"%@", reuseIdentifier);
    
    if (style < TCTableViewCellStyleSwitch)
        return [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    cellTitle = [[[UILabel alloc] init] autorelease];
    cellSubtitle = [[[UILabel alloc] init] autorelease];
    cellSwitch = [[[UISwitch alloc] init] autorelease];
    cellPreview = [[[UIButton alloc] init] autorelease];
    
    [cellTitle setFont:[UIFont boldSystemFontOfSize:14.0]];
    [cellTitle setTextColor:[UIColor darkTextColor]];
    [cellTitle setLineBreakMode:UILineBreakModeWordWrap];
    [cellTitle setNumberOfLines:2];
    
    [cellSubtitle setFont:[UIFont systemFontOfSize:12.0]];
    [cellSubtitle setTextColor:[UIColor darkGrayColor]];
    [cellSubtitle setLineBreakMode:UILineBreakModeWordWrap];
    [cellSubtitle setNumberOfLines:2];
    
    [cellPreview setBackgroundImage:[UIImage imageNamed:@"enabledLightGray"] forState:UIControlStateNormal];
    [cellPreview setEnabled:NO];
    [cellPreview.titleLabel setFont:[UIFont boldSystemFontOfSize:12.0]];
    [cellPreview setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [cellPreview setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];

    //    [cellPreview setBackgroundImage:[UIImage imageNamed:@"disabledDarkGray"] forState:UIControlStateDisabled];
    
    [cellTitle setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin];
    [cellSubtitle setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    [cellSwitch setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin];
    [cellPreview setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    
    [cellSwitch addTarget:self
                   action:@selector(switchChanged:)
         forControlEvents:UIControlEventValueChanged];
    
    [cellTitle setBackgroundColor:[UIColor clearColor]];
    [cellSubtitle setBackgroundColor:[UIColor clearColor]];

//    [cellTitle setBackgroundColor:[UIColor redColor]];
//    [cellSubtitle setBackgroundColor:[UIColor redColor]];

//    [cellSwitch setBackgroundColor:[UIColor redColor]];
//    [cellPreview setBackgroundColor:[UIColor lightGrayColor]];
   
    [self.contentView addSubview:cellTitle];
    [self.contentView addSubview:cellSubtitle];
    [self.contentView addSubview:cellSwitch];
    [self.contentView addSubview:cellPreview];
    
    return self;    
}

- (void)layoutSubviews
{
    DLog(@"%@", self.reuseIdentifier);
    [super layoutSubviews];

    [self setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0]];

    CGRect cellFrame = self.frame;
    if (cellFrame.size.height > 90)
    {        
        cellTitle.frame = CGRectMake(10, 7, 196, 33);
        cellSwitch.frame = CGRectMake(216, 10, 94, 27);
        cellSubtitle.frame = CGRectMake(10, 42, 300, 30);
        
        switch (previewStyle)
        {
            case TCTableViewCellPreviewStyleLong:
                cellPreview.frame = CGRectMake(10, 80, 300, 24);
                break;
            case TCTableViewCellPreviewStyleSquare:
                cellPreview.frame = CGRectMake(10, 80, 300, 24);
                break;
            default:
                cellPreview.frame = CGRectMake(10, 80, 300, 24);
                break;
        }        
    }
    else
    {
        cellTitle.frame = CGRectMake(10, 7, 196, 19);
        cellSubtitle.frame = CGRectMake(10, 28, 300, 17);        

        switch (previewStyle)
        {
            case TCTableViewCellPreviewStyleLong:
                cellSwitch.frame = CGRectMake(216, 10, 94, 27);
                cellPreview.frame = CGRectMake(10, 53, 300, 24);
                break;
            case TCTableViewCellPreviewStyleSquare:
                cellSwitch.frame = CGRectMake(180, 10, 94, 27);
                cellPreview.frame = CGRectMake(280, 10, 27, 27);
                break;
            default:
                cellSwitch.frame = CGRectMake(216, 10, 94, 27);
                cellPreview.frame = CGRectMake(10, 53, 300, 24);
                break;
        }
    }
}

- (void)switchChanged:(id)sender
{
    DLog(@"%@: %@", self.reuseIdentifier, cellSwitch.on ? @"ON" : @"OFF");

    if (cellSwitch.on == YES)
    {
        DLog(@"%@", [[UIFont fontNamesForFamilyName:@"Marker Felt"] description]);
        [self setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
        [cellPreview setEnabled:YES];
    }
    else
    {         
        [self setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0]];
        [cellPreview setEnabled:NO];
    }
    
//    [self setNeedsLayout];
}



// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

//- (void)didReceiveMemoryWarning {
//    // Releases the view if it doesn't have a superview.
//    [super didReceiveMemoryWarning];
//    
//    // Release any cached data, images, etc. that aren't in use.
//}
//
//- (void)viewDidUnload {
//    [super viewDidUnload];
//    // Release any retained subviews of the main view.
//    // e.g. self.myOutlet = nil;
//}


- (void)dealloc {
    [super dealloc];
}


@end
