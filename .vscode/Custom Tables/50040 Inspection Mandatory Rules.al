table 50040 "Inspection Mandatory Rules"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50001; "Variety Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Varieties."Variety Code";
        }
        field(50002; "Nursery"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Vegetative"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Isolation"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Pre-Flowering"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50059; "Flowering"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; Pollination; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50060; "MaleChopping"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50061; "Final Roughing"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50062; "Harvesting"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50063; "Vegetative Roughing"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Variety Code")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}