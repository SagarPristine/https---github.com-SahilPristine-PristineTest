tableextension 50075 PurchLine extends "Purchase Line"
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
        field(50006; "Class of Seeds"; Option)
        {
            FieldClass = FlowField;
            OptionMembers = " ",Breeder,Foundation,TL,"Tissue Culture";
            CalcFormula = lookup(Item."Class of Seeds" where("No." = field("No.")));
        }
        field(50008; "Variety Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                item: Record item;
            begin
                item.Get("No.");
                "Crop Code" := item."Crop Code";
                "Variety Code" := item."Variety Code";
            end;
        }
        field(50009; "Production Lot Status"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Production Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Planting List Line"."Production Lot No." where(Posted = filter(true));
        }
        field(50011; Bardana; Decimal)
        {
            DataClassification = ToBeClassified;
        }


    }

    var
        myInt: Integer;
}