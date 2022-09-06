pageextension 50116 ItemLedgeEntry extends "Item Ledger Entries"
{
    layout
    {
        addbefore("Item No.")
        {

            field("Class of Seeds"; Rec."Class of Seeds")
            {
                ToolTip = 'Specifies the value of the Class of Seeds field.';
                ApplicationArea = All;
            }
            field("Crop Code"; Rec."Crop Code")
            {
                ToolTip = 'Specifies the value of the Crop Code field.';
                ApplicationArea = All;
            }
        }
        addafter("Item No.")
        {
            field("Item Name"; Rec."Item Name")
            {
                ToolTip = 'Specifies the value of the Item Name field.';
                ApplicationArea = All;
            }
            field("No. of Bags/Pckt"; Rec."No. of Bags/Pckt")
            {
                ToolTip = 'Specifies the value of the No. of Bags/Pckt field.';
                ApplicationArea = All;
            }
            field("FG Pack Size"; Rec."FG Pack Size")
            {
                ToolTip = 'Specifies the value of the FG Pack Size field.';
                ApplicationArea = All;
            }
            field("Item Category Code"; Rec."Item Category Code")
            {
                ToolTip = 'Specifies the value of the Item Category Code field.';
                ApplicationArea = All;
            }
            field("Variety Code"; Rec."Variety Code")
            {
                ToolTip = 'Specifies the value of the Variety Code field.';
                ApplicationArea = All;
            }
            field("Season Code"; Rec."Season Code")
            {
                ToolTip = 'Specifies the value of the Season Code field.';
                ApplicationArea = All;
            }
            field("Inventory Type"; Rec."Inventory Type")
            {
                ToolTip = 'Specifies the value of the Inventory Type field.';
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