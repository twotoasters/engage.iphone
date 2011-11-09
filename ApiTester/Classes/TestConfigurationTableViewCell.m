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
@synthesize cellDisabled;
@synthesize cellBorder;
@synthesize previewStyle;
@synthesize delegate;


- (id)initTestConfigurationTableViewCellWithStyle:(TCTableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier;
{
//    DLog(@"%@", reuseIdentifier);
    cellStyle = style;

    if (style < TCTableViewCellStyleSwitch)
        return [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];

    cellTitle    = [[UILabel alloc] init];
    cellSubtitle = [[UILabel alloc] init];
    cellSwitch   = [[UISwitch alloc] init];
    cellPreview  = [[UIView alloc] init];
//    cellPreview  = [[UIButton alloc] init];

    cellBorder   = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"divider.png"]];
    cellDisabled = [[UIView alloc] init];

    [cellTitle setFont:[UIFont boldSystemFontOfSize:18.0]];
    [cellTitle setTextColor:[UIColor darkTextColor]];
    [cellTitle setMinimumFontSize:10.0];
    [cellTitle setAdjustsFontSizeToFitWidth:TRUE];
    [cellTitle setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];

    if (style == TCTableViewCellStyleSwitchWithLongTitle || style == TCTableViewCellStyleSwitchWithLongTitleAndSubtitle)
    {
        [cellTitle setFont:[UIFont boldSystemFontOfSize:15.0]];
        [cellTitle setAdjustsFontSizeToFitWidth:NO];
        [cellTitle setLineBreakMode:UILineBreakModeWordWrap];
        [cellTitle setNumberOfLines:2];
    }

    [cellSubtitle setFont:[UIFont systemFontOfSize:14.0]];
    [cellSubtitle setTextColor:[UIColor darkGrayColor]];
    [cellSubtitle setMinimumFontSize:10.0];
    [cellSubtitle setAdjustsFontSizeToFitWidth:TRUE];

    if (style == TCTableViewCellStyleSwitchWithLongSubtitle || style == TCTableViewCellStyleSwitchWithLongTitleAndSubtitle)
    {
        [cellSubtitle setLineBreakMode:UILineBreakModeWordWrap];
        [cellSubtitle setNumberOfLines:2];
    }

//    [cellPreview setBackgroundImage:[UIImage imageNamed:@"enabledLightGray"] forState:UIControlStateNormal];
//    [cellPreview setEnabled:NO];
//    [cellPreview.titleLabel setFont:[UIFont boldSystemFontOfSize:12.0]];
//    [cellPreview setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//    [cellPreview setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];

    [cellTitle    setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin];
    [cellSubtitle setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    [cellSwitch   setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin];
    [cellPreview  setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];

    [cellSwitch addTarget:self
                   action:@selector(switchChanged:)
         forControlEvents:UIControlEventValueChanged];

    [cellTitle setBackgroundColor:[UIColor clearColor]];
    [cellSubtitle setBackgroundColor:[UIColor clearColor]];
    [cellDisabled setBackgroundColor:[UIColor clearColor]];

    [self.contentView addSubview:cellTitle];
    [self.contentView addSubview:cellSubtitle];
    [self.contentView addSubview:cellPreview];
    [self.contentView addSubview:cellBorder];

    [self.contentView addSubview:cellDisabled];
    [self.contentView addSubview:cellSwitch];

    [self setBackgroundColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0]];

    return self;
}

- (void)layoutSubviews
{
//    DLog(@"%@", self.reuseIdentifier);
    [super layoutSubviews];

    CGFloat cellContentWidth  = self.contentView.frame.size.width;
    CGFloat cellContentHeight = self.contentView.frame.size.height;

    cellDisabled.frame = CGRectMake(0, 0, cellContentWidth, cellContentHeight);
    cellBorder.frame   = CGRectMake(0, cellContentHeight - 14, cellContentWidth, 14);

    if (previewStyle == TCTableViewCellPreviewStyleSquare)
    {
        cellSwitch.frame  = CGRectMake(cellContentWidth - 140, 10, 94, 27);
        cellPreview.frame = CGRectMake(cellContentWidth - 40, 10, 27, 27);
    }
    else if (previewStyle == TCTableViewCellPreviewStyleLong)
    {
        cellSwitch.frame  = CGRectMake(cellContentWidth - 104, 10, 94, 27);
        cellPreview.frame = CGRectMake(10, 62, cellContentWidth - 20, 24);
    }
    else // if (previewStyle == TCTableViewCellPreviewStyleCustom)
    {
        cellSwitch.frame  = CGRectMake(cellContentWidth - 104, 10, 94, 27);
        cellPreview.frame = CGRectMake(10, 62, cellContentWidth - 20, cellContentHeight - 62 - 10);
    }

    CGFloat titleWidth = cellSwitch.frame.origin.x - 18;

    switch (cellStyle)
    {
        case TCTableViewCellStyleSwitch:
            cellTitle.frame    = CGRectMake(10, 12, titleWidth, 24);
            cellSubtitle.frame = CGRectMake(10, 40, cellContentWidth - 20, 18);

            break;

        case TCTableViewCellStyleSwitchWithLongTitle:
            cellTitle.frame    = CGRectMake(10, 6, titleWidth, 35);
            cellSubtitle.frame = CGRectMake(10, 42, cellContentWidth - 20, 18);

            if (previewStyle == TCTableViewCellPreviewStyleLong)
                cellPreview.frame = CGRectMake(10, 64, cellContentWidth - 20, 24);
            else if (previewStyle == TCTableViewCellPreviewStyleCustom)
                cellPreview.frame = CGRectMake(10, 64, cellContentWidth - 20, cellContentHeight - 64 - 10);

            break;

        case TCTableViewCellStyleSwitchWithLongSubtitle:
            cellTitle.frame    = CGRectMake(10, 12, titleWidth, 24);
            cellSubtitle.frame = CGRectMake(10, 40, cellContentWidth - 20, 36);

            if (previewStyle == TCTableViewCellPreviewStyleLong)
                cellPreview.frame = CGRectMake(10, 80, cellContentWidth - 20, 24);
            else if (previewStyle == TCTableViewCellPreviewStyleCustom)
                cellPreview.frame = CGRectMake(10, 80, cellContentWidth - 20, cellContentHeight - 80 - 10);

            break;

        case TCTableViewCellStyleSwitchWithLongTitleAndSubtitle:
            cellTitle.frame    = CGRectMake(10, 6, titleWidth, 35);
            cellSubtitle.frame = CGRectMake(10, 42, cellContentWidth - 20, 36);

            if (previewStyle == TCTableViewCellPreviewStyleLong)
                cellPreview.frame = CGRectMake(10, 82, cellContentWidth - 20, 24);
            else if (previewStyle == TCTableViewCellPreviewStyleCustom)
                cellPreview.frame = CGRectMake(10, 82, cellContentWidth - 20, cellContentHeight - 82 - 10);

            break;

        default:
            break;
    }

    UIView *cellPreviewSubview = ([[cellPreview subviews] count]) ? [[cellPreview subviews] objectAtIndex:0] : nil;

    cellPreviewSubview.frame = CGRectMake(0, 0, cellPreview.frame.size.width, cellPreview.frame.size.height);

    if (cellSwitch.on == YES)
    {
        [cellDisabled setHidden:YES];

        // Casting to remove warning... probably a better way, but...
        if ([cellPreviewSubview respondsToSelector:@selector(setEnabled:)])
            [(UIButton*)cellPreviewSubview setEnabled:YES];

        [self setBackgroundColor:[UIColor whiteColor]];
    }
    else
    {
        [cellDisabled setHidden:NO];

        if ([cellPreviewSubview respondsToSelector:@selector(setEnabled:)])
            [(UIButton*)cellPreviewSubview setEnabled:NO];

        [self setBackgroundColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0]];
    }
}

- (void)switchChanged:(id)sender
{
//    DLog(@"%@: %@", self.reuseIdentifier, cellSwitch.on ? @"ON" : @"OFF");

    UIView *cellPreviewSubview = ([[cellPreview subviews] count]) ? [[cellPreview subviews] objectAtIndex:0] : nil;

    if (cellSwitch.on == YES)
    {
        [cellDisabled setHidden:YES];

        if ([cellPreviewSubview respondsToSelector:@selector(setEnabled:)])
            [(UIButton*)cellPreviewSubview setEnabled:YES];

        [self setBackgroundColor:[UIColor whiteColor]];
    }
    else
    {
        [cellDisabled setHidden:NO];

        if ([cellPreviewSubview respondsToSelector:@selector(setEnabled:)])
            [(UIButton*)cellPreviewSubview setEnabled:NO];

        [self setBackgroundColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0]];
    }

    if ([delegate respondsToSelector:(@selector(testConfigurationTableViewCell:switchDidChange:))])
        [delegate testConfigurationTableViewCell:self switchDidChange:cellSwitch];
}

- (void)previewChanged:(id)sender
{
    if ([delegate respondsToSelector:(@selector(testConfigurationTableViewCell:previewDidChange:))])
        [delegate testConfigurationTableViewCell:self previewDidChange:cellPreview];
}

- (void)dealloc
{
    [cellTitle release];
    [cellSubtitle release];
    [cellSwitch release];
    [cellPreview release];
    [cellDisabled release];
    [cellBorder release];

    [delegate release];

    [super dealloc];
}
@end
