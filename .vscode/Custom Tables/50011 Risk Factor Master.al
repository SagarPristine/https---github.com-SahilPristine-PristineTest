table 50011 "Risk Factor Master"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Location Code"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;

        }
        field(2; "Season"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Season Master"."Season Code";

        }
        field(3; "Variety"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Varieties;

        }
        field(4; "Risk Factor %"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(5; "Average Yield / Acre in MT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Seed Rate / Acre"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Location Code", Season, Variety)
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