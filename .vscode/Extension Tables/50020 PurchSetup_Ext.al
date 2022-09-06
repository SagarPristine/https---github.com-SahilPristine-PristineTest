tableextension 50020 PurchSetup extends "Purchases & Payables Setup"
{
    fields
    {
        field(50000; "Process Transfer Template Name"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Template";
        }
        field(50001; "Process Transfer Batch Name"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Batch".Name;
        }
        field(50002; "Production Lot indicator"; Code[20])

        {
            DataClassification = ToBeClassified;
        }
    }
    var
        myInt: Integer;
}