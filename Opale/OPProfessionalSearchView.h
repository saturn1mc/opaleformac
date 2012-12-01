//
//  OPProfessionalSearchView.h
//  Opale
//
//  Created by Camille on 01/12/12.
//
//

#import "OPView.h"

#import <AddressBook/ABPeoplePickerView.h>
#import <AddressBook/AddressBook.h>

@interface OPProfessionalSearchView : OPView{
    IBOutlet ABPeoplePickerView* pickerView;
}

@property (nonatomic, retain) IBOutlet ABPeoplePickerView* pickerView;

@end
