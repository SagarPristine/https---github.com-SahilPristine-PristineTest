tableextension 50067 SalesShipmentLine extends "Sales Shipment Line"
{
    fields
    {
        field(50001; "Crop Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Crop Master".Code;

        }
        field(50002; "No. of Bags/Pckt"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Land in Acre"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "DO No."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "DO Line No."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Class of Seeds"; Option)
        {
            FieldClass = FlowField;
            OptionMembers = " ",Breeder,Foundation,TL,"Tissue Culture";
            CalcFormula = lookup(Item."Class of Seeds" where("No." = field("No.")));
        }
        field(50007; "Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Variety Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}