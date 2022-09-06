table 50007 "Region Master"
{
    LookupPageID = "Region Master";

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Regional manager"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Regional Manager Email id"; Text[40])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Regional Manager emp code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Regional Head emp code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Regional Head"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Regional Head Email id"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Regional Manager Mobile"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Active; Boolean)
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
        fieldgroup(DropDown; "Code", Name)
        {
        }
    }

    trigger OnInsert()
    begin
        /*Codeunit50004.RegionMaster(Rec.Code,Rec.Name,Rec."Regional manager",Rec."Regional Manager Email id",Rec."Regional Manager emp code",
                                Rec."Regional Head emp code",Rec."Regional Head",Rec."Regional Head Email id",Rec."Regional Manager Mobile"
                                ,Rec.Active);
        
        */

    end;

    trigger OnModify()
    begin
        /*Codeunit50004.RegionMaster(Rec.Code,Rec.Name,Rec."Regional manager",Rec."Regional Manager Email id",Rec."Regional Manager emp code",
                                  Rec."Regional Head emp code",Rec."Regional Head",Rec."Regional Head Email id",Rec."Regional Manager Mobile"
                                ,Rec.Active);
        */

    end;

    var
    // Codeunit50004: Codeunit "Nav to App Geographical Setup ";
}

