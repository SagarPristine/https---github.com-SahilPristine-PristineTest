pageextension 50124 AssemblyBom extends "Assembly BOM"
{
    layout
    {
        addafter("No.")
        {

            field(Stage; Rec.Stage)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Stage field.';
            }
        }
        modify(Position)
        {
            Visible = false;
        }
        modify("Installed in Item No.")
        {
            Visible = false;
        }
        modify("Assembly BOM")
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