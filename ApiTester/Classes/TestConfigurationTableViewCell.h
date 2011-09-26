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
} TCTableViewCellStyle;

@interface TestConfigurationTableViewCell : UITableViewCell
{
    UISwitch *cellSwitch;
    UILabel  *cellTitle;
    UILabel  *cellSubtitle;
    UIButton *cellPreview;
}
@property (nonatomic, retain) UISwitch *cellSwitch;
@property (nonatomic, retain) UILabel  *cellTitle;
@property (nonatomic, retain) UILabel  *cellSubtitle;
@property (nonatomic, retain) UIButton *cellPreview;

- (id)initTestConfigurationTableViewCellWithStyle:(TCTableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier;
- (void)switchChanged:(id)sender;
@end
