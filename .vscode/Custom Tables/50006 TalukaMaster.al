table 50006 "Taluka Master"
{
    LookupPageID = "Taluka Master";

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Active; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '//For App Sync';
            InitValue = true;
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

    trigger OnInsert()
    begin
        //Codeunit50004.TalukaMaster(Rec.Code,Rec.Description,Rec.Active);
    end;

    trigger OnModify()
    begin
        //Codeunit50004.TalukaMaster(Rec.Code,Rec.Description,Rec.Active);
    end;

    var
    // Codeunit50004: Codeunit "Nav to App Geographical Setup ";
}

