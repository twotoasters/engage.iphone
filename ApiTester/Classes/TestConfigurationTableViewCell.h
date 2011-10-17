//
//  SwitchControlTableCell.h
//  ApiTester
//
//  Created by lilli on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    TCTableViewCellStyleDefault,
    TCTableViewCellStyleValue1,
    TCTableViewCellStyleValue2,
    TCTableViewCellStyleSubtitle,
    TCTableViewCellStyleSwitch,
    TCTableViewCellStyleSwitchWithLongTitle,
    TCTableViewCellStyleSwitchWithLongSubtitle,
    TCTableViewCellStyleSwitchWithLongTitleAndSubtitle,
} TCTableViewCellStyle;

typedef enum {
    TCTableViewCellPreviewStyleLong,
    TCTableViewCellPreviewStyleSquare,
    TCTableViewCellPreviewStyleCustom,
} TCTableViewCellPreviewStyle;

@class TestConfigurationTableViewCell;
@protocol TestConfigurationTableViewCellDelegate <NSObject>
@optional
- (void)testConfigurationTableViewCell:(TestConfigurationTableViewCell*)cell switchDidChange:(UISwitch*)cellSwitch;
@end

@interface TestConfigurationTableViewCell : UITableViewCell
{
    UISwitch *cellSwitch;
    UILabel  *cellTitle;
    UILabel  *cellSubtitle;
    UIButton *cellPreview;

    UIImageView *cellBorder;
    UIView      *cellDisabled;

    TCTableViewCellStyle        cellStyle;
    TCTableViewCellPreviewStyle previewStyle;

    id<TestConfigurationTableViewCellDelegate> delegate;
}
@property (nonatomic, retain) UISwitch    *cellSwitch;
@property (nonatomic, retain) UILabel     *cellTitle;
@property (nonatomic, retain) UILabel     *cellSubtitle;
@property (nonatomic, retain) UIButton    *cellPreview;
@property (nonatomic, retain) UIImageView *cellBorder;
@property (nonatomic, retain) UIView      *cellDisabled;
@property TCTableViewCellPreviewStyle previewStyle;
@property (nonatomic, retain) id<TestConfigurationTableViewCellDelegate> delegate;
- (id)initTestConfigurationTableViewCellWithStyle:(TCTableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier;
- (void)switchChanged:(id)sender;
@end
