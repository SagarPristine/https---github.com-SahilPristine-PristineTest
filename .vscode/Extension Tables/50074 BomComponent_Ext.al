tableextension 50074 BomComponent extends "BOM Component"
{
    fields
    {
        field(50000; Stage; Code[20])
        {
            TableRelation = "Crop Stage Master".Stage;
            TestTableRelation = false;
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}