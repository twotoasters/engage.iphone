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


#import "ConfigurationData.h"

@interface TestResultsViewController : UIViewController <UITableViewDataSource, UITabBarDelegate>
{
    ConfigurationData *config;

    UITableView *resultsTable;
    UIView      *detailView;
    UIImageView *detailViewIcon;
    UILabel     *detailViewSummaryLabel;
    UITextView  *detailViewTextView;
    UIButton    *detailViewCloseButton;

    NSArray *resultsArray;

    UINavigationController *detailViewController;
}
@property(nonatomic, retain) IBOutlet UITableView *resultsTable;
@property(nonatomic, retain) IBOutlet UIView      *detailView;
@property(nonatomic, retain) IBOutlet UIImageView *detailViewIcon;
@property(nonatomic, retain) IBOutlet UILabel     *detailViewSummaryLabel;
@property(nonatomic, retain) IBOutlet UITextView  *detailViewTextView;
@property(nonatomic, retain) IBOutlet UIButton    *detailViewCloseButton;
- (IBAction)closeButtonPressed:(id)sender;
@end
