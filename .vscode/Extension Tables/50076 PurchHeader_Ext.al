tableextension 50076 PurchHeader extends "Purchase header"
{
    fields
    {
        field(50019; "Document SubType"; Option)
        {
            OptionMembers = " ",Adobe,Production;
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
        field(50009; Season; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Season Master"."Season Code";
        }
        field(50010; "Transporter name"; text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(50011; "Party DC/Bill No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(50012; "Party DC/Bill Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(50013; "LR No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "LR. Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Freight Term"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","FOR","Ex-Godown";
        }
        field(50016; "Freight Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Paid By Party"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Balance Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

    }

    var
        myInt: Integer;
}