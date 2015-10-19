/* UIEditableTableViewCell.m
 *
 * Copyright (C) 2012  Belledonne Comunications, Grenoble, France
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

#import "UIEditableTableViewCell.h"

@implementation UIEditableTableViewCell

@synthesize detailTextField;
@synthesize verticalSep;

#pragma mark - Lifecycle Functions

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		UITextField *tf = [[UITextField alloc] init];
		tf.hidden = TRUE;
		tf.clearButtonMode = UITextFieldViewModeWhileEditing;
		tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		tf.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

		self.detailTextField = tf;

		UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:[UIFont systemFontSize]];
		[self.detailTextLabel setFont:font];
		[self.detailTextField setFont:font];

		self.detailTextLabel.backgroundColor = self.detailTextField.backgroundColor =
			[UIColor colorWithPatternImage:[UIImage imageNamed:@"color_A"]];

		[self.contentView addSubview:detailTextField];

		// a vertical separator that will come between the text and detailed text
		UIView *v = [[UIView alloc] initWithFrame:CGRectMake(80, 5, 1, 34)];
		[v setBackgroundColor:[UIColor lightGrayColor]];
		[v setHidden:TRUE];

		self.verticalSep = v;

		[self.contentView addSubview:verticalSep];
	}
	return self;
}

#pragma mark - View Functions

- (void)layoutSubviews {
	[super layoutSubviews];

	CGRect superframe = [[self.detailTextField superview] frame];
	CGRect detailEditFrame;
	detailEditFrame.origin.x = 15;
	detailEditFrame.origin.y = 5;
	detailEditFrame.size.height = superframe.size.height - 10;

	if ([[self.textLabel text] length] != 0) {
		detailEditFrame.origin.x += [self.textLabel frame].size.width + 8;

		// shrink left text width by 10px
		CGRect leftLabelFrame = [self.textLabel frame];
		leftLabelFrame.size.width -= 10;
		[self.textLabel setFrame:leftLabelFrame];

		// place separator between left text and detailed text
		CGRect separatorFrame = [self.verticalSep frame];
		separatorFrame.origin.x = leftLabelFrame.size.width + leftLabelFrame.origin.x + 5;
		[self.verticalSep setFrame:separatorFrame];
		[self.verticalSep setHidden:FALSE];
	}

	// put the detailed text edit view at the correct position
	detailEditFrame.size.width = superframe.size.width - 10 - detailEditFrame.origin.x;
	self.detailTextField.frame = detailEditFrame;
}

#pragma mark - UITableViewCell Functions

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	[super setEditing:editing animated:animated];
	if (editing) {
		[self.detailTextField setHidden:FALSE];
		[self.detailTextLabel setHidden:TRUE];
	} else {
		[self.detailTextField setHidden:TRUE];
		[self.detailTextLabel setHidden:FALSE];
	}
}

- (void)setEditing:(BOOL)editing {
	[self setEditing:editing animated:FALSE];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
}

@end
