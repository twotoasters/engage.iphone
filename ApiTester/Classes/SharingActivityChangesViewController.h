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
#import "TestConfigurationTableViewCell.h"
#import "JRActivityObject.h"
#import "ConfigurationData.h"
#import "StartTestViewController.h"

@interface SharingActivityChangesViewController : UIViewController <TestConfigurationTableViewCellDelegate,
                                                                    UIPickerViewDataSource, UIPickerViewDelegate,
                                                                    UITableViewDataSource, UITableViewDelegate>
{
    ConfigurationData *config;
    NSArray           *cellTitles;

    UIPickerView *picker;
    UITableView  *table;
    UIImageView  *thinDivider;
    UIImageView  *sliderDivider;
    UIButton     *sliderButton;

    NSMutableArray *activityArray;
    NSMutableArray *cellSwitchStates;
    NSMutableArray *cellPreviewTextFieldNumbers;

    BOOL sliderUp;
}
@property (retain, nonatomic) IBOutlet UIPickerView *picker;
@property (retain, nonatomic) IBOutlet UITableView  *table;
@property (retain, nonatomic) IBOutlet UIImageView  *thinDivider;
@property (retain, nonatomic) IBOutlet UIImageView  *sliderDivider;
@property (retain, nonatomic) IBOutlet UIButton     *sliderButton;
- (IBAction)sliderButtonPressed:(id)sender;
@end
