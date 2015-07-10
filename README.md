# ComboActionSheet
This instance can auto judge iOS version, then use UIActionSheet in iOS7 and earlier, use UIAlertController in iOS8 and later.

#Usage:
ComboActionSheet *actionSheet = [[ComboActionSheet alloc] init];
[actionSheet showWithVC:self delegate:self title:@"Hello" message:@"How old are you?" cancelButtonText:@"Cancel" otherButtonTitles:@[@"0~20",@"20~40",@"over 40"]];
