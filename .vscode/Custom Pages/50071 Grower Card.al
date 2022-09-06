page 50071 "Grower Card"
{
    PageType = Card;
    SourceTable = Growers;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Name 2"; Rec."Name 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name 2 field.';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address 2 field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the City field.';
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contact field.';
                }
                field("Counrty/Region Code"; Rec."Counrty/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Counrty/Region Code field.';
                }
                field(District; Rec.District)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the District field.';
                }
                field("District Name"; Rec."District Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the District Name field.';
                }
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone field.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Post Code field.';
                }
                field(Region; Rec.Region)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Region field.';
                }
                field("Region Name"; Rec."Region Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Region Name field.';
                }
                field("State Code"; Rec."State Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the State Code field.';
                }

                field(Taluka; Rec.Taluka)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Taluka field.';
                }
                field("Taluka Name"; Rec."Taluka Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Taluka Name field.';
                }
                field(Village; Rec.Village)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Village field.';
                }
                field(Zone; Rec.Zone)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Zone field.';
                }
                field("Zone Name"; Rec."Zone Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Zone Name field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Create Related Master")
            {
                ApplicationArea = All;
                Image = CreateDocument;
                Promoted = true;
                PromotedOnly = true;

                trigger OnAction();
                var
                    Growers: Record Growers;
                    customer: Record Customer;
                    vendor: Record Vendor;
                    RecordStatus: Option New,"Already Exist";
                    TotalmodifyRecords: Integer;
                    TotalInsertRecords: Integer;
                begin
                    CurrPage.SetSelectionFilter(Rec);
                    if Rec.FindSet() then begin
                        repeat

                            if customer.get(Rec."No.") then
                                RecordStatus := RecordStatus::"Already Exist"
                            else
                                RecordStatus := RecordStatus::New;

                            if RecordStatus = RecordStatus::New then begin
                                customer.Init();
                                customer."No." := Rec."No.";
                                TotalInsertRecords += 1;
                            end;
                            customer.Validate(Name, Rec.Name);
                            customer.Validate("Name 2", Rec."Name 2");
                            customer.Validate(Address, rec.Address);
                            customer.validate("Address 2", Rec."Address 2");
                            customer.Validate(Blocked, Rec.Blocked);
                            customer.Validate("Post Code", Rec."Post Code");
                            customer.Validate(City, Rec.City);
                            customer.Validate("State Code", Rec."State Code");
                            customer.Validate(Zone, Rec.Zone);
                            customer.Validate(Taluka, Rec.Taluka);
                            customer.Validate(Region, Rec.Region);
                            customer.Validate(District, Rec.District);
                            customer.Validate("Phone No.", Rec.Phone);
                            customer.Validate("Customer Type", customer."Customer Type"::Grower);
                            customer.Validate(Contact, Rec.Contact);
                            customer.Validate("Is party", true);
                            if RecordStatus = RecordStatus::"Already Exist" then begin
                                customer.Modify(true);
                                TotalmodifyRecords += 1;
                            end else
                                customer.Insert(true);


                            if Vendor.get(Rec."No.") then
                                RecordStatus := RecordStatus::"Already Exist"
                            else
                                RecordStatus := RecordStatus::New;

                            if RecordStatus = RecordStatus::New then begin
                                Vendor.Init();
                                Vendor."No." := Rec."No.";
                            end;
                            Vendor.Validate(Name, Rec.Name);
                            Vendor.Validate("Name 2", Rec."Name 2");
                            Vendor.Validate(Address, rec.Address);
                            Vendor.validate("Address 2", Rec."Address 2");
                            Vendor.Validate(Blocked, Rec.Blocked);
                            Vendor.Validate("Post Code", Rec."Post Code");
                            Vendor.Validate(City, Rec.City);
                            Vendor.Validate("State Code", Rec."State Code");
                            Vendor.Validate(Zone, Rec.Zone);
                            Vendor.Validate(Taluka, Rec.Taluka);
                            Vendor.Validate(Region, Rec.Region);
                            Vendor.Validate(District, Rec.District);
                            Vendor.Validate("Phone No.", Rec.Phone);
                            Vendor.Validate(vendor."Vendor Type", vendor."Vendor Type"::Grower);
                            Vendor.Validate(Contact, Rec.Contact);
                            if RecordStatus = RecordStatus::"Already Exist" then
                                Vendor.Modify(true)
                            else
                                Vendor.Insert(true);
                        until Rec.Next() = 0;
                    end;
                    Message('Total No. of records updated are %1 and Total No. of records Inserted are %2', TotalmodifyRecords, TotalInsertRecords);
                end;
            }
        }
    }

    var
        myInt: Integer;
}