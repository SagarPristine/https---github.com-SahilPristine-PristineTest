tableextension 50072 TrackingSpecification extends "Tracking Specification"
{
    fields
    {
        field(50000; "No. of Bags/Pckt"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Item: Record Item;
            begin

                Item.Get("Item No.");
                if Item."FG Pack Size" > 0 then begin
                    Validate("Quantity (Base)", "No. of Bags/Pckt" * Item."FG Pack Size");
                end;

                if "No. of Bags/Pckt" = 0 then
                    Validate("Quantity (Base)", 0);

            end;
        }
    }

    var
        myInt: Integer;
}