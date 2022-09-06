table 50003 "Crop Master"
{
    LookupPageID = "Crop Master";

    fields
    {
        field(1; "Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Expiration Date Calc."; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Image Url"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Near By Expiration Calc."; Duration)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Seed Process,Tissue Culture,Org. Seed Process';
            OptionMembers = " ","Seed Process","Tissue Culture","Org. Seed Process";
        }
        field(7; "TC PT Added Rooting"; Boolean)
        {
            Caption = 'Tissue Culture Process Transfer Added Rooting';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Rec.TestField(Type, Rec.Type::"Tissue Culture");
            end;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description)
        {
        }
    }
    var

}


