# ComboActionSheet
Based on the iOS version, ComboActionSheet applies compatible native components (could be UIActionSheet or UIAlertController)

# Usage:
ComboActionSheet *actionSheet = [[ComboActionSheet alloc] init];
[actionSheet showWithVC:self delegate:self title:@"Hello" message:@"How old are you?" cancelButtonText:@"Cancel" otherButtonTitles:@[@"0~20",@"20~40",@"over 40"]];
