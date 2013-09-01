//
//  OPNewProfessionalView.h
//  Opale
//
//  Created by Camille on 29/06/13.
//
//

#import "OPView.h"

@interface OPNewProfessionalView : OPView <NSComboBoxDelegate>{
    IBOutlet NSFormCell*    cellFirstName;
    IBOutlet NSImageView*   errorImageFirstName;
    IBOutlet NSFormCell*    cellLastName;
    IBOutlet NSImageView*   errorImageLastName;
    IBOutlet NSFormCell*    cellSpeciality;
    IBOutlet NSFormCell*    cellTel;
    IBOutlet NSFormCell*    cellAddress;
    IBOutlet NSFormCell*    cellTown;
    IBOutlet NSComboBox*    postalCodeComboBox;
    IBOutlet NSFormCell*    cellCountry;
}

@property (nonatomic, retain) IBOutlet NSFormCell*      cellFirstName;
@property (nonatomic, retain) IBOutlet NSImageView*     errorImageFirstName;
@property (nonatomic, retain) IBOutlet NSFormCell*      cellLastName;
@property (nonatomic, retain) IBOutlet NSImageView*     errorImageLastName;
@property (nonatomic, retain) IBOutlet NSFormCell*      cellSpeciality;
@property (nonatomic, retain) IBOutlet NSFormCell*      cellTel;
@property (nonatomic, retain) IBOutlet NSFormCell*      cellAddress;
@property (nonatomic, retain) IBOutlet NSFormCell*      cellTown;
@property (nonatomic, retain) IBOutlet NSComboBox*      postalCodeComboBox;
@property (nonatomic, retain) IBOutlet NSFormCell*      cellCountry;

-(IBAction)validateProfessional:(id)sender;


@end
