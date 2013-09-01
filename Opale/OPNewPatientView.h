//
//  OPNewPatientView.h
//  Opale
//
//  Created by Camille on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <AddressBook/AddressBook.h>

#import "OPView.h"

@class OPAdultMalePatientView;

@interface OPNewPatientView : OPView <NSComboBoxDelegate>{
    IBOutlet NSFormCell*    cellFirstName;
    IBOutlet NSImageView*   errorImageFirstName;
    IBOutlet NSFormCell*    cellLastName;
    IBOutlet NSImageView*   errorImageLastName;
    IBOutlet NSDatePicker*  birthdayPicker;
    IBOutlet NSMatrix*      matrixSex;
    IBOutlet NSFormCell*    cellTel1;
    IBOutlet NSFormCell*    cellTel2;
    IBOutlet NSFormCell*    cellAddress;
    IBOutlet NSFormCell*    cellTown;
    IBOutlet NSComboBox*    postalCodeComboBox;
    IBOutlet NSFormCell*    cellCountry;
}

@property (nonatomic, retain) IBOutlet NSFormCell*      cellFirstName;
@property (nonatomic, retain) IBOutlet NSImageView*     errorImageFirstName;
@property (nonatomic, retain) IBOutlet NSFormCell*      cellLastName;
@property (nonatomic, retain) IBOutlet NSImageView*     errorImageLastName;
@property (nonatomic, retain) IBOutlet NSDatePicker*    birthdayPicker;
@property (nonatomic, retain) IBOutlet NSMatrix*        matrixSex;
@property (nonatomic, retain) IBOutlet NSFormCell*      cellTel1;
@property (nonatomic, retain) IBOutlet NSFormCell*      cellTel2;
@property (nonatomic, retain) IBOutlet NSFormCell*      cellAddress;
@property (nonatomic, retain) IBOutlet NSFormCell*      cellTown;
@property (nonatomic, retain) IBOutlet NSComboBox*      postalCodeComboBox;
@property (nonatomic, retain) IBOutlet NSFormCell*      cellCountry;

-(IBAction)validatePatient:(id)sender;

@end
