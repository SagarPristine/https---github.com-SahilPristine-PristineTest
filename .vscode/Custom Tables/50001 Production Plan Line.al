table 50001 "Production Plan Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Production Plan No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Variety; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Varieties."Variety Code";
        }
        field(4; "Dynamic Column 1"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Dynamic Column 2"; Decimal)
        {
            DataClassification = CustomerContent;

        }
        field(6; "Dynamic Column 3"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Buffer for Storage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Adjustments (if any)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Dynamic Column 4"; Decimal)
        {
            DataClassification = CustomerContent;

        }
        field(10; "Dynamic Column 5"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Dynamic Column 6"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(12; "Dynamic Column 7"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(13; "Kharif Shortfall Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Kharif Check (positive figure implies shortfall in Production Plan)';
        }
        field(14; "Dynamic Column 8"; Decimal)
        {
            DataClassification = CustomerContent;

        }
        field(15; "Dynamic Column 9"; Decimal)
        {
            DataClassification = CustomerContent;


        }
        field(16; "Dynamic Column 10"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(17; "Dynamic Column 11"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(18; "Rabi Shortfall Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Rabi Check (positive figure implies shortfall in Production Plan)';
        }
        field(19; Season; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Season Master"."Season Code";
        }
    }

    keys
    {
        key(Key1; "Production Plan No.", Season, "Line No.")
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