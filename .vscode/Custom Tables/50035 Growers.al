table 50035 "Growers"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; Name; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Name 2"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(4; "Address"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(5; "Address 2"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(6; "City"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(7; "Contact"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(8; Phone; Code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(9; "Counrty/Region Code"; Code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(10; Blocked; Enum "Customer Blocked")
        {
            DataClassification = ToBeClassified;

        }
        field(11; "Post Code"; Code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(12; "State Code"; Code[20])
        {

        }
        field(50000; Zone; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Zone Master".Code;
        }
        field(50001; District; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "District Master".Code;
        }
        field(50002; Region; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Region Master".Code;
        }
        field(50003; Taluka; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Taluka Master".Code;
        }
        field(50005; "Zone Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Zone Master".Description where(Code = field(Zone)));
        }
        field(50006; "Taluka Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Taluka Master".Description where(Code = field(Taluka)));
        }
        field(50007; "Region Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Region Master".Name where(Code = field(Region)));
        }
        field(50008; "District Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("District Master".Name where(Code = field(District)));
        }
        field(50009; Village; Text[50])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "No.")
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