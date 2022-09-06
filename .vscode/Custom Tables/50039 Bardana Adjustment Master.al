table 50039 "Bardana Adjustment Master"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Arrival Seed In kg"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50001; "Adjusted Bardana in Kg"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50002; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
    }

    keys
    {
        key(Key1; "Location Code", "Arrival Seed In kg", "Adjusted Bardana in Kg")
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