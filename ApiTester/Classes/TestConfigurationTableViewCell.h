/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 Copyright (c) 2011, Janrain, Inc.

 All rights reserved.

 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this
     list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice,
     this list of conditions and the following disclaimer in the documentation and/or
     other materials provided with the distribution.
 * Neither the name of the Janrain, Inc. nor the names of its
     contributors may be used to endorse or promote products derived from this
     software without specific prior written permission.


 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
 ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */


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
- (void)testConfigurationTableViewCell:(TestConfigurationTableViewCell*)cell previewDidChange:(UIView*)cellPreview;
@end

@interface TestConfigurationTableViewCell : UITableViewCell
{
    UISwitch *cellSwitch;
    UILabel  *cellTitle;
    UILabel  *cellSubtitle;
    UIView   *cellPreview;
//    UIButton *cellPreview;

    UIImageView *cellBorder;
    UIView      *cellDisabled;

    TCTableViewCellStyle        cellStyle;
    TCTableViewCellPreviewStyle previewStyle;

    id<TestConfigurationTableViewCellDelegate> delegate;
}
@property (nonatomic, retain) UISwitch    *cellSwitch;
@property (nonatomic, retain) UILabel     *cellTitle;
@property (nonatomic, retain) UILabel     *cellSubtitle;
@property (nonatomic, retain) UIView      *cellPreview;
//@property (nonatomic, retain) UIButton    *cellPreview;
@property (nonatomic, retain) UIImageView *cellBorder;
@property (nonatomic, retain) UIView      *cellDisabled;
@property TCTableViewCellPreviewStyle previewStyle;
@property (nonatomic, retain) id<TestConfigurationTableViewCellDelegate> delegate;
- (id)initTestConfigurationTableViewCellWithStyle:(TCTableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier;
- (void)switchChanged:(id)sender;
- (void)previewChanged:(id)sender;
@end
