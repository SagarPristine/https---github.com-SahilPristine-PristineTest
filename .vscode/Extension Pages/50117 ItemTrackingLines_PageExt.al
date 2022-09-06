pageextension 50117 ItemTrackingLines extends "Item Tracking Lines"
{
    layout
    {
        addafter("Lot No.")
        {
            field("No. of Bags/Pckt"; Rec."No. of Bags/Pckt")
            {
                ToolTip = 'Specifies the value of the No. of Bags/Pckt field.';
                ApplicationArea = All;
            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}