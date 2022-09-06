table 50010 "Location Wise Prod. Dist."
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Production Plan No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Variety"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Season"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(4; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;

        }
        field(5; "Dynamic Column 1"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Shortage; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Risk Factor %"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Risk Factor Master"."Risk Factor %" where("Location Code" = field("Location Code"),
            Season = field(Season), Variety = field(Variety)));
        }
        field(8; "Raw Prod. req. assum 67% Risk"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Raw Production required assuming 67% Risk';
            Editable = false;
        }
        field(9; "Average Yield / Acre in MT"; Decimal)
        {

            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Risk Factor Master"."Average Yield / Acre in MT" where("Location Code" = field("Location Code"),
            Season = field(Season), Variety = field(Variety)));
        }
        field(10; "Seed Rate / Acre"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Risk Factor Master"."Seed Rate / Acre" where("Location Code" = field("Location Code"),
            Season = field(Season), Variety = field(Variety)));
        }
        field(11; "PS Required for Distribution"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Acreage Required"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Last Production Plan Qty"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Production Plan Line"."Dynamic Column 7" where("Production Plan No." = field("Production Plan No."),
            Season = field(Season), Variety = field(Variety)));


        }
    }


    keys
    {
        key(Key1; "Production Plan No.", Season, Variety, "Location Code")
        {
            SumIndexFields = "PS Required for Distribution";
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