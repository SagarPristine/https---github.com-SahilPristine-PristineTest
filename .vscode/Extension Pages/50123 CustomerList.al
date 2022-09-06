pageextension 50123 CustomerList extends "Customer List"
{
    layout
    {
        addafter("No.")
        {

            field("Customer Type"; Rec."Customer Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Type field.';
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