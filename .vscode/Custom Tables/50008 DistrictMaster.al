table 50008 "District Master"
{
    LookupPageID = "District Master";

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Active; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '//For App Sync';
            InitValue = true;
        }
        field(4; "Class of City"; Option)
        {
            DataClassification = ToBeClassified;
            Description = '//For App Sync';
            OptionCaption = ' ,A,B,C,D';
            OptionMembers = " ",A,B,C,D;
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
        fieldgroup(DropDown; "Code", Name)
        {
        }
    }

    trigger OnInsert()
    begin
        //Codeunit50004.DistrictMaster(Rec.Code,Rec.Name,Rec.Active);
    end;

    trigger OnModify()
    begin
        //Codeunit50004.DistrictMaster(Rec.Code,Rec.Name,Rec.Active);
    end;

    var
    // Codeunit50004: Codeunit "Nav to App Geographical Setup ";
}

