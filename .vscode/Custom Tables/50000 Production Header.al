table 50000 "Production Plan Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Production Plan No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; Season; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Season Master"."Season Code";
            trigger OnValidate()
            begin
            end;
        }
    }

    keys
    {
        key(Key1; "Production Plan No.")
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