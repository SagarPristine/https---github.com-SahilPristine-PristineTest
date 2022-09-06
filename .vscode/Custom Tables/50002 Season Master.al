table 50002 "Season Master"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Season Master";
    LookupPageId = "Season Master";

    fields
    {
        field(1; "Season Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; Sequence; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Season Code", Sequence)
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