pageextension 50126 SalesInvoice extends "Sales Invoice"
{
    layout
    {
        addbefore(status)
        {

            field(Season; Rec.Season)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Season field.';
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