
pageextension 50119 PurchSetup extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Posted SC Comp. Rcpt. Nos.")
        {
            field("Production Lot indicator"; Rec."Production Lot indicator")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Production Lot indicator field.';
            }
            field("Process Transfer Batch Name"; Rec."Process Transfer Batch Name")
            {
                ApplicationArea = all;
            }
            field("Process Transfer Template Name"; Rec."Process Transfer Template Name")
            {
                ApplicationArea = all;
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