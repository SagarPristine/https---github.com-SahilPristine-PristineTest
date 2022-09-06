pageextension 50062 ItemListExt extends "Item List"
{
    layout
    {
        addafter("Default Deferral Template Code")
        {

            field("Variety Code"; Rec."Variety Code")
            {
                ToolTip = 'Specifies the value of the Variety Code field.';
                ApplicationArea = All;
            }
            field("FG Pack Size"; Rec."FG Pack Size")
            {
                ToolTip = 'Specifies the value of the FG Pack Size field.';
                ApplicationArea = All;
            }
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
            field("Crop Type"; Rec."Crop Type")
            {
                ToolTip = 'Specifies the value of the Crop Type field.';
                ApplicationArea = All;
            }
            field("Hybrid Type"; Rec."Hybrid Type")
            {
                ToolTip = 'Specifies the value of the Hybrid Type field.';
                ApplicationArea = All;
            }
            field("Item Type"; Rec."Item Type")
            {
                ToolTip = 'Specifies the value of the Item Type field.';
                ApplicationArea = All;
            }
            field("Item Category Id"; Rec."Item Category Id")
            {
                ToolTip = 'Specifies the value of the Item Category Id field.';
                ApplicationArea = All;
            }

        }
        modify("Assembly BOM")
        {
            Visible = false;

        }
        modify("Substitutes Exist")
        {
            Visible = false;

        }
        modify("Default Deferral Template Code")
        {
            Visible = false;

        }
        modify("Vendor No.")
        {
            Visible = false;

        }


    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}